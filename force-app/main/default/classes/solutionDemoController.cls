/*

*/
public class solutionDemoController
{
    @AuraEnabled
    public static Case getCase(String caseId)
    {        
        Set<Id> accIDs = new Set<Id>();  
        Map<Id,decimal> countOpenCases = new Map<Id,decimal>();
        Decimal totalOpenCases = 0;  
        
        if(caseId != null && caseId != '')
        {
            for(Case caseObj: [SELECT AccountId FROM Case WHERE Id =: caseId]) 
            {
                if(caseObj.accountID != null)
                {
                    accIds.add(caseObj.AccountID);
                    system.debug('this is acIs:- ' +accIds);
                }
            }  
            
            //below is an aggregate function to calculate total number of open cases
            for(AggregateResult ar:[SELECT AccountId i,count(id)cnt FROM case WHERE AccountID IN: accIds 
                                    AND status = 'New' group by AccountID])
            {
                system.debug('inside aggregate function for countOpenCases:-'+ar);
                System.debug(ar.get('cnt'));
                String count = '' + ar.get('cnt');
                totalOpenCases = Decimal.ValueOf(count);
                System.debug('totalOpenCases::'+totalOpenCases);
            } 
        } 
        return null;
    }
}