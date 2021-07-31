public with sharing class WarehouseCalloutService
{
	public Class Equipments
	{
		public String id;
		public Integer cost;
		public Integer lifeSpan;
		public Integer maintenanceperiod;
		public String name;
		public Boolean replacement;
		public String sku;
        public Integer quantity;
	}

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync()
    {
    	Http http = new Http();
    	HttpRequest request = new HttpRequest();
    	request.setEndpoint(WAREHOUSE_URL);
    	request.setMethod('GET');
    	HttpResponse response = http.send(request);
    	if(response.getStatusCode()==200)
    	{
    		//System.debug(response.getBody());
    		//List<Object> result = (List<Object>)JSON.deserializeUntyped(response.getBody());
    		List<Equipments> equipmentList = new List<Equipments>();
    		equipmentList = (List<Equipments>)JSON.deserialize(response.getBody(),List<Equipments>.Class);
            System.debug(equipmentList);
            insertEquipRecords(equipmentList);

    	}
        
    }

    public static void insertEquipRecords(List<Equipments> equipmentList)
    {
        Set<String> skuSet = new Set<String>();
        List<Product2> equipmentListToUpdate = new List<Product2>();
        Map<String,Product2> skuEquipmentMap = new Map<String,Product2>();
        for(Equipments newEquipment: equipmentList)
        {
            skuSet.add(newEquipment.sku);
        }
        List<Product2> productList = [SELECT Cost__c,Current_Inventory__c,Lifespan_Months__c,Replacement_Part__c,
                                      Maintenance_Cycle__c,Warehouse_SKU__c,Name FROM Product2 WHERE Warehouse_SKU__c
                                      IN :skuSet ];
        for(Product2 newProduct: productList)
        {
            skuEquipmentMap.put(newProduct.Warehouse_SKU__c, newProduct);

        }

        for(Equipments newEquipment: equipmentList)
        {
            Product2 existingEquip = skuEquipmentMap.get(newEquipment.sku);
            if(existingEquip==null)
            {
                existingEquip = new Product2();
            }
            existingEquip.Cost__c = newEquipment.cost;
            existingEquip.Current_Inventory__c = newEquipment.quantity;
            existingEquip.Lifespan_Months__c = newEquipment.lifeSpan;
            existingEquip.Maintenance_Cycle__c = newEquipment.maintenanceperiod;
            existingEquip.Replacement_Part__c = true;
            existingEquip.Warehouse_SKU__c = newEquipment.sku;
            existingEquip.Name = newEquipment.name;
            equipmentListToUpdate.add(existingEquip);
        }

        if(equipmentListToUpdate.size()>0)
        upsert equipmentListToUpdate;

    }

}