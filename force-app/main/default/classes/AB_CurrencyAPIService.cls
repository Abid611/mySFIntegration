public class AB_CurrencyAPIService {
    public static void getExchangeRate(){
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndPoint('https://open.er-api.com/v6/latest/USD');
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Accept','application/json');
        httpReq.setMethod('GET');
        
        Http http = new Http();
        try{
            HttpResponse httpRes = http.send(httpReq);
            string responseBody = httpRes.getBody();
            integer statusCode = httpRes.getStatusCode();
            string status = httpRes.getStatus();
            
            system.system.debug('The response Body of currency API is: '+ responseBody);
            system.system.debug('The response status Code of currency API is: '+ statusCode);
            system.system.debug('The response status of currency API is: '+ status);
        }catch(system.calloutException calloutEx){
            
        }catch(system.Exception ex){
            
        }       
        
    }
}