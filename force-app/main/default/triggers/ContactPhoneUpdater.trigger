trigger ContactPhoneUpdater on Account (after insert) {
    set<Id> setids=new set<Id>();
    for(Account acc:Trigger.new){
        setids.add(acc.Id);
    }
 
    list<Contact> con=[select Id, HomePhone from Contact where AccountId IN: setids];
    list<Contact> newcon=new list<Contact>();
    
    for(Contact c:con){
        Account a=Trigger.newmap.get(c.AccountId);
        c.HomePhone=a.Phone;
        newcon.add(c);
    }
    update con;

}