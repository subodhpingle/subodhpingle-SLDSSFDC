public class CommonWrapperClass  
{
    /*******************************************/
    /* Wrapper class to display Position      */
    /*****************************************/
    
    public class DisplayPositionRecords 
    {        
        @AuraEnabled public boolean isSelected;
        @AuraEnabled public string accName;
        @AuraEnabled public string rating;
        @AuraEnabled public string industry;
        @AuraEnabled public string positionId;
        
        public DisplayPositionRecords()
        {
            isSelected = false;
            accName = '';
            rating = '';
            industry = '';
        }
    }
}