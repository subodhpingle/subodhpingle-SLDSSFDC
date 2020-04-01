trigger triggerExpense on Expense__c (after insert,after update,after delete,after undelete,before insert,before update) 
{
    if((trigger.isAfter) && (trigger.IsInsert || trigger.IsUpdate || trigger.isUndelete))
    {
        //handlerExpenses handler = new handlerExpenses();
        //handler.updateOpportunity(trigger.new);
    }
    
    if((trigger.isBefore) && (trigger.IsInsert))
    {
        handlerExpense.notifyEmployees(True,Trigger.New,null);
    }
    
    if((trigger.isBefore) && (trigger.IsUpdate))
    {
        handlerExpense.notifyEmployees(False,Trigger.New,Trigger.OldMap);
    }
    
    else if(trigger.isdelete)
    {
        handlerExpenses handler = new handlerExpenses();
        handler.updateOpportunity(trigger.old);
    }
}