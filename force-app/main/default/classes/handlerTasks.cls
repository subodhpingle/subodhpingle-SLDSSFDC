public class handlerTasks
{
    map<ID,Task> accTaskMap = new map<ID,Task>();
    String accountPrefix = Schema.SObjectType.Account.getKeyPrefix();
    list<Task> taskListToInsert = new list<Task>();
    map<ID,Task> taskListMap = new map<ID,Task>();
    map<ID,Contact> conListMap = new map<ID,Contact>();
    list<Contact> conList = new list<Contact>();
    
    public void mapTasks(list<task> taskList)
    {
        for(Task tk: taskList)
        {
            if(tk.WhatID != null && tk.WhatId.getSObjectType() == Account.sObjectType)
            {
                system.debug('inside if');
                accTaskMap.put(tk.WhatID,tk); 
                system.debug('keyset values are ' +accTaskMap.keyset());   
            }
        }
        
        List<Contact> conList = [SELECT ID,AccountID from Contact where AccountID in: accTaskMap.keyset()];
        system.debug('conlist size is:-    '+conList.size());
        
        if(conList.size()>0)
        {     
            for(Contact c: conList)
            {
                conListMap.put(c.ID,c);
            }
            
            if(ConListMap.keyset()!= null)
            {
                for(String s: conListMap.Keyset())
                {
                    Contact c = conListMap.get(s);
                    system.debug('contact c is :-    ' +c);
                    Task tk = new Task();
                    tk.Subject = accTaskMap.get(c.AccountID).Subject;
                    system.debug('contact subject is ' +tk.Subject);
                    tk.WhoID = c.ID;
                    system.debug('contact is ' +tk.WhoID);
                    
                    taskListToInsert.add(tk);    
                } 
            }   
         }
            
            try
            {
                insert taskListToInsert;
                system.debug('taskList are:-   ' +taskListToInsert );
                system.debug('taskListToInsert size are:-   ' +taskListToInsert.size());
            }
            catch(DMLException de)
            {
                system.debug('taskList failed to insert:-   ' +de.getMessage());    
            }             
  
    }  // END OF METHOD  
    
    
    public void calculateTasks(list<task> taskList)
    {
        for(Task tk: taskList)
        {
            taskListMap.put(tk.WhoID,tk);    
        }
        system.debug('conList is :-  ' +conList);
        
        AggregateResult[] ar = [select Count(ID) ss from Task where WhoID != null ];
        Integer d=(Integer)ar[0].get('ss');
        system.debug('d id:- ' +d);
        
        for(Contact c: [SELECT id from Contact])
        {
            c.total_tasks_are__c = string.ValueOf(d) ;
            system.debug('c.total_tasks_are__c is :-  ' +c.total_tasks_are__c);
        }
        update conList;
    }
}