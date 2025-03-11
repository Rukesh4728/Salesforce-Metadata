public class AccountTrigger2 {
    public static void Accounttriggerhandler(list<Account> lacc){
        set<Id> accid=new set<Id>();
        for(Account acc: lacc){
            accid.add(acc.Id);
        }
        list<Contact> lcon=[select Id, AccountId, LastName from Contact where AccountId IN: accid];
        map<Id, Contact> newmap=new map<Id, Contact>();
        
        for(Account acc:lacc){
            newmap.put(acc.Id, acc.Contacts);
        }
        for(Contact con:lcon){
            if(newmap.get(con.AccountId)==newmap.get(con.Id)){
                con.AccountId=null;
            }
        }
    }

}