public class Trial_Delete_popupController {
    private ApexPages.StandardController stdController;
    
    public Trial_Delete_popupController(ApexPages.StandardController stdController) {
        this.stdController = stdController;
    }
    
    public PageReference checkProfile(){

        Profile profileDet = [SELECT Id, Name FROM Profile WHERE ID = :userInfo.getProfileId() LIMIT 1];
        if(profileDet.Name.equalsignoreCase('system administrator')){

            return stdController.delete();

        }

        else{
            return null;
        }


    }
}