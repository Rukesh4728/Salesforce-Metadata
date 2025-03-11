trigger PreventDuplicateContact on Contact (before insert, before update) {
    
    Set<String> emailSet = new Set<String>();
    for (Contact con : Trigger.new) {
        if (con.Email != null) {
            emailSet.add(con.Email.toLowerCase());
        }
    }

    set<String> emailToContactset = new set<String>();
    for (Contact existingCon : [SELECT Id, Email FROM Contact WHERE Email IN :emailSet]) {
        emailToContactset.add(existingCon.Email.toLowerCase());
    }

    for (Contact con : Trigger.new) {
        if (con.Email != null && emailToContactset.contains(con.Email.toLowerCase())) {
                con.addError('A contact with this email already exists.');
            }
        }
}