public class AB_OpenCageGeocoderService {
    public static void reverseGeoCoding(string accountId){
        Account accRecord = [SELECT Id, Location__Latitude__s, Location__Longitude__s 
                             FROM 
                             	Account 
                             WHERE 
                             	Id = :accountId 
                             	AND Location__Latitude__s != null
                             	AND Location__Longitude__s != null
                             LIMIT 1
                            ];
        string queryParam = accRecord.Location__Latitude__s +','+ accRecord.Location__Longitude__s;
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint(System.Label.OPENCAGE_API_URL+'?q='+queryParam+'&key='+System.Label.OPENCAGE_API_KEY);
        httpReq.setMethod('GET');
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Accept','application/json');
        
        Http http = new Http();
        try{
            HttpResponse httpRes = http.send(httpReq);
            string responseBody = httpRes.getBody();
            integer responseCode = httpRes.getStatusCode();
            string responseStatus = httpRes.getStatus();
            system.debug('Response Body'+ responseBody);
            system.debug('Response code'+ responseCode);
            system.debug('Response Status'+ responseStatus);
            if(responseCode == 200){
                OpenCageReverseResponseWrapper wrapper = (OpenCageReverseResponseWrapper) System.JSON.deserialize(responseBody, OpenCageReverseResponseWrapper.class);
                //if(wrapper != null && wrapper.results != null && wrapper.results.size() > 0)
                if(wrapper?.results?.size()>0){
                    OpenCageReverseResponseWrapper.results reslt = wrapper.results.get(0);
                    accRecord.ShippingCity = reslt?.components?.city;
                    accRecord.ShippingCountry = reslt?.components?.country;
                    update accRecord;
                }
            }else{
                //error handling code
            }
            
        }catch(System.calloutException calloutEx){
             
        }catch(System.Exception ex){
            System.debug('Errors from catch method ' + ex.getMessage());
    		throw ex; // temporarily rethrow to identify issue
        }
    }
}