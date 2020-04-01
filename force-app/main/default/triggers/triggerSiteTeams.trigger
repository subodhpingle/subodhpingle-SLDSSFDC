trigger triggerSiteTeams on Site_Team__c (after insert,after update) {
    if(Trigger.isInsert){
        handlerSiteTeams.mapSiteTeamToRelatioship(Trigger.new,True,null);
    }
    else if(Trigger.isUpdate){
        handlerSiteTeams.mapSiteTeamToRelatioship(Trigger.new,False,Trigger.Oldmap);
    }
}