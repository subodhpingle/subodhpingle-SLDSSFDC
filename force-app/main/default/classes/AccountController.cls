public with sharing class AccountController 
{
    @AuraEnabled
    public static List<Account> findAll() 
    {
    	return [SELECT id, name, Geolocation__Latitude__s, Geolocation__Longitude__s
            FROM Account
            WHERE Geolocation__Latitude__s != NULL AND Geolocation__Longitude__s != NULL
            LIMIT 50];
    }
}