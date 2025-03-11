public class CaseTrigger {
    public static void CaseTriggerhandler(list<Case> lcase){
        list<Account> lacc=new list<Account>();
        for(Case c:lcase){
            if(c.AccountId!=null){
                Account acc=new Account();
                acc.LatestCaseNumber__c=c.CaseNumber;
                acc.Id=c.AccountId;
                lacc.add(acc);
                
            }
        }
        update lacc;
        
    }

}