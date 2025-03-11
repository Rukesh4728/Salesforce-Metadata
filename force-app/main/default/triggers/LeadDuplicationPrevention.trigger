trigger LeadDuplicationPrevention on Lead (before insert, before update) {
    set<string> newemailset=new set<string>();
    for(Lead ld: Trigger.new){
        if(ld.Email!=null){
            newemailset.add(ld.Email);
        }
    }
    
    list<Lead> oldemail=[select Email from Lead where Email IN: newemailset];
    set<string> existingemails=new set<string>();
    
    for(Lead ld1:oldemail){
        existingemails.add(ld1.Email);
    }
    
    for(Lead ld:Trigger.new){
        if(ld.Email!=null && existingemails.contains(ld.Email)){
            ld.addError('Duplicate record!!!');
        }
    }
    
}