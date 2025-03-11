trigger TriggerUponCreationOfContact on Contact (after insert) {
    ContactRestAPI.sendemailconfirmation(Trigger.new);
}