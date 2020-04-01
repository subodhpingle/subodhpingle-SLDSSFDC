trigger ADRUserReassign on opportunity (after update) 
{
 

public String ADendid;

       list<opportunity> ad =[Select id, Name from opportunity where id =:ADendid];
       list<opportunity> ad2Update = new list<opportunity>();
        map<id, opportunity> ADaddMap = new map<id, opportunity>([Select id from opportunity where id =:ADendid]);
        list<ProcessInstance> PI = new list<ProcessInstance>();
        map<id, id> PIVaddMap = new map<id, id>();
       
        system.debug(' ID Value on Target Object ' + ADaddMap);
                       
      
        for (ProcessInstance lstProcess : [Select id, Status, CreatedDate, TargetObjectId,
                                    (Select Id,ProcessInstanceId, StepStatus,
                                        Comments,OriginalActorId,ActorId
                                    From steps order by CreatedDate DESC)
                                From ProcessInstance 
                                where targetobjectid=:ADendid order by CreatedDate DESC]){
            PI.add(lstProcess);
            PIVaddMap.put(lstProcess.TargetObjectId, lstProcess.id);
           
            }
       
   
      
        for(ProcessInstance lstPI :  PI){
     //  if(lstPI.Status=='Reassigned'){
        for(ProcessInstanceStep lstSteps : lstPI.Steps){
    //    if(lstSteps.OriginalActorId != lstSteps.ActorId){
            if(lstSteps.StepStatus == 'Reassigned'){
     lstPI.addError('You cannot reassign - try again');
    id ADRUserAddId = PIVaddMap.get(lstPI.TargetObjectId);
       opportunity AAdd =  ADaddMap.get(lstPI.TargetObjectId);
       lstPI.addError('You cannot reassign - try again');
//         if (lstSteps.OriginalActorId != lstSteps.ActorId){

//  lstSteps.addError('You cannot reassign - try again');
        }
            }
                }
                }
     //           }
              //  } //End void
//}//End main