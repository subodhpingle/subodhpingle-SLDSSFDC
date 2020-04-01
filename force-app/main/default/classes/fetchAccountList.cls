public class fetchAccountList 
{
	@AuraEnabled
    public static list<Account> fetchAccs()
    {
        return [SELECT ID,Name,Rating,Industry from ACCOUNT LIMIT 10];
    }
}