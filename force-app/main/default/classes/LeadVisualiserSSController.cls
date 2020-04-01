public with sharing class LeadVisualiserSSController 
{
    @AuraEnabled
    public static List<Lead> getLeads() 
    {
        return 
        [
            SELECT Id, Name, Latitude, Longitude
            FROM Lead
            WHERE OwnerId = :UserInfo.getUserId() AND Latitude != NULL AND Longitude != NULL
        ];
    }

    @AuraEnabled
    public static User getUserInfo() 
    {
        return 
        [
            SELECT Id, Name, Base_Location__Latitude__s, Base_Location__Longitude__s
            FROM User
            WHERE Id = :UserInfo.getUserId()
        ];
    }
}