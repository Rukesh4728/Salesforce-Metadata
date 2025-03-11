@RestResource(urlMapping='/getDataFromSystem/')
global class ExposeAnApexClass {
 
    @HttpGet
    global static List<Contact> getData() {
         list<Contact> conlist = [select id,lastname from contact limit 10];        
         System.debug('This is the integration task');
         return conlist;
    }
}