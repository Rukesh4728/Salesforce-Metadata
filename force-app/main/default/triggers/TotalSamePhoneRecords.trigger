trigger TotalSamePhoneRecords on Contact (after update) {
    set<Id> setids=new set<Id>();
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Contact con:Trigger.new){
            setids.add(con.AccountId);
        }
       
        Integer Count =0;
        Map<Id,Integer> mapvar = new Map<Id,Integer>();
        List<Account> accList = [select Id,Phone,(Select Id ,Phone from Contacts where Phone != null) from Account where Phone != null and Id IN: setids];
        for(Account acc : acclist)
        {
            for(Contact con : acc.Contacts)
            {
                 if(con.Phone == acc.Phone){
                Count += 1;   
            }
            mapvar.put(acc.Id,Count);
            }
           
         }
         
        list<Account> listacc = new list<Account>();
        for(Contact con: Trigger.New){
             Account acc=new Account(Id=con.AccountId);
             Integer contactCount = mapvar.get(con.AccountId);
             acc.Description = 'Count of Contact ='+contactCount;
              listacc.add(acc);
        }
        Update listacc;   
    }

}