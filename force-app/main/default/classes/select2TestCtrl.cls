public class select2TestCtrl
{
	//@AuraEnabled
   /* public static List < String> getselectOptions(sObject objObject,string fld)
    {
        system.debug('this is objObject --->' +objObject);
        system.debug('this is fld --->' +fld);
        List <String> allOpts = new list <String> ();
        //Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
 
        //Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
 
        //Get a map of fields for the SObject
        map <String,Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
        
        //Get the list of picklist values for this field.
        list <Schema.PicklistEntry> values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        //Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values)
        {
            allOpts.add(a.getValue());
        }
        system.debug('this is allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
*/
    
    @AuraEnabled
    public static List<Employee__c> getselectOptions(String searchKeyWord,sObject objObject,string fld,List<Employee__c> ExcludeitemsList)
    {
        String searchKey = '%' + searchKeyWord + '%';
        List<Employee__c> returnList = new List<Employee__c>();
 
        List<string> lstExcludeitems = new List<string>();
        for(Employee__c item : ExcludeitemsList)
        {
            lstExcludeitems.add(item.id);
        }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery =  'SELECT Id, Name from Employee__c WHERE Name LIKE: searchKey AND Id NOT IN: lstExcludeitems order by createdDate DESC limit 5';
        List<Employee__c> lstOfRecords = Database.query(sQuery);
        
        for (Employee__c obj: lstOfRecords)
        {
            returnList.add(obj);
        }
        return returnList;
    }
    
 @AuraEnabled 
    public static account saveAccount(Account acc)
    {
        system.debug('this is acc-->' + acc);
        insert acc;
        return acc;
    }
}