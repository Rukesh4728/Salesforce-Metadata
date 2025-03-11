trigger makingmandatory on Contact (before insert, before update) {
    for(Contact con:Trigger.new){
        if(con.Email==null || con.Email==''){
            con.Email.addError('Please enter an email');
        }
        if(con.Phone==null || con.Phone==''){
            con.Phone.addError('Please enter a Phone number');
        }
    }

}