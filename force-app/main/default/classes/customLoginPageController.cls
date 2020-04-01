public with sharing class customLoginPageController 
{
    public string username {get;set;}
    public string password {get;set;}
    
    public pageReference doLogin()
    {
        return Site.Login(username,password, '/s');
    }   
}