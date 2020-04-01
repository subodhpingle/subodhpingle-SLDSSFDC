public class handlerAccountTeamMember{
    public class applicationException extends Exception {}
    
    public static void notifyUser(List<AccountTeamMember> currentAccountTeamList){
        map<Id,Id> teamMap = new map<Id,Id>();
        for(AccountTeamMember teamObj : currentAccountTeamList){
            teamMap.put(teamObj.UserId,teamObj.AccountId);
        }
        if(!teamMap.isEmpty()){
            notifyUser(teamMap);
        } 
    }
    public static void notifyUser(Map<Id,Id> accountTeamMap){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        String accName = [SELECT Id,Name FROM Account WHERE Id IN : accountTeamMap.values()].Name;
        for(User userObj : [SELECT Id,Email,Name FROM USER WHERE ID IN : accountTeamMap.keySet()]){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(userObj.Email);
            mail.setToAddresses(sendTo);
            mail.setSenderDisplayName('USER IS ADDED TO ACCOUNT TEAM MEMBER');
            List<String> ccTo = new List<String>();
            ccTo.add('pingle.subodh@gmail.com');
            mail.setCcAddresses(ccTo);
            mail.setSubject('ACCOUNT TEAM MEMBER UPDATED');
            String body = 'Dear ' + userObj.Name + ', ';
            body += 'You have been added to Account Team Member of ' +accName;
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        try{
            Messaging.sendEmail(mails);
        }
        catch(Exception e){
            throw new applicationException(e.getMessage());
        }
    }
}