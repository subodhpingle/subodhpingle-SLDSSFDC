public class fetchMapController
{
    @AuraEnabled
    public static Map < String, String > fetchMapData() {
        Map < String, String > mapCustomer = new Map < String, String >();
        mapCustomer.put('A', 'Ahmedabad');
        mapCustomer.put('B', 'Bombay');
        mapCustomer.put('C', 'Cochin');
        mapCustomer.put('D', 'Dehradun');
        system.debug('mapCustomer are:-	'+mapCustomer);         
        return mapCustomer;
	}
}