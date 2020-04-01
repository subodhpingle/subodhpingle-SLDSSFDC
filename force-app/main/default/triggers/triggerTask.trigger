trigger triggerTask on Task (after insert,after update) {
handlerTasks handler = new handlerTasks();

if(Trigger.IsAfter)
{
if(Trigger.IsInsert || Trigger.IsUpdate)
{
    handler.mapTasks(Trigger.New);
    handler.calculateTasks(Trigger.New);
}
}
}