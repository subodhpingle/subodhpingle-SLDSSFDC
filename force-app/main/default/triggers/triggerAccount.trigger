trigger triggerAccount on Account (after insert,after update,before insert,before update,before delete) {

if((trigger.IsAfter && trigger.IsInsert) || (trigger.IsAfter && trigger.IsUpdate) )
{
    handlerAccount hand = new handlerAccount();
    hand.changeContactOwner(Trigger.New);
    hand.updateContact(Trigger.New);
    hand.createSLA(Trigger.New);
    Account a = Trigger.New[0];
    //S2SHelper.makeMicroServiceCallout(a.name,a.ID);
}

if((trigger.IsBefore && trigger.IsInsert) || (trigger.IsBefore && trigger.IsUpdate))
{    
    handlerAccount hand = new handlerAccount();
    hand.checkDuplicateRecords(Trigger.New);   
}
if(trigger.isDelete)
{
    handlerAccount hand = new handlerAccount();
    hand.restrictAccountDeletion(trigger.OLD);
}

if(trigger.isBefore)
{
    handlerAccount hand = new handlerAccount();
    if(trigger.isInsert)
    {
        hand.checkDuplicateRecords(Trigger.New);     
    }
    if(trigger.isUpdate)
    {
        hand.checkDuplicateRecords(Trigger.New);
        hand.isFieldValueChanges(Trigger.New,Trigger.OldMap);    
    }
}
}