public class handlerContact
{
    //sets,lists
    set<id> accIDs = new set<id>();
    set<id> accIDs1 = new set<id>();
    set<id> OwnerID = new set<id>();
    list<account> accList = new list<account>();
    list<account> accList1 = new list<account>();
    list<account> accListUpdate = new list<account>();
    list<Opportunity> oList = new list<Opportunity>();
    list<contact> conlist= new list<contact>();
    map<ID,Contact> conMap = new map<ID,Contact>();
    
     //maps
     map<id,decimal> male = new map<id,decimal>();
     map<id,decimal> female = new map<id,decimal>();
     map<id,decimal> total = new map<id,decimal>();
     //map<id,Contact> onwerID = new map<id,Contact>();  
     map<String,ID> accMap = new map<String,ID>();
     map<ID,Contact> accMap1 = new map<ID,Contact>();
     
     String newStr; 
     handlerTasks handler = new handlerTasks();
   
    
    public void countMaleFemaleContacts(List<Contact> currentListOfContact)
    {
         for(Contact c: currentListOfContact)
         {
             if(c.AccountID != null)
             {
                 accIds.add(c.AccountID);
                 system.debug('this is acIs:- ' +accIds);
             }
         }
         //aggregateFunction for MALE
         for(AggregateResult ar:[select AccountID i,count(id)cnt from contact where AccountID =:accIds and sex__c = 'Male' group by AccountID ]) 
         {
             system.debug('inside aggregate function for male:- ' +ar);
             male.put((ID)ar.get('i'),(decimal)ar.get('cnt')); 
         }
         //aggregateFunction for FEMALE
         for(AggregateResult ar:[select AccountID i,count(id)cnt from contact where AccountID =:accIds and sex__c = 'Female' group by AccountID ]) 
         {
             system.debug('inside aggregate function for female:- ' +ar);
             female.put((ID)ar.get('i'),(decimal)ar.get('cnt')); 
         }
         //aggregateFunction for TOTAL CONTACTS
         for(AggregateResult ar:[select AccountID i,count(id)cnt from contact where AccountID =:accIds group by AccountID]) 
         {
             total.put((ID)ar.get('i'),(decimal)ar.get('cnt')); 
         }
         
         accList = [select id,mala__c,female__c,total__c from Account where id in: accIDs];
         
         for(Account a: accList)
         {
             a.mala__c = male.get(a.ID);
             a.female__c = female.get(a.ID);
             a.total__c = total.get(a.ID);
         }
         update accList;
    }
    
    public void changeAccountOwner(List<Contact> currentListOfContact)
    {
        for(Contact con: currentListOfContact)
        {
            if(con.OwnerID != null)
            {
                OwnerID.add(con.OwnerID);
                accIDs1.add(con.AccountID);
                system.debug('this is ownerID: ' +OwnerID );
            }            
        }
        accList1 = [select id,name,OwnerID ,(select id,OwnerID,name from Contacts) from Account where OwnerId !=: OwnerID and id =:accIds1];
        system.debug('this is accList1: ' +accList1);
        
        if(accList1.size()>0 || accList.size()!= null)
        {
            for(Account acc: accList1)
            {
                system.debug('this is accList1 ownerID: ' +acc.OwnerID);
                for(Contact con: acc.Contacts)
                {
                    system.debug('this is con: ' +con);
                    acc.OwnerID = con.OwnerID;
                    system.debug('this is acc.OwnerID: ' +acc.OwnerID);
                }
            }
            update accList1;
        }
    }
    
    public void createOpportunity(List<Contact> currentListOfContact)
    {
        for(contact c: currentListOfContact)
        {
             if(c.AccountId != null) 
             {
                 accIds.add(c.AccountID);
                 system.debug('this is acIds:- ' +accIds);
             } 
        }   
        for(Contact con: [select id,name,AccountID from contact where accountId in: accIds])
        {
            opportunity o = new opportunity();
            o.name = 'Test Opportunity' +con.name;
            o.closeDate = date.today();
            o.AccountID = con.AccountId;
            o.StageName = 'Closed Won';
            oList.add(o);
        }
        
        if(olist.size()>0)
        {
          try
          {
              insert oList;  
              system.debug('this is oList:- '+oList); 
          } 
          catch(DMLException de)
          {
              system.debug('oList failed:- '+de.getMessage()); 
          }
        }  
    }
    
    public void setBillingShippingInAcc(List<Contact> currentListOfContact)
    {
        for(Contact con: currentListOfContact)
        {
            if(con.AccountID != null && con.MailingAddress != null)
            {
               accIds.add(con.AccountID); 
               system.debug('this is acIds:- ' +accIds);
            }
        }
        
        Map<ID,Account> accMap = new map<ID,Account>([SELECT ID,name from account where ID in: accIds]);
        for(Contact con : currentListOfContact)
        {
            if(accMap.containsKey(con.AccountID)){
                if(con.Is_Default_Billing__c == true){
                    Account acc = accMap.get(con.accountID);
                    acc.billingStreet = con.MailingStreet;
                    acc.billingState = con.MailingState;
                    acc.billingPostalCode = con.MailingPostalCode;
                    accListUpdate.add(acc);
                }
                else if(con.Is_Default_Shipping__c == true)
                {
                    Account acc = accMap.get(con.accountID);
                    acc.ShippingStreet = con.MailingStreet;
                    acc.shippingState = con.MailingState;
                    acc.shippingPostalCode = con.MailingPostalCode;
                    accListUpdate.add(acc);    
                }
            }
        }
        update accListUpdate;
    }
    
    
    
    
  /* public void changeAccountRating(list<Contact> conList,Map<Id,Contact> oldMap)
  {
        for(Contact con: conList) 
        {
            if(con.sex__c != null && 
              (con.LastName != oldMap.get(con.ID).Lastname || con.FirstName != oldMap.get(con.ID).Firstname))
            {
                accIDs.add(con.AccountID);     
            }    
        }
        
        AccList1 = [SELECT ID,rating,INDUSTRY,(SELECT id,LastNAme,FirstNAme,accountID from Contacts) from account WHERE ID in: AccIDS];
        if(accList.size()>0)
        {
            for(Account a: AccList1)
            {
                for(Contact c: a.Contacts)
                {
                   a.Rating = c.LastName;
                   a.Industry =  c.FirstName;
                }
            }
            update accList1;
       }        
    }
  */      
    
    
    // this method is used to fetch account ID with respective of Account name
    /*public string getAccountID(list<SObject> newList)
    {
        String rt;
        
        String AccountIDToReturn;
        for(SObject obj: newList)
        {
            String AccountID = (String)obj.get('AccountID');
            system.debug('AccountID is:-    '+AccountID );
            if((Contact)obj.get('AccountID')!= null)
            {
                accMap1.put(AccountID ,(Contact)Obj);
                system.debug('accMap1 keyset are :-    ' +accMap1.keyset());    
            }
        }
        
        List<Account> accList1 = [SELECT ID,Rating from account where id in: accMap1.keyset()];  
        if(accList1.size()>0)
        {
            for(Account a: accList1)
            {
                rt = a.Rating;
            }    
        }
            return rt;
     }
  */ 
  
  public void checkDuplicateContact(list<Contact> conList)
  {
      set<String> emails = new set<String>();
      list<Lead> leadList = new list<Lead>();
           
      leadList = [SELECT ID,EMAIL FROM LEAD];
      if(!leadList.isEmpty())
      {
          for(Lead l : leadList)
          {
              emails.add(l.email);  
              system.debug('this is emails: ' +emails);   
          } 
      }
      for(Contact c : conList)
      {
          if(c.email != null && emails.Contains(c.email))
          {
              system.debug('this is c ' +c); 
              c.addError('Lead with same email address already exists. ');            
          }
      }
  }
    
    public void populatePrimaryContact(List<Contact> currentContactList){
        Map<Id,Contact> accIdsMap = new Map<Id,Contact>();
        
        for(Contact conObj : currentContactList){
            if(conObj.IsPrimary__c == true || conObj.IsPrimary__c == false){
                accIdsMap.put(conObj.AccountId,conObj);
            }
        }
        if(!accIdsMap.KeySet().isEmpty()){
            updateAccountsWithPrimaryContacts(accIdsMap);   
        }
    }          
    public void updateAccountsWithPrimaryContacts(Map<Id,Contact> accIdsMap){
        List<Account> accListToUpdate = new List<Account>();
        List<Contact> conToUpdate = new List<Contact>();
        Boolean updateContact = false;
        
        for(Account accObj : [SELECT Id,Primary_Contact__c FROM Account WHERE Id IN : accIdsMap.KeySet()]){
            if(accObj.Primary_Contact__c == NULL){
                accObj.Primary_Contact__c = accIdsMap.get(accObj.Id).LastName;
                accListToUpdate.add(accObj);
            }
            else if(accObj.Primary_Contact__c != NULL && accIdsMap.get(accObj.Id).isPrimary__c == true){
                accObj.Primary_Contact__c = accIdsMap.get(accObj.Id).LastName;
                accListToUpdate.add(accObj);
                updateContact = true;
            }
            else if(accIdsMap.get(accObj.Id).LastName == accObj.Primary_Contact__c && accIdsMap.get(accObj.Id).isPrimary__c == false){
                accObj.Primary_Contact__c = '';
                accListToUpdate.add(accObj);
            }
        }
        update accListToUpdate;
        
       if(updateContact){
            for(Contact conObjUpdate : [SELECT Id,AccountId,isPrimary__c,LastName,Account.Primary_Contact__c FROM Contact 
                                        WHERE isPrimary__c = true AND Account.Primary_Contact__c != NULL AND AccountId IN : accIdsMap.KeySet()]){
                                            if(conObjUpdate.Account.Primary_Contact__c != conObjUpdate.LastName){
                                                conObjUpdate.isPrimary__c = false;
                                                conToUpdate.add(conObjUpdate);
                                            }
                                        }
            update conToUpdate;
    	}
	}
}