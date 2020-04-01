trigger calcBusinessHours on Account (before insert, before update) 
{
    set<id> userID = new set<id>();

    // Assumes the BSC work hours are the default for the Org
    BusinessHours stdBusinessHours = [select id,name from businesshours where isDefault = true];  // or isDefault = true
    User currentUser = [Select TimeZoneSidKey from User where id =: USerInfo.getUserId()];
    
   // userID.add(currentUser.id);
   // system.debug('userID' +userID);
    
        for (Account so : Trigger.new) 
        {
            if (so.datetime__c != NULL)
            {
                system.debug('inside if loop: ' );
                so.ETA__c = BusinessHours.addGmt(stdBusinessHours.id, so.datetime__c, integer.valueOf(so.hrs__c) * 60 * 60 * 1000L);
                system.debug('this is ETA:' +so.ETA__c);
            }
        }
 }