trigger triggerCaseComment on CaseComment (after insert) {
  handlerCaseComments.mapCaseComments(Trigger.new);
}