trigger CaseEmailUpdate on Contact (after update) {
    map<Id, string> newmap=new map<Id, string>();
    for(Contact con: Trigger.new){
        Contact oldcons=Trigger.oldmap.get(con.Id);
        if(con.Email!=oldcons.Email){
            newmap.put(con.Id, con.Email);
        }
    }
    
    list<Case> relatedcases=[select Id, ContactId, CaseNumber, SuppliedEmail from Case where ContactId IN: newmap.keySet() and Status!='Closed'];
    
    for(Case c: relatedcases){
        if(newmap.containskey(c.ContactId)){
            c.SuppliedEmail=newmap.get(c.ContactId);
        }
    }
    update relatedcases;
    
}