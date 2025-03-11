@RestResource(urlMapping='/createContact/')
global with sharing class ContactRestAPI {
    @HttpPost
    global static String createContact(String firstName, String lastName, String email) {
        RestResponse res = RestContext.response;
        try {
            Contact newContact = new Contact(
                FirstName = firstName,
                LastName = lastName,
                Email = email
            );
            insert newContact;

            // Success Response
            res.statusCode = 201;
            return 'Contact Created with ID: ' + newContact.Id;
        } catch (Exception e) {
            res.statusCode = 500;
            return 'Error creating contact: ' + e.getMessage();
        }
    }
    
    global static void sendEmailConfirmation(List<Contact> conList) {
        
        Set<Id> contactIds = new Set<Id>();
        for (Contact c : conList) {
            if (c.Id != null) {
                contactIds.add(c.Id);
            }
        }

        if (contactIds.isEmpty()) {
            System.debug('No valid contact IDs found.');
            return;
        }

        // Query for Contacts
        List<Contact> contacts = [SELECT Id, LastName, Email FROM Contact WHERE Id IN :contactIds];

        // Prepare email details
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Contact c : contacts) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { 'rukesh.motaparthi@gmail.com' }); 
            email.setSubject('Confirmation of Contact Creation: ' + c.LastName);
            email.setPlainTextBody('A new Contact has been created with Last Name: ' + c.LastName);
            emails.add(email);
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
            System.debug('Confirmation emails sent successfully.');
        } else {
            System.debug('No emails were sent as the contact list was empty.');
        }
    }

}