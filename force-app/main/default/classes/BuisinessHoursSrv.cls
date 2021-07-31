public with sharing class BuisinessHoursSrv {
    
    public static BusinessHours busHours {
        get{
            if(busHours == null){
                busHours = [SELECT Id FROM BusinessHours WHERE isDefault = true LIMIT 1];
            }
            return busHours;

        }
        set;
    }

    public static Boolean isWithin(Datetime inputTime){

        return BusinessHours.isWithin(busHours.Id,inputTime);

    }

    public static Datetime sLAEndDate(Integer sLAHours,Datetime inputTime){

        return BusinessHours.add(busHours.Id,inputTime,sLAHours*60*60*1000L);

    } 
}