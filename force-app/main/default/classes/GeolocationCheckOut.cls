public class GeolocationCheckOut {
 
    public Id eventId {get; set;}
 
    public GeolocationCheckOut(ApexPages.StandardController stdController) {
        Event currentEvent = (Event)stdController.getRecord();
        eventId = currentEvent.Id;
    }
 
    @RemoteAction
    public static Boolean updateGeolocation(Id evntId, String lat, String lng) {
        Event eventToBeUpdated = [SELECT Id, Check_In_Time__c FROM Event WHERE Id = :evntId];
        // below line is optional as it sets the current time in Check-Out field on event record
        eventToBeUpdated.Check_Out_Time__c = System.now();
        eventToBeUpdated.Location = lat + ' , ' + lng;
        update eventToBeUpdated;
 
        return true;
    }
 
}