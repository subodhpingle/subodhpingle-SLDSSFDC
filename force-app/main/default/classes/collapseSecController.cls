public class collapseSecController 
{

    @AuraEnabled
    public static List<Account> getAccountAndContactsRelation()
    {
    	return [SELECT id,name,Phone FROM Account LIMIT 4];
    }
}