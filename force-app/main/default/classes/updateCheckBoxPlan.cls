public class updateCheckBoxPlan 
{
    @AuraEnabled
	public static void updateCheck()
    {
        list<Account> Pl_list = new list<Account>();
        pl_list = [select id,rating from account];
        Account p =new Account();
        p.id=pl_list[0].id;
        p.rating='Warm';
        update p;
    }
}