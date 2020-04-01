public class handlerExpenses
{
    //maps
    set<id> oppIds = new set<ID>();
    set<id> oppIds1 = new set<ID>();
    list<Opportunity> oppList = new list<Opportunity>();
    list<Opportunity> oppList1 = new list<Opportunity>();
    
    public void updateOpportunity(list<expense__c> currentListOfExpenses)
    {
        for(Expense__c exp: currentListOfExpenses)
        {
            if(exp.Opportunity__c != null && exp.Type__c == 'Contract Flow Down/Handoff' && exp.DocumentAttached__c == True) 
            {
                   oppIds.add(exp.Opportunity__c); 
                   system.debug('this is oppIDs' +oppIds);
            }
            
            if(exp.Opportunity__c != null && (exp.Type__c != 'Contract Flow Down/Handoff' || exp.DocumentAttached__c != True)) 
            {
                   oppIds1.add(exp.Opportunity__c); 
                   system.debug('this is oppIDs1' +oppIds1);
            }
        }
        
        oppList = [select id,name,HandoffAttached__c from Opportunity where id in: oppIds];
        system.debug('this is oppList' +oppList);
        
        if(oppList.size()>0)
        {
            for(Opportunity opp: oppList)
            {
                opp.HandoffAttached__c ='Yes' ;
            } 
            
            update oppList;
            system.debug('this is updated oppList' +oppList);
                         
        }   
        
        oppList1 = [select id,name,HandoffAttached__c from Opportunity where id in: oppIds1];
        system.debug('this is oppList1' +oppList1);
        
        if(oppList1.size()>0)
        {
            for(Opportunity opp: oppList1)
            {
                opp.HandoffAttached__c = 'No';
            } 
            
            update oppList1;
            system.debug('this is updated oppList1' +oppList1);             
        }       
    }
}