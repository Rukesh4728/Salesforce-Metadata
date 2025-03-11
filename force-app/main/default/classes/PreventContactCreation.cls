public class PreventContactCreation {
    public static void PreventContacthandler(list<Contact> con){
        
        for(Contact c:con){
            if(c.AccountId==null){
                c.addError('You cannot create a contact without account');
            }
            
        }
        
    }

}