public class WarehouseSyncSchedule implements schedulable 
{
  // implement scheduled code here

  public void execute(SchedulableContext sc)
  {
  	
  		WarehouseCalloutService.runWarehouseEquipmentSync();
  	
  }
}