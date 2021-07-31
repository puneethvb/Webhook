public with sharing class FileDownloadController {
    
    @AuraEnabled(cacheable=true)
    public static Map<Id,String> fetchFileDetails(String parentId){

        Set<Id> fileIds = new Set<Id>();
        Map<Id,String> filesList = new Map<Id,String>();

        try {
            for(ContentDocumentLink cdl : [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :parentId]){
                fileIds.add(cdl.ContentDocumentId);
            }

            if(!fileIds.isEmpty()){
                for(ContentVersion cont : [SELECT ContentDocumentId, Title, FileExtension FROM ContentVersion WHERE ContentDocumentId IN :fileIds]){
                    filesList.put(cont.ContentDocumentId,cont.Title);
                }
            }

            return filesList;

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


}