public with sharing class BulkDeleteControllerV2 {
	public List<wrapperObj> wrapperObjList{get; Private set;}
	public List<SelectOption> sObjList {get;Private set;}
	public String selectedObject{get;set;}
	public Boolean hasName{get;Private set;}

	public class wrapperObj
	{
		public SObject sObj{get;Private set;}
		public Object name{get; Private set;}
		public Boolean deleteThis{get;set;}

		public wrapperObj(SObject so)
		{
			this.sObj = so;
			try
			{
				this.name = this.sObj.get('Name');
			}
			Catch(Exception e){}
		}
	}

	public BulkDeleteControllerV2() 
	{
		this.wrapperObjList = new List<wrapperObj>();
		prepareObjList();
		
	}

	private void prepareObjList()
	{
		this.sObjList = new List<SelectOption>();
		this.sObjList.add(new SelectOption('None','--None--'));
		Map<String,Schema.SObjectType> objMap = Schema.getGlobalDescribe();
		List<String> objList = new List<String>(objMap.keySet());
		objList.sort();

		for(String objName: objList)
		{
			if(objMap.get(objName).getDescribe().isAccessible() && objMap.get(objName).getDescribe().isUpdateable())
			this.sObjList.add(new SelectOption(objName,objMap.get(objName).getDescribe().getLabel()));
			this.selectedObject = 'None';
		}		
	}

	public PageReference executeselect()
	{
		this.wrapperObjList = new List<wrapperObj>();
		if(this.selectedObject!='None' && this.selectedObject!=null)
		{
			try
			{
				String fieldlist = 'Id';
				if(doesFieldExist(this.selectedObject,'Name'))
				{
					this.hasName = true;
					fieldlist += ', Name';
				}
				
				String querytoExecute = 'SELECT ' + fieldlist + ' FROM ' + selectedObject + ' LIMIT 100';
				loadData(Database.query(querytoExecute));
			}

			Catch(Exception e)
			{
				logerror(e.getMessage());
			}
		}

		return null;//////

	}

	private Boolean doesFieldExist(String objtoCheck, String fieldtoCheck)
	{
		List<Schema.SObjectField> fieldObjs = Schema.getGlobalDescribe().get(objtoCheck).getDescribe().fields.getMap().values();
		Set<String> fieldlist = new Set<String>();
		for(Schema.SObjectField s: fieldObjs)
		{
			fieldlist.add(s.getDescribe().getName());
		}
		return(fieldlist.contains(fieldtoCheck));

	}

	private void loadData(List<SObject> queryRes)
	{
		this.wrapperObjList = new List<wrapperObj>();
		
			for(SObject sobjwrap : queryRes)
			{
				this.wrapperObjList.add(new wrapperObj(sobjwrap));
			}

		
	}

	public PageReference deleteSelected()
	{
		List<SObject> objtoDelete = new List<SObject>();
		try
		{
			for(wrapperObj checkforDel: this.wrapperObjList)
			{
				if(checkforDel.deleteThis == true)
				objtoDelete.add(checkforDel.sObj);
			}
			Delete objtoDelete;
			executeselect();

		}
		Catch(Exception e)
		{
			logerror(e.getMessage());
		}
		return null;
		
	}

	public void logerror(String errorString)
	{
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,errorString));
	}


}