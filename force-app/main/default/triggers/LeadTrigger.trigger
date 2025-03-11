trigger LeadTrigger on Lead (before update) {
    LeadTrigger.leadhandler(Trigger.new, Trigger.old);

}