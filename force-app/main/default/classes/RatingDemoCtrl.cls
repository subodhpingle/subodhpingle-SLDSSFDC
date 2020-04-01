/*
    @Name        : RatingDemoCtrl
    @description : The following class consists of logic to upsert the rating for Parent record.This plugin assumes Account has a Junction record where user rating is inserted
*/
public with sharing class RatingDemoCtrl{

   public RatingDemoCtrl(){
     lstacc=new List<Account>();
     lstacc=[Select Id,Name,(Select RatingScore__c from Account_Ratings__r where User__c=:userinfo.getuserID() limit 1) from Account Limit 10];
   }
   
   public List<account> lstacc{get;set;}//getter and setter variable for showing some sample data for which we rate
   
   /*
      @Name        : rateAsset
      @description : The following method upserts the Rating record if the User rate an Asset.This record should be created as a Junction record for Parent Record 
      @parameters  : AssetId(ID),rating(decimal)
      @returns     : Boolean
    */
   @RemoteAction
   public static boolean rateAsset(String accId,decimal myRating){
      List<Account_Ratings__c> lstcRating=[Select RatingScore__c from Account_Ratings__c
                                                where Account__c =:accId
                                                  and User__c=:userinfo.getuserID()];
       Account_Ratings__c cRating=new Account_Ratings__c();
       if(lstcRating.size()>0){
        cRating=lstcRating.get(0);
        cRating.RatingScore__c=myRating;
      }else{
        cRating.RatingScore__c =myRating;
        cRating.User__c=userinfo.getuserID();
        cRating.Account__c=accId;
     }
     try{
          upsert cRating;//Upsert the Rating record 
          return true;
     }catch(exception ex){
          system.debug('Error occured'+ex.getmessage());
          return false;//Return false if any error occurs in rating an Asset
     }
  }
  

}