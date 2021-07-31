trigger MaintenanceRequest on Case (before update, after update)
{
    
    MaintenanceRequestHelper.updateWorkOrders(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap,Trigger.isAfter);
}