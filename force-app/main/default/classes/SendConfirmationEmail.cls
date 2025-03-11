public class SendConfirmationEmail {
    @future
    public static void sendConfirmationEmail(Id opportunityId) {
    Opportunity opp = [SELECT Id, Name, Account.email__c FROM Opportunity WHERE Id = :opportunityId];
    // Logic to send email
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(new String[] { 'rukesh.motaparthi@gmail.com' });
    email.setSubject('Confirmation for Opportunity: ' + opp.Name);
    email.setPlainTextBody('Thank you for your business!');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
}


}