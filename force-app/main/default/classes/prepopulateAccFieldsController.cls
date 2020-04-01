public class prepopulateAccFieldsController {
    public static Map<Id, String> recordtypemap {get;set;}
    @AuraEnabled        
    public static List<String> fetchRecordTypeValues(){
        List<Schema.RecordTypeInfo> recordtypes = Contact.SObjectType.getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master')
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return recordtypemap.values();
    }
    
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel){
        Id recid = Schema.SObjectType.Contact.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
        return recid;
    }
    
    //this apex method is used to set phone of account to contact while creating
    @AuraEnabled
    public static string getAccountEmail(string accID)
    {
        String accEmail = '';
        accEmail = [SELECT ID,phone,RecordTypeId,Geolocation__c from Account where Id =: accID LIMIT 1].phone;
        return accEmail;
    }
}