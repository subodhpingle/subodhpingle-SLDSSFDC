public class TH_Account
{
    public void handlerAfterUpdate(list<Account> accList,Map<Id,Account> oldMap)
    { 
        list<Contact> contacts = new list<Contact>();
        boolean abc = false ;
        
        for(Account accObj: accList)
        {
            if(accObj.Rating != null && oldMap.get(accObj.ID).Rating == null)
            {
                //first contact
                Contact conRec = new contact();
                conRec.lastname = 'test'+accObj.Rating; 
                conRec.AccountID = accObj.ID;  
                
                //second contact
                Contact conRec2 = new contact();
                conRec2.lastname = 'test'+accObj.Rating; 
                conRec2.AccountID = accObj.ID;
                
                //adding both contacts to Contact List
                contacts.add(conRec);   
                contacts.add(conRec2);   
            }
            //insert contact list
            insert contacts;  
        }    
    }
}