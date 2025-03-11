global class DefaultEmailUpdate implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Id,Email from Contact where Email=null]);
    }
    global void execute(Database.BatchableContext bc, List<Contact> con){
        List<Contact> lcon=new List<Contact>();
        for(Contact c:con){
                c.Email='rukesh.motaparthy@gmail.com';
                lcon.add(c);
        }
        update lcon;
    }
    global void finish(Database.BatchableContext bc){
        system.debug('All the empty email fields updated successfully!!!');
    }

}