public class OpportunityTrigger {
    public static void Opportunityhandler(list<Opportunity> opplist){
    
        for(Opportunity opp:opplist){
            if(opp.Amount>100000){
                opp.Description='Hot opportunity';
            }
            else{
                opp.Description=' ';
            }
        }
        
    }

}