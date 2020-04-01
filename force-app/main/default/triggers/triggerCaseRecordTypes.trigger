trigger triggerCaseRecordTypes on Web_to_Case_Record_Types__c (after insert) {
    handlerCase handler= new handlerCase();
    handler.addPickListValues(Trigger.New);
}