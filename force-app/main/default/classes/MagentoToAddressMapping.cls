@RestResource(urlMapping='/Addresses/*')

global class MagentoToAddressMapping
{
    @HttpPost 
    global static String createNewWidget(String addressType,String city, String country) 
    {
        Address__c add = new Address__c();
        add.Address_Type__c= addressType;
        add.city__c = city;
        add.country__c = country;
        
        system.debug('this is before add:- ' +add);
        
        try
        {    
            insert add;
            system.debug('this is add:- ' +add);   
        }
        catch(DMLException de)
        {
            system.debug('this is de:- ' +de.getMessage());
        }     
        return add.id;
    }
}