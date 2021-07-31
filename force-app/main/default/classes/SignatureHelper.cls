public with sharing class SignatureHelper {
    
    @AuraEnabled
    public static ContentVersion saveSign(String signature){

        ContentVersion cont = new ContentVersion();
        cont.title = 'Signature';
        cont.PathOnClient = 'Signature.png';
        cont.VersionData = EncodingUtil.base64Decode(signature);
        cont.FirstPublishLocationId = '0017F00000OKnEGQA1';
        insert cont;
        return cont;        
    }
}