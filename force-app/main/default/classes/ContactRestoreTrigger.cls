public class ContactRestoreTrigger {
    public static void ContactRestoreTriggerhandler(list<Contact> con){
        list<Account> acc=new list<Account>();
        for(Contact newcon: con){
            Account acc1=[select id, Description from Account where id =: newcon.AccountId];
            acc1.Description='Contact has been restored';
            acc.add(acc1);
        }
        update acc;
        
        
    }

}