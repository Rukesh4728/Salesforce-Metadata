public class AccountOwnershipError {
    public static void AccountOwnershipErrorhandler(List<Account> acc, map<Id, Account> accmap){
        for(Account a:acc){
            if(a.Industry=='Agriculture' && a.Type=='Prospect'){
                if(accmap.get(a.Id).Ownership!=a.Ownership){
                    a.Ownership.addError('Ownership Cannot be modified');
                }
            }
        }
        
    }

}