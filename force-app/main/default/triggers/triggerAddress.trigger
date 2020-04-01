trigger triggerAddress on Address__c (after insert,after update) 
{
   /* if(trigger.isInsert && trigger.isUpdate)
    {
        for(Address__c add: trigger.New)
        {
            MagentoToAddressMapping handler = new MagentoToAddressMapping();
            //handler.createNewWidget();
        }       
    }
 */
  handler_Address1 handler = new handler_Address1();
  if(Trigger.IsAfter)
  {
      if(Trigger.IsInsert || Trigger.IsUpdate)
      { 
         for(Address__c addObj: Trigger.New)
         {
             handler.retreiveCountryIDDetails(Trigger.New);              
         }         
         
      }
  }        
}