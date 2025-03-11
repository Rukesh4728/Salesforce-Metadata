public with sharing class FormController {
    @AuraEnabled
    public static Id createRecord(String picklistValue1, String picklistValue2, String picklistValue3, String inputValue1, String inputValue2, Boolean checkboxValue) {
        Lead newLead = new Lead();
        newLead.Company = inputValue1; 
        newLead.FirstName = picklistValue1; 
        newLead.LastName = inputValue2; 
        newLead.IsConverted = checkboxValue; 
        newlead.Status= picklistValue2;
        newlead.City_Type__c= picklistValue3;

        insert newLead;
        return newLead.Id;
    }

    @AuraEnabled
    public static list<Lead> getRecord(Id leadId) {
        system.debug('checking leadId::'+leadId);
        return [SELECT Id, Company, FirstName, LastName, IsConverted, Status, City_Type__c FROM Lead WHERE Id = :leadId LIMIT 1];
    }
}