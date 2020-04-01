trigger triggerAttachment on Attachment (after insert,after update)
{
    set<string> name = new set<string>();
    set<id> parentid = new set<id>();
    set<id> dupname = new set<id>();
    
    list<attachment> aList = new list<attachment>();
    
	if(trigger.isInsert || trigger.isUpdate)
    {
      	for(attachment a: trigger.new)
        {
            name.add(a.id);
            parentid.add(a.parentID);
            system.debug('this is name: ' +name);
            system.debug('this is parentid: ' +parentid);
        }
        
        aList =[select id,name,parentID from attachment where parentID in:parentid and id in:name];
        system.debug('this is aList: ' +aList);
        
        if(aList.size()>0)
        {
            for(attachment dupatt: trigger.new)
            {
                dupatt.addError('ERROR !!' );
            }            
        }
        
        else
        {
            
        }
    }
}