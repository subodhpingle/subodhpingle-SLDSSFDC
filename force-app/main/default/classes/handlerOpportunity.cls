public class handlerOpportunity
{
    list<AccountTeamMember> accTeamMemberList = new list<AccountTeamMember>();
    list<AccountShare> accShareList = new list<AccountShare>();
    
    public void createAccountTeamWithOppOwner(List<Opportunity> opplist)
    {
        for(opportunity o: opplist)
        {
            if(o.probability == 20)
            {
                AccountTeamMember accTeamMember = new AccountTeamMember();
                accTeamMember.accountid = o.accountid;
                accTeamMember.teamMemberRole = 'Account Manager';
                accTeamMember.UserId = o.Ownerid;                
                accTeamMemberList.add(accTeamMember);        
            }
        }
            if(accTeamMemberList.size()>0)
            {
                try
                {
                    insert accTeamMemberList;
                    system.debug('this is accTeamMemberList: ' +accTeamMemberList);
                }
                catch(DMLException de)
                {
                    system.debug('accTeamMemberList is failed to insert:  '+de.getMessage());
                }
            }              
    }
    
    
    public void lockOpportunity(List<Opportunity> opplist)
    {
        // Query the accounts to lock
        Opportunity[] accts = [SELECT Id,status__c from Opportunity WHERE status__c = 'Approved'];
        system.debug('this is accts:- ' +accts);
        // Lock the accounts
        Approval.LockResult[] lrList = Approval.lock(accts, false);

        // Iterate through each returned result
        for(Approval.LockResult lr : lrList) 
        {
            system.debug('inside for loop:- ' +lr);
            if (lr.isSuccess()) 
            {
                system.debug('inside if loop:- ' );
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully locked Opportunity with ID: ' + lr.getId());
                
            }
            else 
                {
                    system.debug('inside else:- ');
                    // Operation failed, so get all errors                
                    for(Database.Error err : lr.getErrors()) 
                    {
                        system.debug('inside for loop:- ');
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
      }
    
    @AuraEnabled        
    public static List<Opportunity> fetchAllOpportunities()
    {
        return [SELECT ID,Name from Opportunity limit 50];
    }
}