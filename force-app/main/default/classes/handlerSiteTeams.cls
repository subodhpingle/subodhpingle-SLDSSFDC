public class handlerSiteTeams{
    public class applicationException extends Exception {}
    
    public static void mapSiteTeamToRelatioship(List<Site_Team__c> currentsiteTeams,Boolean isInsert,Map<Id,Site_Team__c> oldSiteteamsMap){            
        set<Id> associatedContactsIds = new set<Id>();
        set<Id> siteAccountsIds = new set<Id>();
        boolean isContactExist = false;
        boolean executeProcess = false;
        List<AccountContactRelation> existingContactList = new List<AccountContactRelation>();
        List<AccountContactRelation> accContactInsertList = new List<AccountContactRelation>();
        
        for(Site_Team__c siteTeamObj : currentsiteTeams){
            if(isInsert){
                if(siteTeamObj.Associated_Contact__c != null){
                    executeProcess = true;
                }
            }
            else{
                if(siteTeamObj.Associated_Contact__c != null 
                   && (siteTeamObj.Associated_Contact__c != oldSiteteamsMap.get(siteTeamObj.Id).Associated_Contact__c)){
                       executeProcess = true;
                   }
            }
            if(executeProcess){
                associatedContactsIds.add(siteTeamObj.Associated_Contact__c);
                siteAccountsIds.add(siteTeamObj.Site_Account__c);
            }
        }
        existingContactList = [SELECT Id,ContactId,AccountId,Contact.Account.Id FROM AccountContactRelation 
                               WHERE ContactId IN : associatedContactsIds 
                               AND AccountId IN : siteAccountsIds];
        if(!existingContactList.isEmpty()){
            isContactExist = true;
            //DONT DO ANYTHING
        }
        else{
            isContactExist = false;
            //create AccountContactRelationship record
        }
        
        //if contact doesnt exist then create AccountContactRelationship record     
        if(!isContactExist){
            for(Site_Team__c siteTeamInsert : currentsiteTeams){
                AccountContactRelation accContactRelationInsert = new AccountContactRelation();
                accContactRelationInsert.AccountId = siteTeamInsert.Site_Account__c;
                accContactRelationInsert.ContactId = siteTeamInsert.Associated_Contact__c;
                accContactInsertList.add(accContactRelationInsert);
            }
            try{
                insert accContactInsertList;
            }
            catch(DMLException de){
                Integer numErrors = de.getNumDml();
                System.debug('This is getNumDml :=	' + numErrors);
                throw new applicationException(de.getMessage());
            }
            catch(Exception de){
                Integer numErrors = de.getNumDml();
                System.debug('This is getNumDml :=	' + numErrors);
                throw new applicationException(de.getMessage());
            }
        }
    }
}