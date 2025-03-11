trigger CaseTrigger on Case (after insert) {
    CaseTrigger.CaseTriggerhandler(Trigger.new);

}