/*
    @Name        : TestRatingDemoCtrl
    @description : The following is a Test class for RatingDemoCtrl .
*/
@isTest
private class TestRatingDemoCtrl{
    private static testmethod void testrateAssets(){
        Account acc=new Account();
        acc.name='test Account';
        insert acc;
        test.startTest();
        RatingDemoCtrl ctrl=new RatingDemoCtrl();
        boolean b=RatingDemoCtrl.rateAsset(string.valueof(acc.Id),4);
        system.assert([Select Id from Account_Ratings__c where Account__c=:acc.id and User__c=:userinfo.getuserId()].size()==1);
        system.assert(b);
        //Update the existing record 
        boolean bupdate=RatingDemoCtrl.rateAsset(String.valueof(acc.Id),5);
        system.assert(bupdate);
        system.assert([Select Id from Account_Ratings__c where Account__c=:acc.id and User__c=:userinfo.getuserId()].size()==1);
        test.stopTest();
    }
}