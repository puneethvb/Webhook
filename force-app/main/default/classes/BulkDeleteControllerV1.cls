public with sharing class BulkDeleteControllerV1 {
	
	public List<sObjWrapper> sObjWrapperList{get; Private set;}
	public String selectedString{get; set;}

	public class sObjWrapper
	{
		public SObject sObj{get; Private set;}
		public Object name{get;Private set;}
		public Boolean deleteThis{get;set;}

		public sObjWrapper(SObject so)
		{
			this.sObj = so;
			try
			{
				this.name = this.sObj.get('Name');
			}

			Catch(Exception e){}
		}
	}

	public BulkDeleteControllerV1()
	{
		this.sObjWrapperList = new List<sObjWrapper>();
	}

		public PageReference executeSelect()
		{
			try
			{
				loadData(Database.query(this.selectedString));
			}
			Catch(Exception e)
			{
				logError(e.getMessage());
			}
			return null;
		}

		private void loadData(List<SObject> queryResult)
		{
			this.sObjWrapperList = new List<sObjWrapper>();
			for(SObject s: queryResult)
			{
				this.sObjWrapperList.add(new sObjWrapper(s));
			}

		}

		public PageReference deleteSelected()
		{
			List<SObject> objToDelete = new List<SObject>();
			try
			{
				for(sObjWrapper dels: this.sObjWrapperList)
				{
					if(dels.deleteThis==true)
					{
						objToDelete.add(dels.sObj);
					}
				}
				Delete objToDelete;
				executeSelect();
			}
			Catch(Exception e)
			{
				logError(e.getMessage());
			}
			return null;
		}

		private void logError(String errorString)
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,errorString));
		}

}