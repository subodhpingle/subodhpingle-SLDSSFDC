public class deleteSelectedContactsController 
{
  @AuraEnabled
  public static List<contact> getContacts() 
  {
  	  List<contact> totalList = new List<contact>();
      for(Contact cc :[SELECT id,AccountID,name,Email from contact where AccountID = null])
      {
      	totalList.add(cc);
      }	
      return totalList;
  }
    
  @AuraEnabled
  public static void deleteSelectedCon(List<String> lstOfContactIds)
  {
   	list<Contact> lstContacts = new list<Contact>();
    for(string sContactId : lstOfContactIds)
    {
        Contact oContact = new contact();
        oContact.Id = sContactId;
        lstContacts.add(oContact);
   	 }
      delete lstContacts;
  }
}