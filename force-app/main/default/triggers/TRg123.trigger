trigger TRg123 on Trials__c (before delete) {

Profile profileDet = [SELECT Id, Name FROM Profile WHERE ID = :userInfo.getProfileId() LIMIT 1];
        if(!profileDet.Name.equalsignoreCase('system administrator')){
        Trigger.old[0].Adderror('Too bad!!! cant do it');
        }

}