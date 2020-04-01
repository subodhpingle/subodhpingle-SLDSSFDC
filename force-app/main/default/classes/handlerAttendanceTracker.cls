public class handlerAttendanceTracker
{
    list<Month__c> monthList = new list<Month__c>();
	public void storeMonthDetails(List<Attendance_Tracker__c> attendanceList)
    {
    	for(Attendance_Tracker__c attend: attendanceList)
        {
            if(attend.Name != null && attend.Name.contains('Q1'))
            {
                for(Integer i=0;i<=2;i++)
                {
                    Month__c mon = new Month__c();
                    mon.name = 'April';
                    mon.Quarter__c = attend.Id ;
                    monthList.add(mon);	    	
                }
            }	    
        }
        insert monthList;
    }
}