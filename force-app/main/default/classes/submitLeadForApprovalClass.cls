public class submitLeadForApprovalClass {
    @AuraEnabled
    public static String getexecute(Lead inv,Id recid)
    {
        id currentUserId = UserInfo.getUserId();
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setObjectId(recid);
        req1.setSubmitterId(currentUserId);
        try{
            Approval.ProcessResult result = Approval.process(req1);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        
        return 'success';
    }
    //  return null;
}