public class testWrapperController
{
    @AuraEnabled
    public static wrapperClass initMethod(String accId)
    {
        Id accRec = [SELECT Id FROM Account WHERE Id =: accId LIMIT 1].Id ;
        system.debug('this is accRec:-	' +accRec);
        
        wrapperClass wrapperObj = new wrapperClass();
        wrapperObj.conList = [SELECT Id,AccountID,LastName,Email FROM Contact WHERE AccountID =: accRec];
        wrapperObj.oppList = [SELECT Id,AccountID,Name,Amount FROM Opportunity WHERE AccountID =: accRec];
        wrapperObj.isSelected = false;
        system.debug('this is wrapperObj:-	' +wrapperObj);
        return wrapperObj;
    }
    @AuraEnabled
    public static void deleteSelectedContacts(List<String> conListToDelete)
    {
        system.debug('This is conListToDelete:=	' +conListToDelete);
        List<Contact> conListDelete = [SELECT Id FROM Contact WHERE Id IN : conListToDelete];
        if(!conListDelete.isEmpty()){
            delete conListDelete;
        }
    }
    public class wrapperClass
    {
        @AuraEnabled public List<Contact> conList {get;set;}
        @AuraEnabled public List<Opportunity> oppList {get;set;}
        @AuraEnabled public String contactMsg {get;set;}
        @AuraEnabled public String opportunityMsg {get;set;}
        @AuraEnabled public boolean isSelected {get;set;}
    }
}