global class batch_BirthdayWishes implements Database.Batchable<sObject>,Database.Stateful,Schedulable
{   
    //VARIABLES
    Date dateToday = system.Today();
    Integer year = dateToday.year();
    Integer month = dateToday.month();
    Integer day = dateToday.day();
    
    //START METHOD
    global Database.QueryLocator start(Database.BatchableContext BC)
    {  
        string query = 'SELECT Id,Name,Birthdate__c,email__c FROM Employee__c WHERE Birthdate__c != NULL AND DAY_IN_MONTH(Birthdate__c)=' + dateToday.day() +  ' AND CALENDAR_MONTH(Birthdate__c) = ' + dateToday.month(); 
        if(query != null)
        {
            system.debug('inside if');
            return Database.getQueryLocator(query);
        }
        else
        return null;
    }
   
    //EXECUTE METHOD
    global void execute(Database.BatchableContext BC,List<Employee__c> scope)
    { 
        List<String> employeeEmailAddresses = new List<String>();
        for(Employee__c empObj: scope)
        {
            employeeEmailAddresses.add(empObj.Email__c);
            sendBirthdayWishes(employeeEmailAddresses,scope); //calling method to send birthday wishes to an employee
        }            
    }
    
    //METHOD TO SEND AN EMAIL TO EMPLOYEE REGARDING BIRTHDAY WISHES
    public void sendBirthdayWishes(List<String> toAddresses,List<Employee__c> empList){
        List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
        
        for(Employee__c empObj : empList)
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setSenderDisplayName('Birthday Wishes');        
            mail.setToAddresses(toAddresses);
            mail.setSubject('HAPPY BIRTHDAY ! ');
            mail.setSaveAsActivity(false);
            //mail.setHtmlBody(emailbody);
            allMails.add(mail);
        }
        system.debug('this is allMails size: ' +allMails.size());
        Messaging.sendEmail(allMails, false);    
        System.debug('You have made ' + Limits.getEmailInvocations() + ' email calls out of ' + Limits.getLimitEmailInvocations() + ' allowed'); 
    }
      
    //FINISH METHOD
    global void finish(Database.BatchableContext BC)
    {   
        AsyncApexJob a = [SELECT Id,Status,NumberOfErrors,JobItemsProcessed,TotalJobItems,CreatedBy.Email 
                          FROM AsyncApexJob WHERE Id =:bc.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'pingle.subodh@gmail.com'};
		mail.setToAddresses(toAddresses);
        mail.setSubject('batch_BirthdayWishes - Status: ' +a.Status);
        mail.setPlainTextBody('Total Records Processed are:  ' + a.TotalJobItems +   'with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
    
    public void execute(SchedulableContext sc)
    {
        //batchUpdateYear theBatch = new batchUpdateYear();
        //Database.executeBatch(theBatch);
        
        //String cron = '0 0 10 1 1 ? nextYear ' ;
        //System.schedule('Testing', cron, theBatch );
    }
}