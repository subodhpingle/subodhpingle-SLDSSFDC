//APEX CLASS
public with sharing class validateCountryIDController 
{
	@AuraEnabled
	public static decimal validateCountryID(decimal cid)
	{
        set<String> countryIDs = new set<String>();
        boolean isFound = FALSE ;
        boolean isValidCountryID = FALSE;
        list<contact> conList = new list<Contact>();
        
        Pattern patt = Pattern.compile('\\d{3}');
        Matcher mceP = patt.matcher(string.ValueOf(cid));
        
        if(mceP.matches())
        { 
            for(Address__c addObj: [SELECT Name, Id, CountryID__c FROM Address__c where CountryID__c =: cid])
            {
                countryIDs.add(String.ValueOf(addObj.CountryID__c));
            }
        }    
        
        if(countryIDs != null)
        {
            for(Contact conObj: [SELECT ID,CountryID__c from Contact where CountryID__c in: countryIDs])
            {
                //conObj.CountryID__c =  'FOUND';
            }
        }
        return cid;
	}
}