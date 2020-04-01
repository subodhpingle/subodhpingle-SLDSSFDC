public class outboundemail 
{
	public void myEmail(Decimal amount,List<String> toEmpNames,List<String> toEmpEmails,String emailBody)
    {
        List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAdd = new String[]{};
        toAdd = toEmpEmails;
        mail.setToAddresses(toAdd);
        mail.setSubject('Please pay remaining amount');
        mail.setPlainTextBody(emailBody);
        mail.setSenderDisplayName('Expense Status ! ');
        allMails.add(mail);
        
        Messaging.sendEmail(allMails,false);    
    	System.debug('You have made ' + Limits.getEmailInvocations() + ' email call outs of ' + Limits.getLimitEmailInvocations() + ' allowed');
    }   
}