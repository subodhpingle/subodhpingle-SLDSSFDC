global class HourlyScheduleBatchWarehouseInsert implements Schedulable
{
    global void execute(SchedulableContext ctx) 
    {
        System.schedule('Hourly', '0 0 * * * ?', new ScheduleBatchWarehouseInsert());  
    }
}