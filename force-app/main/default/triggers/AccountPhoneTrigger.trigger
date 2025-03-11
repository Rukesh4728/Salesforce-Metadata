trigger AccountPhoneTrigger on Account (after update) {
    AccountPhoneTrigger.AccountPhoneTriggerhandler(Trigger.new, Trigger.oldmap);

}