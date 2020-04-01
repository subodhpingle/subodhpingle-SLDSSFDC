public class GeolocationCheckIn {
 
    public Id eventId {get; set;}
 
    public GeolocationCheckIn(ApexPages.StandardController stdController) {
        Event currentEvent = (Event)stdController.getRecord();
        eventId = currentEvent.Id;
    }
 
    @RemoteAction
    public static Boolean updateGeolocation(Id evntId, String lat, String lng) {
        Event eventToBeUpdated = [SELECT Id, Check_In_Time__c FROM Event WHERE Id = :evntId];
        // below line is optional as it sets the current time in Check-Out field on event record
        eventToBeUpdated.Check_In_Time__c = System.now();
        eventToBeUpdated.Location = lat + ' , ' + lng;
        update eventToBeUpdated;
 
        return true;
    }
 
}