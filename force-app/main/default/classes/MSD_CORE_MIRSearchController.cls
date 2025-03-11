/**
* @File Name : MSD_CORE_MIRSearchController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 7, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 7, 2024 |   | Initial Version
**/

public without sharing class MSD_CORE_MIRSearchController {

    @AuraEnabled
    public static String searchMedcomms(String productName, String keyword) {
        System.debug('17'+ productName + keyword);
        try {
            // Create an HTTP request
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:VeevaMedcommsSearchNC');
            req.setMethod('POST');

            // Create the JSON body for the POST request
            String requestBody = JSON.serialize(new Map<String, Object>{
                'query' => new Map<String, Object>{
                    'bool' => new Map<String, Object>{
                        'must' => new List<Object>{
                            new Map<String, Object>{
                                'query_string' => new Map<String, Object>{
                                    'query' => keyword
                                }
                            },
                            new Map<String, Object>{
                                'match' => new Map<String, Object>{
                                    'product_name' => productName
                                }
                            }
                        }
                    }
                }
            });

            // Set the request body
            req.setHeader('Content-Type', 'application/json');
            req.setBody(requestBody);

            // Send the HTTP request
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('50'+ res);
            System.debug('50'+ res.getBody());
            // Return the response
            return res.getBody();
        } catch (Exception e) {
            // Handle any exceptions
            System.debug('Error: ' + e.getMessage());
            return null;
        }
    }
    // Define the endpoint and API key as constants
    private static final String API_ENDPOINT = 'https://gxkoutfnnl.execute-api.us-east-1.amazonaws.com/sit/mirCase';
    private static final String API_KEY = 'PXCTSCX9iI630U12Bio7x744vdeCQ8B71QJC9JOF';
    @AuraEnabled
    public static String submitUncodedCase(String productCode, String requestQuestion) {
        System.debug('66'+ productCode + requestQuestion);
        String currentUserEmail = UserInfo.getUserEmail();
        Contact details = [SELECT Id, FirstName, LastName, Phone, Email, MailingStreet, MailingPostalCode, MailingState, MailingCity, MailingCountry from Contact where Email =:currentUserEmail LIMIT 1];
        system.debug('70'+ details);
        // Construct the HTTP request
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        req.setEndpoint(API_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('x-api-key', API_KEY);

        String guid = UUID.randomUUID().toString();
        
        // Define the body of the request  UNIQUECASENUMBER-0003
        String requestBody = '{"division": "US", "source_department": "Medical Information",'
            + '"requestid": "'+guid+'", "source_system": "GMSAPORT",'
            + '"source_language": "English", "source_type": "MI",'
            + '"data": [{"pir_status_code": "TRANSFERRED",'
            + '"external_req_id": "'+guid+'",'
            + '"contact_party_id": "'+details.Email+'",'
            + '"origin_system": "GMSAPORT", "case_language": "English",'
            + '"req_date_utc": "'+DateTime.now()+'",'
            + '"case_source": "GMSAPORT",'
            + '"contact_firstname": "'+details.FirstName+'",' 
            + '"contact_lastname": "'+details.LastName+'",'
            + '"contact_degree": "ANP",' 
            + '"question_product_code":"'+productCode+'-US",'
            + '"contact_address_line_1": "'+details.MailingStreet+'",' 
            + '"contact_address_line_2": "",'
            + '"contact_postal": "'+details.MailingPostalCode+'",'
            + '"contact_state": "'+details.MailingState+'",'
            + '"contact_city": "'+details.MailingCity+'",'
            + '"contact_email": "'+details.Email+'",'
            + '"contact_country": "'+details.MailingCountry+'",'
            + '"contact_phone1": "'+details.Phone+'",'
            + '"contact_company": "MSD",'
            + '"case_handling": "E-Mail",'
            + '"coded_pir_ind": "N", "outcome": "", "category": "",'
            + '"area_of_interest": "", "reason_for_contact": "",'
            + '"miportalsystemid": "WEB0004122",'
            + '"document": [{"docid": "",'
            + '"version": "", "cover_letter": "",'
            + '"cover_letter_pagecount": "", "outcome_letter": "", "length_of_excursion1": "",'
            + '"temperature_of_excursion1": "", "expiration_date": ""}],'
            + '"question":"'+ requestQuestion +'"}]}';

        req.setBody(requestBody);
        System.debug('101'+ requestBody);
        try {
            // Send the HTTP request and capture the response
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                return 'Request successful. Response: ' + res.getBody();
            } else {
                return 'Error: HTTP ' + res.getStatusCode() + ' - ' + res.getBody();
            }
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    @AuraEnabled
    public static String submitCodedCase(String productCode, String requestQuestion, String uri, String docnum){
        System.debug('129'+ productCode + requestQuestion);
        String currentUserEmail = UserInfo.getUserEmail();
        Contact details = [SELECT Id, FirstName, LastName, Phone, Email, MailingStreet, MailingPostalCode, MailingState, MailingCity, MailingCountry from Contact where Email =:currentUserEmail LIMIT 1];
        system.debug('132'+ details);
        // Construct the HTTP request
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        req.setEndpoint(API_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('x-api-key', API_KEY);

        String guid = UUID.randomUUID().toString();

        String requestBody= '{"division": "US", "source_department": "Medical Information",'
            + '"requestid": "'+guid+'", "source_system": "GMSAPORT",'
            + '"source_language": "English", "source_type": "MI",'
            + '"data": [{"pir_status_code": "TRANSFERRED",'
            + '"external_req_id": "'+guid+'",'
            + '"contact_party_id": "'+details.Email+'",'
            + '"origin_system": "GMSAPORT", "case_language": "English",'
            + '"req_date_utc": "'+DateTime.now()+'",'
            + '"case_source": "GMSAPORT",'
            + '"contact_firstname": "'+details.FirstName+'",' 
            + '"contact_lastname": "'+details.LastName+'",'
            + '"contact_degree": "ANP",' 
            + '"question_product_code":"'+productCode+'-US",'
            + '"contact_address_line_1": "'+details.MailingStreet+'",' 
            + '"contact_address_line_2": "",'
            + '"contact_postal": "'+details.MailingPostalCode+'",'
            + '"contact_state": "'+details.MailingState+'",'
            + '"contact_city": "'+details.MailingCity+'",'
            + '"contact_email": "'+details.Email+'",'
            + '"contact_country": "'+details.MailingCountry+'",' 
            + '"contact_phone1": "'+details.Phone+'",'
            + '"contact_company": "MSD",'
            + '"case_handling": "Web",'
            + '"coded_pir_ind": "Y", "outcome": "", "category": "",'
            + '"area_of_interest": "", "reason_for_contact": "",'
            + '"miportalsystemid": "WEB0004122",'
            + '"document": [{"docid": "'+docnum+'",'
            + '"version": "", "cover_letter": "'+uri+'",'
            + '"cover_letter_pagecount": "1.0", "outcome_letter": "", "length_of_excursion1": "",'
            + '"temperature_of_excursion1": "", "expiration_date": ""}],'
            + '"question":"'+ requestQuestion +'"}]}';
        //https://d35qfqr7hij96b.cloudfront.net/MMP MI Search 20241007184746.pdf
        req.setBody(requestBody);
        System.debug('175 coded'+ requestBody);
        try {
            // Send the HTTP request and capture the response
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                return 'Request successful. Response: ' + res.getBody();
            } else {
                return 'Error: HTTP ' + res.getStatusCode() + ' - ' + res.getBody();
            }
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
}