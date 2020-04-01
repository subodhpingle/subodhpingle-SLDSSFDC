public class recordtypeControllernew {
    public static Map<Id, String> recordtypemap {get;set;}
    
    @AuraEnabled        
    public static List<String> fetchRecordTypeValues()
    {
        List<Schema.RecordTypeInfo> recordtypes = Contact.SObjectType.getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes)
        {
            if(rt.getName() != 'Master')
            recordtypemap.put(rt.getRecordTypeId(),rt.getName());
        }        
        return recordtypemap.values();
    }
    
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel)	//Contact con, 
    {
        system.debug('this is recordTypeLabel: ' +recordTypeLabel);
        Id recid = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Sub_Complaint').getRecordTypeId();  
        //createContact(con,recid);
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

	@AuraEnabled
    public static contact createContact(Contact con,ID recTypeID)	//,
    {
        system.debug('con:' +con);
        system.debug('recTypeID:' +recTypeID);
        Con.recordTypeID = recTypeID;
        
        try
        {
        	insert con;    
            system.debug('con is :' +con);
        }
        catch(DMLException de)
        {
        	system.debug('con is failed to insert:' +de.getMessage());    
        }
        return con;
    }
}