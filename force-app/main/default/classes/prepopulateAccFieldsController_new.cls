public class prepopulateAccFieldsController_new 
{
	@AuraEnabled        
    public static List<RecordTypeWrapper> getListOfRecordType(){
        List<Schema.RecordTypeInfo> recordtypes = Contact.SObjectType.getDescribe().getRecordTypeInfos();
        system.debug('This is recordtypes:-	' +recordtypes);
        Map<Id, RecordTypeWrapper> recordtypemap = new Map<Id, RecordTypeWrapper>();
        system.debug('This is recordtypemap:-	' +recordtypemap);
        for(RecordTypeInfo rt : recordtypes){
            system.debug('This is rt:-	' +rt);
            if(!rt.isMaster() && rt.isAvailable()){
                recordtypemap.put(rt.getRecordTypeId(), new RecordTypeWrapper(rt.getRecordTypeId(), rt.getName()));
                system.debug('This is recordtypemap keySet:-	' +recordtypemap.keySet());
                system.debug('This is recordtypemap values:-	' +recordtypemap.Values());
                //system.debug('This is recordtypemap.get(rt).Description:-	' +recordtypemap.get(rt).Description);
            }
        }
        Map<Id, RecordType> recordTypeById = new Map<Id, RecordType>([SELECT Id, Description FROM RecordType 
																		WHERE sObjectType = 'Contact']);
        system.debug('This is recordTypeById:-	' +recordTypeById);
        for(Id rtId : recordtypemap.keySet()){
            system.debug('This is rtId:-	' +rtId);
            if(recordTypeById.containsKey(rtId)){
                system.debug('this is recordtypemap.get(rtId):- ' +recordtypemap.get(rtId));
                recordtypemap.get(rtId).Description = recordTypeById.get(rtId).Description;
            }
        }
        return recordtypemap.values();
    }
    
    //this apex method is used to set phone of account to contact while creating
    @AuraEnabled
    public static string getAccountEmail(string accID)
    {
        String accEmail = '';
        accEmail = [SELECT ID,phone,RecordTypeId,Geolocation__c from Account where Id =: accID LIMIT 1].phone;
        return accEmail;
    }
    
    public class RecordTypeWrapper{
        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
        @AuraEnabled public String Description;
        
        public RecordTypeWrapper(String Id, String Name){
			this.Id = Id;
            this.Name = Name;            
        }
    }
}