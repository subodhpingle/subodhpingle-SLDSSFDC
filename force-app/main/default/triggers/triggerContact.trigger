trigger triggerContact on Contact (after insert,after update,after delete,after undelete,before delete) 
{
    if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete)
    {    
        handlerContact handler = new handlerContact();
        handler.countMaleFemaleContacts(trigger.new);
        handler.changeAccountOwner(trigger.new); 
        handler.createOpportunity(trigger.New);
        handler.setBillingShippingInAcc(trigger.New);
        handler.checkDuplicateContact(trigger.New);
        handler.populatePrimaryContact(trigger.New);
        //handler.changeAccountRating(Trigger.New,Trigger.OldMap);
        //handler.getAccountID(Trigger.NEw);
    }
    
    else if(trigger.isDelete)
    {
        handlerContact handler = new handlerContact();
        handler.countMaleFemaleContacts(trigger.Old);
    }
}