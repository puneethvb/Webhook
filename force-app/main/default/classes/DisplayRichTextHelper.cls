public with sharing class DisplayRichTextHelper {

    @AuraEnabled
    public static String generatePDF(String pdfData){
        String returnId;
        PageReference ref = Page.DisplayPDFVf;
        ref.getParameters().put('displayText',pdfData);
        ContentVersion cVer = new ContentVersion();
        cVer.versionData = ref.getContentAsPdf();
        cVer.title = 'Attch'+Math.random();
        cVer.pathOnClient = '/'+cVer.title+'.pdf';
        try{
            insert cVer;
            returnId = [SELECT contentDocumentId FROM ContentVersion WHERE Id = :cVer.Id].contentDocumentId;
        }

        catch(Exception ex){
          System.debug(ex.getMessage());   
        }
         return returnId;
    }
}