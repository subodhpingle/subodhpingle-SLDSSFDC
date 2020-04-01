public class handlerLead {
	public static void restrictLeadFirstName(List<Lead> currentLeads){
        for(Lead leadObj : currentLeads){
            if(leadObj.FirstName == 'Test'){
                leadObj.adderror('CANNOT BE INSERTED :');
            }
        }
    }
}