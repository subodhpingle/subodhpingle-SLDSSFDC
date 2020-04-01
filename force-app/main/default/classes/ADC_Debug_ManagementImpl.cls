public class ADC_Debug_ManagementImpl
{    
   public boolean checkIfDebugEnabled()
   {  
        Boolean isDebugEnabled = false;          
        List<ADC_Debug_Management__c > debugDetails = [SELECT id,Name,ADC_debug_status__c FROM ADC_Debug_Management__c WHERE Name = 'ADC_Debug_Status_Record' LIMIT 1 ];
        
        if(debugDetails != null && debugDetails.size()>0 )
        {
            ADC_Debug_Management__c  debugDetailsObj = debugDetails[0];
            system.debug('inside if:------> ' +debugDetailsObj);
        }   
        else
        {
            ADC_Debug_Management__c debugRecord = new ADC_Debug_Management__c ();
            debugRecord.name = 'ADC_Debug_Status_Record';
            debugRecord.SetupOwnerId=UserInfo.getOrganizationId();
            debugRecord.ADC_debug_status__c = false;       
            try
            {
                insert debugRecord;
                system.debug('This is debugRecord--------> ' +debugRecord);
            }
            catch(DMLException ex)
            {
                system.debug('debugRecord is failed to insert--------> '+ex.getMessage());
            }
        }
        return isDebugEnabled;
    } 
}