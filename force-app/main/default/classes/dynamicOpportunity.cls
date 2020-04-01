public with sharing class dynamicOpportunity {
    @AuraEnabled(cacheable=true)
    public static list<Opportunity> getOpportunities(String accID){
        return [SELECT ID,AccountID from Opportunity where AccountID =: accID];
    }
}