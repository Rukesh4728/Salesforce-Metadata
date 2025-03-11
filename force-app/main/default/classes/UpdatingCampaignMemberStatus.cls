public class UpdatingCampaignMemberStatus {
    
    public static void UpdateCampaignMember(list<Lead> ld, map<Id, Lead> oldleadmap){
        set<Id> setids=new set<Id>();
        for(Lead newlead:ld){
            Lead oldlead=oldleadmap.get(newlead.Id);
            if(newlead.Status!=oldlead.Status){
                setids.add(newlead.Id);
            }
           
        }
        
        list<CampaignMember> cml=[select Id, Status from CampaignMember where LeadId IN: setids];
        list<CampaignMember> newcml=new list<CampaignMember>();
        
        for(CampaignMember cm:cml){
            Lead ld1=new Lead(Id=cm.Id);
            cm.Status=ld1.Status;
            newcml.add(cm);
        }
        update newcml;
    }

}