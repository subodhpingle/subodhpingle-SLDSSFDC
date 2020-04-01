/*
Source : Sfdcmonkey.com
API Version: 42
Date : 3/13/2018
*/
public with sharing class jQueryDataTableCtrl {
@AuraEnabled
   public static list <Opportunity> fetchOpportunity() {
      Return [SELECT Name,Type,StageName,Amount,CloseDate FROM Opportunity];	//LIMIT 500
          
    }
}