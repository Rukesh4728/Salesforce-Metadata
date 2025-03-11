public class ContactRecords {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String searchterm) {
        String searchwords= '%'+searchterm+'%';
        List<Contact> conList = [select Id, Name, Email from Contact where Name LIKE:searchwords];
        System.debug('Contact List ===>>' +conList);
        return conList;
    }
}