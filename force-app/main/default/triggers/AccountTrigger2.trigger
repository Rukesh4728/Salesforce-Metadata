trigger AccountTrigger2 on Account (before delete) {
    AccountTrigger2.Accounttriggerhandler(Trigger.old);
}