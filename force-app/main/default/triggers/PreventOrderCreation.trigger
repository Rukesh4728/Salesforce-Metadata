trigger PreventOrderCreation on Order (before insert) {
    set<Id> setids=new set<Id>();
    for(Order ord:Trigger.new){
        setids.add(ord.AccountId);
    }
   
    list<Account> lacc=[select Id, Name from Account where Id IN (select AccountId from Case where Status!='Closed' and Priority='High')];
    
    for(Account acc:lacc){
        Order ord=new Order();
        ord.AccountId=acc.Id;
        ord.addError('Cannot create an order as there are open cases with high priority!!!');
    }
    
}