public class LeadTrigger {
    public static void leadhandler(list<Lead> newleads, list<lead> oldleads){
        map<Id, String> newmap=new map<Id, String>();
        for(Lead oldlead:oldleads){
            newmap.put(oldlead.Id, oldlead.Company);
        }
        
        for(Lead newlead:newleads){
            if(newlead.Company!=newmap.get(newlead.Id)){
                newlead.PreviousCompany__c=newmap.get(newlead.Id);
            }
        
    }

}
}