public class handlerFiles{
    public class FileException extends Exception {}
    public static void setFiles(List<ContentDocumentLink> ContentDocumentLinkList,Boolean isDelete){
        List<ContentDocumentLink> ContentDocumentLinkListInsert = new List<ContentDocumentLink>();
        List<ContentDocumentLink> ContentDocumentLinkListDelete = new List<ContentDocumentLink>();
        Map<Id,Id> ContentDocumentLinkMap = new Map<Id,Id>();
        Set<Id> childIds = new Set<Id>();
        
        //if FILE is Inserted
        if(!isDelete){
            for(ContentDocumentLink fileObj : ContentDocumentLinkList){
                ContentDocumentLinkMap.put(fileObj.LinkedEntityId,fileObj.ContentDocumentId);
            }
            if(ContentDocumentLinkMap != null){
                for(Contact conObj : [SELECT Id,AccountId FROM Contact WHERE AccountId IN : ContentDocumentLinkMap.keySet()]){
                    if(ContentDocumentLinkMap.containsKey(conObj.AccountId)){
                        ContentDocumentLink docLink = new ContentDocumentLink();
                        docLink.LinkedEntityId = conObj.Id ;
                        docLink.ShareType = 'V' ;
                        docLink.ContentDocumentId = ContentDocumentLinkMap.get(conObj.AccountId);
                        ContentDocumentLinkListInsert.add(docLink);
                    }
                }
            }
            if(!ContentDocumentLinkListInsert.isEmpty()){
                try{
                    insert ContentDocumentLinkListInsert; 
                }
                catch(DMLException de){
                    Integer numErrors = de.getNumDml();
                    System.debug('This is getNumDml :=  ' + numErrors);
                    throw new FileException(de.getMessage());
                }
            }
        }
        //if FILE is deleted
        else{
            for(ContentDocumentLink fileObj : ContentDocumentLinkList){
                ContentDocumentLinkMap.put(fileObj.LinkedEntityId,fileObj.ContentDocumentId);
            }
            if(ContentDocumentLinkMap != null){
                for(Contact conObj : [SELECT Id,AccountId FROM Contact WHERE AccountId IN : ContentDocumentLinkMap.keySet()]){
                    childIds.add(conObj.Id);
                }
                ContentDocumentLinkListDelete = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink 
                                                 WHERE LinkedEntityId IN : childIds 
                                                 AND ContentDocumentId IN : ContentDocumentLinkMap.values()];
                if(!ContentDocumentLinkListDelete.isEmpty()){
                    delete ContentDocumentLinkListDelete;
                }
            }
        }
    }
}