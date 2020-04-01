global class metadataAPIService{
    @future (callout = true) 
    webService static void addPickListValues(String caseObj,String picklistToUpdate,list<String> recTypeSet){
        
        system.debug('This is caseObj:='    +caseObj);
        system.debug('This is picklistToUpdate:'    +picklistToUpdate);
        system.debug('This is recTypeSet:=    '+recTypeSet);
        
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        system.debug('This is service.SessionHeader.sessionId:=    '+service.SessionHeader.sessionId);
        
        
           
       // Add pick list values
        if(recTypeSet != null && !recTypeSet.isEmpty()){
            MetadataService.CustomField customFieldOfCase = 
            (MetadataService.CustomField) service.readMetadata('CustomField', new String[] { 
            'Case.Priority' }).getRecords()[0];       
            system.debug('This is customFieldOfCase:=    '+customFieldOfCase);
        for(String str: recTypeSet)
        {
                
                system.debug('-str-'+str);
                MetadataService.CustomValue valueToAdd = new MetadataService.CustomValue();
                valueToAdd.Label= str;
                valueToAdd.fullName = str;
                valueToAdd.default_x=false;
                valueToAdd.isActive = true;
                system.debug('This is valueToAdd :=    '+valueToAdd);
                customFieldOfCase.valueSet.valueSetDefinition.value.add(valueToAdd);
            }
            MetadataService.SaveResult result = service.updateMetadata(new MetadataService.Metadata[] 
            {customFieldOfCase })[0];
            system.debug('This is Result :=    '+result);
        }
        //system.debug('customFieldOfCase.valueSet.valueSetDefinition------'+JSON.serializePretty(customFieldOfCase.valueSet.valueSetDefinition));
        //System.debug('This is customFieldOfCase :=     '+customFieldOfCase );
        
    }
}