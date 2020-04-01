public class S2SHelper
{
    private static final String remote_site_url= 'https://mylighteningorg-dev-ed.my.salesforce.com/services/apexrest/createAccount/';
    private static final String clientId = '3MVG9ZL0ppGP5UrAns9VExHKEL_qaWJF_1N2tnYLxJyEgc8_mNRohGHL4GTE0LtrvJNh8Bu8Z.eNR9opjyqlo';
    private static final String clientSecret = '8589241521187907393';
    private static final String userName= 'trailhead22@irt.com';
    private static final String passWord= 'Sfdc@123';
    private static final String token_url= 'https://mylighteningorg-dev-ed.my.salesforce.com/services/oauth2/token';
    private static String accessTokenExpiresIn='3300';
    private static String accessTokenType='Bearer';
    
    //Wrapper Class
    public class deserializeResponse
    {
        public String id;
        public String access_token;
    }
    
    //This method is using to Parse the REST Response message (i.e. HttpResponse) using JSON API and get Status code and message 
    public static String parseResponseMessageForToken(String jsonRespMsg) 
    {
        String accessToken = '';
        if(jsonRespMsg!=null & jsonRespMsg!='') 
        { 
            // Parse JSON response to get all the totalPrice field values.
            JSONParser parser = JSON.createParser(jsonRespMsg); 
            while(parser.nextToken() != null)
            {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token'))
                {
                    //Get the value of refresh_token
                    parser.nextToken();
                    accessToken = parser.getText();
                    system.debug('This is accessToken:-    '+accessToken);
                   }
               if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'expires_in')) 
               {
                   system.debug('inside if loop');
                    //Get the value of expires_in
                    parser.nextToken();
                    accessTokenExpiresIn = parser.getText();
                    system.debug('This is accessTokenExpiresIn :-    '+accessTokenExpiresIn );
               }
               if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'token_type'))
               {
                   system.debug('inside if loop');
                    //Get the value of token_type
                    parser.nextToken();
                    accessTokenType = parser.getText();
                    system.debug('This is accessTokenType:-    '+accessTokenType );
               }
            }
        }
        return accessToken;
    }     
    
    public static String retrieveAuthenticationDetail()
    { 
        String access_Token ='';
        String request_body = 'grant_type=password&client_id='+clientId +'&client_secret='+clientSecret +'&username='+userName+'&password='+passWord;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(request_body);
        req.setMethod('POST');
        req.setEndpoint(token_url);
        
        HttpResponse res=h.send(req);
        try
        {
            res = h.send(req); 
            system.debug('response body is:-    ' +res.getBody());
            //Parse the response message parseResponseMessageForToken(); 
            access_Token = parseResponseMessageForToken(res.getBody());  
            system.debug('This is access_Token :-    '+access_Token);
            
          }
          catch(Exception e)
          {
              access_Token = '';
          }
        return access_Token ;
    }
    
    
    //This method is using to Prepare REST Request(i.e.HttpRequest) and Response (i.e. HttpResponse) message and make REST call outs using REST API 
    @future(Callout = true)
    public static void makeMicroServiceCallout(String accname,String accId)
    {
        String statusMsg ='Fail';
        String jsonstr='{"Name":"'+Accname+'"}';
        String access_Token =  '00D28000001yPu7!ARUAQPENPO3G0wxLZA.r89seH7qVq01otHXCZbbeT44VWFTuqKRHUnoRMRb6mGQNBedFoLY_mEkSibZNocpetB.dljPQczo5';
        system.debug('access_Token is:-    '+access_Token );
        
        if(access_Token != null && access_Token != '')
        {
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer:' +access_Token );
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(remote_site_url);
            
            HttpResponse res2=h2.send(req2);
            System.debug('This is res2:    ' +res2);
            
            try
             {
                res2 = h2.send(req2); 
                
                /*deserializeResponse resp2 = (deserializeResponse)JSON.deserialize(res2.getbody(),deserializeResponse.class);
                
                Account a = [SELECT Id FROM Account WHERE Id = :accId];
                system.debug('this is updated A from source:    ' +a);
                a.Site = resp2.id;
                update a;
                system.debug('this is updated A from source:    ' +a);
                */
                
                if(res2.getStatusCode()==200 && res2.getStatus()=='OK')
                {
                    statusMsg= 'Success';  
                    statusMsg=statusMsg + '# StatusCode: ' + res2.getStatusCode()+' - Status: '+res2.getStatus();
                }
                else
                {
                    statusMsg=statusMsg + '# StatusCode: ' + res2.getStatusCode()+' - Status: '+res2.getStatus(); 
                }
             }
              catch(Exception e)
              {
                String errMsg='S2SHelper()::makeMicroServiceCallout() Exception during service Callout '+e.getMessage() ;  
                statusMsg=errMsg; 
              } 
            }
        }    
}