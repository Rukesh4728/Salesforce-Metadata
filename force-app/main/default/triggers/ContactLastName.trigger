trigger ContactLastName on Contact (before insert) {
    
    for(Contact con:Trigger.new){
        if(con.LastName==null){
            con.LastName='Unknown';
        }
    }

}