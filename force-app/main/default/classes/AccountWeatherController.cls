public with sharing class AccountWeatherController 
{
    public String city {get;set;}
    public String temp {get;set;}
    public String pressure {get;set;}
    public String humidity {get;set;}
    public String temp_min {get;set;}
    public String temp_max {get;set;}
    
    public AccountWeatherController(ApexPages.StandardController stdController) 
    {
        Account account = (Account)stdController.getRecord();
        account = [SELECT Id, ShippingCity,temp_min__c,temp_max__c,humidity__c,pressure__c FROM Account WHERE Id =:account.Id];
        String accountCity = account.ShippingCity;
                
        String apiKey = '8b0ce0f405f91ce70cfc29ef5203b8dc';

        String requestEndpoint = 'http://api.openweathermap.org/data/2.5/weather';
        requestEndpoint += '?q=' + accountCity;
        requestEndpoint += '&APPID=' + apiKey; 
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) 
        {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> mainResults = (Map<String, Object>)(results.get('main'));
            temp = String.valueOf(mainResults.get('temp'));
            pressure = String.valueOf(mainResults.get('pressure'));
            humidity = String.valueOf(mainResults.get('humidity')); 
            temp_min = String.valueOf(mainResults.get('temp_min')); 
            temp_max = String.valueOf(mainResults.get('temp_max'));
        }
        
        else
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'There was an error retrieving the weather information.');
            ApexPages.addMessage(myMsg);

        }
    }
}