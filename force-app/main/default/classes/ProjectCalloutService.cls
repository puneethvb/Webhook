public class ProjectCalloutService {

	@InvocableMethod
	public static void postOpportunityToPMS(List<Id> oppIds) {

		Id jobId = System.enqueueJob(new QueueablePMSCall(oppIds[0]));
	}

	public class QueueablePMSCall implements System.Queueable,Database.allowsCallouts{

		Id opportunityId;

		public QueueablePMSCall(Id oppId){
			this.opportunityId = oppId;
		}

		public void execute(QueueableContext qc){

			ProjectCalloutService.performCallOut(opportunityId);
		}

	}

	@future(callout = true)
	public static void performCallOut(Id oId){

		List<Opportunity> oppList = [SELECT Id,Name,Account.Name,CloseDate,Amount FROM Opportunity 
		                             WHERE Id =:oid];
		ServiceTokens__c sToken = ServiceTokens__c.getValues('ProjectServiceToken');
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint('callout:ProjectService');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('token', sToken.Token__c);
		system.debug(sToken.Token__c);
		req.setBody(createJsonBody(oppList[0]));
		//req.setBody('{"opportunityId": "00641000004EKmFAAW","opportunityName": "Super-Duper Big Deal","accountName": "ACME Corp, Inc.","closeDate": "2016-10-30","amount": 150000}');

		HttpResponse resp = http.send(req);
		Opportunity opp = oppList[0];
		system.debug(resp.getStatusCode());

		if(resp.getStatusCode()==201){

			opp.StageName = 'Submitted Project';
		}
		else{
			opp.StageName = 'Resubmit Project';
		}

		update opp;
	}

	public static String createJsonBody(Opportunity opp){

		JSONGenerator gen = JSON.createGenerator(true);	
		gen.writeStartObject();
		gen.writeStringField('opportunityId',opp.Id);
		gen.writeStringField('opportunityName', opp.Name);
		String accName = opp.Account.Name;
		System.debug(accName);
		gen.writeStringField('accountName', accName);
		gen.writeStringField('closeDate', String.valueOf(opp.CloseDate));
		gen.writeNumberField('amount', Integer.valueOf(opp.Amount));
		gen.writeEndObject();

		String pretty = gen.getAsString();
		System.debug(pretty);
		return pretty;
	}


}