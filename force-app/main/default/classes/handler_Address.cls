public class handler_Address
{
    public set<DECIMAL> countryIDS = new set<DECIMAL>();
    list<Address__C> addListToUpdate = new list<Address__C>(); 
    public void retreiveCountryIDDetails(List<Address__c> addList)   
    {
        for(Address__c addObj: addList)
        {
            if(addObj.CountryID__c != NULL)
            {
                countryIDS.add(addObj.CountryID__c);
                system.debug('this is countryIDS:-------->    '+countryIDS);
            }
        }    
        
       List<Expense__c> expList = [Select id,CountryID__c,Client__c from Expense__c where CountryID__c IN:countryIDS];   
        system.debug('this is expList :-------->    ' +expList );   
         
         if(expList.size()>0)
         {
             system.debug('inide expList'); 
             for(Expense__c expObj: expList)
             {
                system.debug('inide first for loop'); 
                for(Address__c addObj: addList)
                {
                    system.debug('inide second for loop'); 
                    if(addObj.CountryID__c == expObj.CountryID__c)  
                    {
                        system.debug('inide last if cond:'); 
                        addObj.Country__c = expObj.Client__c; 
                        addListToUpdate.add(addObj);
                        system.debug('this is addObj.Country__c:-------->    '+addObj.Country__c);   
                    }      
                }
                update addListToUpdate;
                system.debug('this is addListToUpdate:-------->    '+addListToUpdate);
                
             }            
         }         
    } 
}