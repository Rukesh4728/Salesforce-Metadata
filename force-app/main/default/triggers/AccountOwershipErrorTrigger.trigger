trigger AccountOwershipErrorTrigger on Account (before update) {
    AccountOwnershipError.AccountOwnershipErrorhandler(Trigger.new, Trigger.oldmap);
    

}