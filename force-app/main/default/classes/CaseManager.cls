@RestResource(urlMapping='/Case/*')
global with sharing class CaseManager
{
	@HttpGet
	global static Case getCaseById()
	{
		RestRequest request =RestContext.request;
		String caseId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
		Case result = [SELECT CaseNumber,Subject,Status,Origin,Priority FROM Case WHERE Id=:caseId];
		return result;
	}

	@HttpPost
	global static Id createCase(String subject,String status,String priority,String origin)
	{
		Case newCase = new Case(Subject=subject,Status=status,Origin = origin, Priority = priority);
		insert newCase;
		return newCase.Id;
	}

	@HttpDelete
	global static void deleteCase()
	{
		RestRequest request = RestContext.request;
		String caseId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
		Case thisCase = [SELECT Id FROM Case WHERE Id=:caseId];
		Database.DeleteResult dr = Database.delete(thisCase);
	}

	@HttpPut
	global static Id upsertCase(String subject,String status,String priority,String origin, String caseId)
	{
		Case newCase = new Case(Subject=subject,Status=status,Origin = origin, Priority = priority, Id = caseId );
		upsert newCase;
		return newCase.Id;
	}
	@HttpPatch
	global static Id updateCaseFields()
	{
		RestRequest request = RestContext.request;
		String caseId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
		Case thisCase = [SELECT Id FROM Case WHERE Id =:caseId];
		Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
		for(String fieldName:params.keySet())
		{
			thisCase.put(fieldName,params.get(fieldName));
		}
		update thisCase;
		return thisCase.Id;
	}




	
}