public class dataMaskingCtrl 
{
  @AuraEnabled
    public static List<Contact> initMethod()
    {
        return [SELECT Name, Email, Department,LeadSource from contact Limit 25];
    }
}