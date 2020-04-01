global class batchGenerateRandomRecords implements Database.Batchable<sObject>,Database.Stateful,Schedulable
{    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        string query = 'select id,AccountID from CASE';
                
        if(query != null)
        {
            system.debug('inside if');
            return Database.getQueryLocator(query);
        }
        else
        return null;
    }
    
    global void execute(Database.BatchableContext BC,List<CASE> scope)
    {  
           for(CASE caseObject :scope)                                                   
           {
                if(caseObject.AccountID != null)
                {
                     system.debug('inside execute');
                     
                                         
                }
           }
     }      
     
     global void finish(Database.BatchableContext BC)
     {
    
            AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                              FROM AsyncApexJob
                              WHERE Id = :bc.getJobId()];
          
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'subodh-sunil.pingle@capgemini.com'};
            mail.setToAddresses(toAddresses);
            mail.setSubject('batchGenerateRandomRecords - Status: ' +a.Status);
            mail.setPlainTextBody('Total Records Processed are:  ' + a.TotalJobItems +   'with '+ a.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
     }  
     
     public void execute(SchedulableContext sc)
     {
        batchGenerateRandomRecords theBatch = new batchGenerateRandomRecords();
        Database.executeBatch(theBatch);
        
        //String cron = '0 0 9 1 1 ? nextYear ' ;
        //System.schedule('Testing', cron, theBatch );
     }  
}