public without sharing class GiveWorkThanksAction
{
	@InvocableMethod(label = 'Give a Thanks Badge')
	public static void giveWorkBadgeActionsBatch(List<GiveWorkThanksRequest> requests)
	{
		List<WorkThanks> listOfWorkThanks = new List<WorkThanks>();
		List<WorkBadge> listOfWorkBadge = new List<WorkBadge>();
		List<WorkThanksShare> listOfWorkThShare = new List<WorkThanksShare>();
		List<FeedItem> listOfPosts = new List<FeedItem>();
		WorkBadgeDefinition badgeDef;
		//Map<Id,Id> workThanksRecIdMap = new Map<Id,Id)();

		for(GiveWorkThanksRequest request: requests)
		{
			WorkThanks newWorkThanks = new WorkThanks();
			newWorkThanks.GiverId = request.giverId;
			newWorkThanks.Message = request.thanksMessage;
			newWorkThanks.OwnerId = request.giverId;
			//workThanksRecIdMap.put(request.recieverId,null);
			listOfWorkThanks.add(newWorkThanks);
			if(badgeDef==null)
			badgeDef = [SELECT Id, Name FROM WorkBadgeDefinition WHERE Name =:request.badgeName LIMIT 1];
		}

		if(listOfWorkThanks.size()>0)
		{
			insert listOfWorkThanks;

			for(WorkThanks thisThanks:listOfWorkThanks)
			{
				WorkBadge newWorkBadge = new WorkBadge();
				newWorkBadge.DefinitionId = badgeDef.Id;
				newWorkBadge.SourceId = thisThanks.Id;
				WorkThanksShare newWorkThanksShare = new WorkThanksShare();
				newWorkThanksShare.ParentId = thisThanks.Id;
				newWorkThanksShare.AccessLevel = 'Edit';
				FeedItem post = new FeedItem();
				post.CreatedById = thisthanks.GiverId;
				post.Body = thisthanks.Message;
				post.RelatedRecordId = thisthanks.Id;
				post.Type = 'RypplePost';


				for(GiveWorkThanksRequest request:requests)
				{
					if(request.giverId == thisThanks.GiverId && 
						request.thanksMessage == thisThanks.Message)
					{
						newWorkThanksShare.UserOrGroupId = request.receiverId;
						newWorkBadge.RecipientId = request.receiverId;
						post.ParentId = request.receiverId;
						break;
					}

				}
				listOfWorkBadge.add(newWorkBadge);
				listOfWorkThShare.add(newWorkThanksShare);
				listOfPosts.add(post);
			}

			insert listOfWorkBadge;
			insert listOfWorkThShare;
			insert listOfPosts;
		}
	}
	
	public class GiveWorkThanksRequest
	{
		@InvocableVariable(label ='Giver ID' required = true)
		public Id giverId;
		@InvocableVariable(label ='Receiver ID' required = true)
		public Id receiverId;
		@InvocableVariable(label ='Thanks Message' required = true)
		public String thanksMessage;
		@InvocableVariable(label ='Badge Name' required = true)
		public String badgeName;
	}
}