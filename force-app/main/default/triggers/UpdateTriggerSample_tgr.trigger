trigger UpdateTriggerSample_tgr on Lead (after update) 
{ 
Lead NewLead = trigger.new[0]; 
Lead OldLead = trigger.old[0]; 
Lead LeadObject = new Lead(); 
// This takes all available fields from the required object. 
Schema.SObjectType objType = LeadObject.getSObjectType(); 
Map<String, Schema.SObjectField> M = Schema.SObjectType.Lead.fields.getMap(); 
for(String str : M.keyset()) 
{ 
    try 
    { 
        System.debug('Field name: '+str +'. New value: ' + NewLead.get(str) +'. Old value: '+OldLead.get(str)); 
        if(NewLead.get(str) != OldLead.get(str))
        { 
            system.debug('******The value has changed!!!! ' +NewLead.get(str)); // here goes more code 
        } 
    } catch (Exception e)
    { 
        System.debug('Error: ' + e); 
    } 
}}