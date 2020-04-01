public class handler_Address1
{
    map<Decimal,Address__c> countryIDS = new map<Decimal,Address__c>();
    list<Expense__c> addListToUpdate = new list<Expense__c>(); 
    public void retreiveCountryIDDetails(List<Address__c> addList)   
    {
        for(Address__c addObj: addList)
        {
            if(addObj.CountryID__c != NULL)
            {
                countryIDS.put(addObj.CountryID__c,addobj);
            }
        }    
        
       List<Expense__c> expList = [Select id,CountryID__c,Client__c from Expense__c where CountryID__c IN: countryIDS.keyset()];   
                        
       if(expList.size()>0)
       { 
             for(Expense__c expObj: expList)
             {
                for(Address__c addObj: addList)
                {
                    if(addObj.CountryID__c == expObj.CountryID__c)  
                    {
                        expObj.Client__c = addObj.Country__c; 
                        addListToUpdate.add(expObj);
                    }      
                }
                update addListToUpdate;            
             }            
         }         
    } 
}