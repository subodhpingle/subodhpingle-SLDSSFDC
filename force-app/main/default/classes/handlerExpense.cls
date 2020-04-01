public class handlerExpense {
    
    //notify employees on insertion of Expense record
    public static outboundemail sendEmails = new outboundemail();
    public static list<String> empNames = new list<String>();
    public static list<String> empEmails = new list<String>();
    public static Integer pendingAmount;
    public static String empName;
    public static String description;
    public static String emailbody;
    public static boolean isExpendeUpdated = false;
    
    //notify employees on when any changes will be made on Expense Record
	public static void notifyEmployees(Boolean isInsert,List<Expense__c> expList,map<ID,Expense__c> oldExpMap) //,List<String> selectedEmployees,List<String> toEmpEmails,
    {
        if(!isInsert)
        {
            for(Expense__c exp : expList)
            {
                if((oldExpMap.get(exp.ID).Total_Amount__c != exp.Total_Amount__c) ||
               		(oldExpMap.get(exp.ID).Description__c != exp.Description__c) ||
               	    (oldExpMap.get(exp.ID).Client__c != exp.client__c))   
                	{
                        isExpendeUpdated = True ;
                        empNames = exp.client__c.trim().split(',');
                        description = exp.Description__c;
                        system.debug('empNames are: '+empNames);
                        pendingAmount = Integer.valueOf(exp.Total_Amount__c) / empNames.size();
                        exp.Amount__c = String.ValueOf(pendingAmount) ;
                	} 
        	}
            
            if(isExpendeUpdated)
            {  
            	for(Employee__c emp: [SELECT ID,Name,EmployeeID__c,email__c from Employee__c where Name IN: empNames])
            	{
                    empEmails.add(emp.email__c);
                    system.debug('empEmails is:	'+empEmails);
            	}  
                if(!empEmails.isEmpty())
                {
                    system.debug('empNames is:	'+empNames);
                    emailbody = 'Dear '+empNames +',\n\nExpense has been updated  '; 
                    emailbody += '\n' ;  
                    emailbody += 'Description:	' +description; 
                    emailbody += '\n' ;
                    emailbody += 'Pending Amount: ' +pendingAmount;
                    emailbody += '\n' ; 
                    emailbody += '\n' ;
                    emailbody += '\n' ;  
                    
                    //send emails to selected employees if any changes made
            		sendEmails.myEmail(pendingAmount,empNames,empEmails,emailbody);
                }
            }
        }
    }
}