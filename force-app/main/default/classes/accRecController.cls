public with sharing class accRecController
{ 
     public static Map<Id, String> recordtypemap {get;set;}
    	@AuraEnabled
        public static string getAccountEmail(string accID){
            String accEmail = '';
        	accEmail = [SELECT ID,phone from Account where Id =: accID LIMIT 1].phone;
            return accEmail;
        }
   @AuraEnabled        
    public static List<String> fetchRecordTypeValues(){
        List<Schema.RecordTypeInfo> recordtypes = Account.SObjectType.getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master')
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return recordtypemap.values();
    }
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel){
        Id recid = Schema.SObjectType.Account.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
        return recid;
    }
}