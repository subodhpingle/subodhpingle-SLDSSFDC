public class multiSelectPicklist 
{
    public static outboundemail sendEmails = new outboundemail();
    public static list<String> empNames = new list<String>();
    public static list<String> empEmails = new list<String>();
    public static Integer pendingAmount;
    public static String emailbody;
    
	/*@AuraEnabled
    public static List <String> getPiklistValues() 
    { 
        list<String> mulValues = new list<String>();
        for(Employee__c emp : [SELECT ID,Name,EmployeeID__c,email__c from Employee__c])
        {
            mulValues.add(emp.name);
        }	
        return mulValues;
    }
	*/
    @AuraEnabled
    public static List<Employee__c> getPiklistValues(String searchKeyWord, String ObjectName, List<Employee__c> ExcludeitemsList)
    {
    	String searchKey = '%' + searchKeyWord + '%';
        List<Employee__c> returnList = new List<Employee__c>();
        
        List<string> lstExcludeitems = new List<string>();
        for(Employee__c item : ExcludeitemsList)
        {
            lstExcludeitems.add(item.id);
            system.debug('lstExcludeitems are:	' +lstExcludeitems);
        }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery =  'select id, Name from Employee__c where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List<Employee__c> lstOfRecords = Database.query(sQuery);
        
        for (Employee__c obj: lstOfRecords) {
            returnList.add(obj);
            system.debug('returnList are:	' +returnList);
        }
        return returnList; 
    }
    
    @AuraEnabled
    public static void updateExpense(Expense__c inv,List<String> selectedEmployees)
    {
        pendingAmount = Integer.valueOf(inv.Total_Amount__c) / selectedEmployees.size();
        inv.Amount__c = String.valueOf(pendingAmount);
        inv.Client__c = String.valueOf(selectedEmployees);
        
        if(selectedEmployees != null)
        {
        	for(String strEmp: selectedEmployees)
            {
                empNames.add(strEmp);
            }    
        }
        if(empNames != null)
        {
            for(Employee__c emp: [SELECT ID,Name,EmployeeID__c,email__c from Employee__c where name IN :empNames])
            {
                empEmails.add(emp.email__c);
            }
    	}
        insert inv;
        if(inv != null)
        {
            emailbody = 'Dear '+empNames +',\n\nExpense' +inv.name+ 'has been created  '; 
            emailbody += '\n' ;  
            emailbody += 'Description:	' +inv.description__c; 
            emailbody += '\n' ;
            emailbody += 'Pending Amount: ' +pendingAmount;
            emailbody += '\n' ; 
            emailbody += '\n' ;
            emailbody += '\n' ;
            
            //sending email to respective selected employees
        	sendEmails.myEmail(pendingAmount,empNames,empEmails,emailbody);	
        }
    }
}