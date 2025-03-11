public class Bulkinsertion{
    
    public static void bulkinsertion(){

        List<Account> accountList = new List<Account>();

           for (Integer i = 0; i < 200; i++) {
             Account acc = new Account();
             acc.Name = 'Account ' + i;
             accountList.add(acc);
             }

       // Insert all account records in a single DML statement
       insert accountList;
       system.debug('The account list is:'+accountList);
    }
    
}