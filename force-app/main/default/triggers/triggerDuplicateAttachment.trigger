trigger triggerDuplicateAttachment on Attachment (after insert) 
{   
    for(attachment a: trigger.new)
    {
        string oldname = trigger.OldMap.get(a.id).name;
        for(attachment att: trigger.new)
        {
           if(att.name != oldname)
           {
              
           }
            else
            {
                att.addError('ERROR:');
            }
        }
    }
}