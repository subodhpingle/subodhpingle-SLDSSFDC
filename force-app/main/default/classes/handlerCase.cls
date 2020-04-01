global class handlerCase{
    public void addPickListValues(List<Web_to_Case_Record_Types__c> newList){
    String caseObj = 'Case';
    String picklistToUpdate = 'Priority';
    List<String> recTypeSet = new List<String>(); 
        for(Web_to_Case_Record_Types__c recTypeObj : newList){
            if(recTypeObj.RecordTypeName__c != NULL){
                recTypeSet.add(recTypeObj.RecordTypeName__c);
                system.debug('This is recTypeSet:    ' +recTypeSet);
            }
        }
        if(!recTypeSet.isEmpty()){
            metadataAPIService.addPickListValues(caseObj,picklistToUpdate,recTypeSet);
        }
    }
 }