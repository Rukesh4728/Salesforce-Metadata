public class AccountPhoneTrigger {
    public static void AccountPhoneTriggerhandler(list<Account> acc, map<Id, Account> accmap){

        for(Account ac1: acc){
            if(accmap.get(ac1.Id).Phone!=ac1.Phone){
                accmap.put(ac1.Id, ac1);
             
            }
        }
        list<Contact> con1=new list<Contact>();
        
        for(Contact c: [select Id, AccountId, MobilePhone from Contact where AccountId IN: accmap.keyset()]){
            if(accmap.containskey(c.AccountId)){
                c.MobilePhone=accmap.get(c.AccountId).Phone;
                con1.add(c);
            }
            
        }
        update con1;
    }

}