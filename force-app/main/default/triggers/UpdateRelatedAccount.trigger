trigger UpdateRelatedAccount on Contact (after insert) {
    List<Account> acc=new List<Account>();
    for(Contact c:Trigger.new){
        if(c.AccountId==null){
            Account ac=new Account();
            ac.Name=c.LastName;
            ac.Phone=c.Phone;
            acc.add(ac);
        }
    }
    
   insert acc;
}