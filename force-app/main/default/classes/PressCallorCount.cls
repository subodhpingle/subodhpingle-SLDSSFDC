public with sharing class PressCallorCount 
{ 
    @AuraEnabled
    public static Account getInventory(Id inventoryId)
    {
        return [SELECT Id, rating FROM account  WHERE Id = :inventoryId limit 1]; //
    }
 
    @AuraEnabled
    public static account updateInventoryCall(account inv,String recordId)
    {
        //you can make your own update here.
        //return ('Hello from the server, ' + itemname);
        system.debug('inside method');
        inv.rating = 'Hot';
        update inv;
        system.debug('inside inv' +inv);
        return inv;     
    }
}