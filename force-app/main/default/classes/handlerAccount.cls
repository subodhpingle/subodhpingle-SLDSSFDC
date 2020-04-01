public class handlerAccount
{
    set<id> accIds = new set<id>();
    set<id> OwnerId = new set<id>();
    set<string> name = new set<string>();
    set<String> addressNames  = new set<String>();
    set<String> accNumbers = new set<String>();
    set<String> ExistingAccNumbers = new set<String>();
    
    Set<String> NameSet = new Set<String>();
    Set<String> accountNumberSet = new Set<String>();
    List<Account> duplicateAccList = new List<Account>();
    list<Account> originalAccList = new list<Account>();
    
    list<Contact> conList = new list<Contact>();
    list<Account> dupList = new list<Account>();
    
    map<ID,Account> accIDSMap = new map<ID,Account>(); 
    map<String,Account> accNumberMap= new map<String,Account>();    
    map<ID,Account> originalAcc = new map<ID,Account>();
    map<ID,Address__c> addObjMap = new map<ID,Address__c>();
    
    Boolean isDupAccUpdated = false;
    
    public void changeContactOwner(List<Account> currentListOfAccount)
    {
        for(account a: currentListOfAccount)
        {
            if(a.OwnerID != null)
            {
                OwnerId.add(a.OwnerID);
                accIds.add(a.id);
            }
        }
        
        conList = [select id,name,AccountID,Account.OwnerID from Contact where AccountID in: accIds];
        system.debug('this is conList:- ' +conList);
        
        if(conList.size()>0 || conList.size() != null)
        {
            for(Contact c: conList)
            {
                    c.ownerID = c.Account.OwnerId;
                    system.debug('this is c.ownerID:- ' +c.ownerID);
            }
            
            //update conList;
            system.debug('this is conList:- ' +conList);
        }
    }
    
    public void updateContact(list<Account> accList)
    { 
        for(Account a: accList)
        {
            accIDSMap.put(a.ID,a);
            system.debug('this is accIDSMap:- ' +accIDSMap.keyset());
        }
        
        conList = [select ID,AccountID from Contact where accountID in: accIDSmap.keyset()];
        
        if(conList.size()>0)
        {
            for(Contact con : conList) 
            {
                con.lastName = accIDSmap.get(con.AccountID).Name;
                system.debug('this is con.lastName:- ' +con.lastName);
            }   
        }
    }
    
    public void restrictAccountDeletion(list<Account> currentListOfAccount )
    {
        for(account a: currentListOfAccount)
        {
            accIds.add(a.id);
        }
        for(Contact conObj : [SELECT ID,AccountID,Sex__c from Contact where AccountID in: accIds and Sex__c = 'Male'])
        {
            for(Account a : currentListOfAccount)
            {
                a.addError('INSUFFICIENT PRIVILEDGES !');
            }
        }
    }   
    
    
    public void populateAddressDetails(list<Account> currentListOfAccount,Map<ID,Account> accOldMap)
    {    
        for(Account accObj: currentListOfAccount)   
        {
              addressNames.add(accObj.Address__r.Name); 
              system.debug('addressNames are:-    ' +addressNames);           
        } 
        
        List<Address__c> addList = [SELECT ID,name from Address__c where name in: addressNames];
        system.debug('addList are:-    ' +addList );
        
        if(addList.size()>0)
        {
            system.debug('inside if :-    ' +addList );
            for(Address__c addObj: addList)
            {
                addObjMap.put(addObj.ID,addObj);
                system.debug('addObjMap keyset are is  :-    ' +addObjMap.keyset());
                system.debug('addObjMap values are is  :-    ' +addObjMap.values());
            }
            
            if(addObjMap.keyset()!= null)
            {
                for(Account accObj: currentListOfAccount)
                {
                    if(addObjMap.containsKey(accObj.Address__c))
                    {
                        accObj.temp_max__c =  string.ValueOf(addObjMap.get(accObj.Address__c).CountryID__c);        
                    }
                }    
            }
        }
    } 
    
    public void checkDuplicateRecords(list<Account> currentListOfAccounts)
    {
        for(Account accObj : currentListOfAccounts){            
            NameSet.add(accObj.Name); 
            accountNumberSet.add(accObj.AccountNumber);
         }
         
        if(!NameSet.isEmpty() || !accountNumberSet.isEmpty())
        {
            duplicateAccList = [SELECT ID,Name,AccountNumber,is_Duplcate__c,Duplicate_URL__c,Duplicate_Of__c from ACCOUNT 
                            where is_Duplcate__c = False AND Name IN :NameSet AND AccountNumber IN : accountNumberSet];
        
        //SCENARIO 1: When duplicate accounts FOUND then update duplicate records with some values
        if(!duplicateAccList.isEmpty()){
            for(Account accDup : currentListOfAccounts){
                if(accDup.ID != duplicateAccList[0].ID){
                        accDup.is_Duplcate__c = TRUE;
                        accDup.Duplicate_URL__c = 'https://'+System.URL.getSalesforceBaseURL().getHost()+ '/' + duplicateAccList[0].ID; 
                        accDup.Account__c = duplicateAccList[0].ID;
                    }
                }
            }
            
        //SCENARIO 2: When duplicate accounts NOT FOUND then update duplicate records with NULL VALUE  
        else{
            for(Account accDup : currentListOfAccounts){
                    accDup.is_Duplcate__c = FALSE;
                    accDup.Duplicate_URL__c = '';
                    accDup.Account__c = null;
                }    
            }   
        } 
        else
        {
        //SCENARIO 3: When USER edits the original account then related all duplicate accounts should be removed as "duplicate"
            for(Account accObj : currentListOfAccounts){
                if(accObj.is_Duplcate__c == False){
                    accIDSMap.put(accObj.ID,accObj);
                } 
            }
            duplicateAccList = [SELECT ID,name,is_Duplcate__c,Account__c from Account 
                                where is_Duplcate__c  = True and Account__c != null and Account__c in: accIDSMap.keyset()];
            List<Account> accUpdateList = new List<Account>();
            
            if(!duplicateAccList.isEmpty()){
                for(Account acc: duplicateAccList){
                   if(acc.Name != accIDSMap.get(acc.Account__c).Name){
                       acc.is_Duplcate__c = FALSE;
                       acc.Duplicate_URL__c = '';
                       acc.Account__c = null;
                       accUpdateList.add(acc);
                   }
               }
            }
            if(!accUpdateList.isEmpty()){
                update accUpdateList;
            }    
        }
     }      //END OF METHOD
     
    public boolean isFieldValueChanges(list<Account> currentListOfAccounts,Map<ID,Account> accOldMap)
    {
        Account gplObject = new Account(); //This takes all available fields from the required object. 
        Boolean isChanges = false;
        Schema.SObjectType objType = gplObject.getSObjectType(); 
        Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Account.fields.getMap(); 
        
        for(Account gpl : currentListOfAccounts)
        {
            Account oldGPL = accOldMap.get(gpl.Id);
            for (String str : mapFields.keyset()) 
            { 
                    if(gpl.get(str) != oldGPL.get(str))
                    { 
                        System.Debug('IGORU Field changed: ' + str + '. The value has changed from: ' + oldGPL.get(str) + ' to: ' + gpl.get(str));
                    } 
            }
        }
        return true;
     }
     
     public void createSLA(List<Account> currentListOfAccounts){
         Map<Id,String> slaMap = new Map<Id,String>();
         List<Contact> conList = new List<Contact>();
         
         for(Account accObj : currentListOfAccounts){
             if(accObj.Skills__c != null){
                 slaMap.put(accObj.Id,accObj.Skills__c);
                 system.debug('this is slaMap :=' +slaMap);
             }
         }
         
         
     }
}