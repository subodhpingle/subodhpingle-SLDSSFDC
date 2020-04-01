trigger triggerAttendanceTracker on Attendance_Tracker__c (after insert) {
    handlerAttendanceTracker handler = new handlerAttendanceTracker();
    handler.storeMonthDetails(trigger.New);
}