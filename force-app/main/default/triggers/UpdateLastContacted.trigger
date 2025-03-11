trigger UpdateLastContacted on Contact (after insert, after update) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : Trigger.new) {
        if (con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }

    Map<Id, Date> lastContactedMap = new Map<Id, Date>();
    for (AggregateResult ar : [SELECT AccountId, MAX(LastModifiedDate) maxDate FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
        lastContactedMap.put((Id)ar.get('AccountId'), (Date)ar.get('maxDate'));
    }

    List<Account> accountsToUpdate = new List<Account>();
    for (Contact con:Trigger.new) {
        if(lastContactedMap.containskey(con.AccountId)){
            Account acc = new Account(Id = con.AccountId);
            acc.LastContacted__c = lastContactedMap.get(con.AccountId);
            accountsToUpdate.add(acc);
        }
    }

    update accountsToUpdate;
}