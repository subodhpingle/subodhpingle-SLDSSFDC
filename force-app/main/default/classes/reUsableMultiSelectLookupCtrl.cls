public class reUsableMultiSelectLookupCtrl
{    
    public static outboundemail sendEmails = new outboundemail();
    public static list<String> empNames = new list<String>();
    public static list<String> empEmails = new list<String>();
    public static Integer pendingAmount;
    public static String emailbody;
    
    @AuraEnabled
    public static List<Employee__c> fetchLookUpValues(String searchKeyWord,String ObjectName,List<Employee__c> ExcludeitemsList,string fld)
    {
        String searchKey = '%' + searchKeyWord + '%';
        List<Employee__c> returnList = new List<Employee__c>();
 
        List<string> lstExcludeitems = new List<string>();
        for(Employee__c item : ExcludeitemsList)
        {
            lstExcludeitems.add(item.id);
        }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery =  'select id, Name from Employee__c where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List<Employee__c> lstOfRecords = Database.query(sQuery);
        
        for (Employee__c obj: lstOfRecords)
        {
            returnList.add(obj);
        }
        system.debug('this is lstExcludeitems: ' +lstExcludeitems);
        return returnList;
    }
    
    @AuraEnabled
    public static Expense__c updateExpense(Expense__c inv,List<Employee__c> selectedEmployees)	//,List<String> selectedEmployees
    {
        system.debug('This is inv: '+inv);
        system.debug('This is selectedEmployees: '+selectedEmployees);        
        
        insert inv;
        return inv;
    }
}