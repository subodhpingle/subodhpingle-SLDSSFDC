/************************************************************
 Name: DisplayPosition
 Type: Apex Class  
 Purpose: Apex Class  for  lightning component 
		  DisplayPosition.cmp
 ***********************************************************/
public class DisplayPosition 
{   
    @AuraEnabled
    public static List<CommonWrapperClass.DisplayPositionRecords> getPositionRecords() 
    {     
        List<CommonWrapperClass.DisplayPositionRecords> lstPositionRecords = 
		new List<CommonWrapperClass.DisplayPositionRecords>();
        
        List<Account> lstPositions =  [SELECT Id, Name, rating,industry from Account];
        
        if(lstPositions != null && lstPositions.size() > 0)
        {            
            for(Account position : lstPositions)
            {                
                CommonWrapperClass.DisplayPositionRecords positionRecord = 
				new CommonWrapperClass.DisplayPositionRecords();
                positionRecord.positionId = position.Id;
                positionRecord.accName = position.Name;
                positionRecord.rating = position.Rating; 
                positionRecord.industry = position.industry;               
                lstPositionRecords.add(positionRecord);
            }           
        }        
        		return lstPositionRecords;
    } 
    
    @AuraEnabled
    public static void performAction(string positionRecords) 
    {       
        if(!string.isBlank(positionRecords))
        {            
            List<CommonWrapperClass.DisplayPositionRecords> lstPositionRecords = (List<CommonWrapperClass.DisplayPositionRecords>)
			System.JSON.deserialize(positionRecords,List<CommonWrapperClass.DisplayPositionRecords>.class);
            system.debug('Debug for Dsiplaying all the records: lstPositionRecords'+lstPositionRecords);    
            //Perform Operation with records 
            
            for(CommonWrapperClass.DisplayPositionRecords objPositionRecords:lstPositionRecords)
            {
                if(objPositionRecords.isSelected)
                {
                    //Play with selected Records here                   
                    system.debug('Selected Record :'+objPositionRecords);
                }
            }                
        }        
    }
}