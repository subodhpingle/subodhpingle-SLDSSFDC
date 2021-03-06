public class CustomLookupAuraService 
{
	@AuraEnabled
    public static List<sObject> getRecordList(String ObjectName, String sreachText,String fieldInSearch)
    {
        String searchKey = '%' + sreachText + '%';
        String Query = 'SELECT Id, '+fieldInSearch;
        Query+=' FROM '+ObjectName;
        Query+=' WHERE '+fieldInSearch+' LIKE : searchKey';
        List<sObject> sObjectList = Database.query(Query);
        System.debug(' #### sObjectList '+sObjectList);
        return sObjectList;
    }
    
    @AuraEnabled
    public static Account updateExpense(Account inv)
    {
        system.debug('This is inv: '+inv);
        
        insert inv;
        return inv;
    }
}