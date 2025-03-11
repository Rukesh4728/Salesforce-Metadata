trigger CreateCaseRecord on Account (after update) {
    set<Id> setids=new set<Id>();
    for(Account acc: Trigger.new){
        if(acc.AnnualRevenue>1000000){
            setids.add(acc.Id);
        }
    }
    list<Case> lcs=new list<Case>();
    for(Account acc: Trigger.new){
        Case cs=new Case();
        cs.Priority='High';
        cs.AccountId=acc.Id;
        lcs.add(cs);
    }
    insert lcs;
}