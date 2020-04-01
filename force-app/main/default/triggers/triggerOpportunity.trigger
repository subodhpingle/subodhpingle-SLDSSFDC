trigger triggerOpportunity on Opportunity (after insert,after update) 
{
    handlerOpportunity handler = new handlerOpportunity();
    handler.createAccountTeamWithOppOwner(trigger.new);
    handler.lockOpportunity(trigger.new);
}