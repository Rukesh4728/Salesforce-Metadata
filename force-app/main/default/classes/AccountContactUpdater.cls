public class AccountContactUpdater {
    public static map<Account, list<Contact>> getaccounts(){
        map<Account, list<Contact>> newmap=new map<Account, list<Contact>>();
        list<Account> lacc=[select Id, (select Id, LastName from Contacts) from Account
                            where Id IN(select AccountId from Contact)];
        for(Account acc:lacc){
            list<Contact> con=acc.Contacts;
            newmap.put(acc,con);
        }
        system.debug('SSS :::' +newmap);
        return newmap;
    }
}