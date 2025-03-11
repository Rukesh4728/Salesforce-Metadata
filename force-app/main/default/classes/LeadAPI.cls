@RestResource(urlMapping='/createContact')
global class LeadAPI {
    
    @HttpPost
    global static ResponseWrapper createContact() {
        ResponseWrapper response = new ResponseWrapper();
        
        try {
            // Get request body from RestContext
            String requestBody = RestContext.request.requestBody.toString();
            
            // Deserialize JSON request into a Contact object
            Contact contactData = (Contact) JSON.deserialize(requestBody, Contact.class);
            
            // Insert the Contact record
            insert contactData;
            
            // Prepare success response
            response.success = true;
            response.message = 'Contact created successfully and email sent to owner.';
            response.contactId = contactData.Id;
            
        } catch (Exception e) {
            // Handle error response
            response.success = false;
            response.message = 'Error: ' + e.getMessage();
        }
        
        return response;
    }

    // Method to send email notification
    private static void sendEmailNotification(String ownerId, Contact contactData) {
        if (String.isEmpty(ownerId)) {
            return; // Skip email if owner email is not found
        }
        
          // Fetch Contact Owner Safely
    List<User> ownerList = [SELECT Id, Email, Name FROM User WHERE Id = :ownerId LIMIT 1];

    // Check if owner exists
    if (ownerList.isEmpty() || String.isEmpty(ownerList[0].Email)) {
        return; // Exit if no owner found or email is missing
    }

    String ownermailid = ownerList[0].Email;


        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{ownermailid});
        mail.setSubject('New Contact Created: ' + contactData.FirstName + ' ' + contactData.LastName);
        mail.setPlainTextBody(
            'Hello,\n\n' +
            'A new contact has been created by an external system.\n\n' +
            'Contact Name: ' + contactData.FirstName + ' ' + contactData.LastName + '\n' +
            'Email: ' + contactData.Email + '\n' +
            'Phone: ' + contactData.Phone + '\n\n' +
            'Regards,\nSalesforce System'
        );

        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
    }

    // Wrapper class for API response
    global class ResponseWrapper {
        public Boolean success;
        public String message;
        public String contactId;
    }
}