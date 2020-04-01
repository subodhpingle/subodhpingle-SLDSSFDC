global  class ScheduleBatchWarehouseInsert implements Schedulable 
{
   global void execute(SchedulableContext BCWHI) 
   {
       batchAccountUpdate WHI= new batchAccountUpdate ();
       database.executeBatch(WHI);
   }
   
   Public static void SchedulerMethod() 
   {   
       String sch = '0 0 * * * ?';
       system.schedule('My Jobs scheduled name', sch, new ScheduleBatchWarehouseInsert());

   }
}