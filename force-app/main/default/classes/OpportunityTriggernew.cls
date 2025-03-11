public class OpportunityTriggernew {
   /* public static void Opportunitytriggerhandler(list<Opportunity> opp){
        set<Id> setid=new set<Id>();
        for(Opportunity op:opp){
            if(op.Amount>=500000){
                setid.add(op.AccountId);
            }

            }
         list<Account> lacc=[select Id, rating from Account where Id IN: setid];
        for(Account acc:lacc){
            acc.Rating='Hot';
        }
        update lacc;
        }*/
   /* public static void Oppurtunitytriggerhandler2(list<Opportunity> newvalue, map<Id, Opportunity> oldmap){
        list<Task> ltsk=new list<Task>();
        for(Opportunity opp: newvalue){
            if(oldmap.get(opp.id).stagename!=opp.stagename){
                Task tsk=new Task();
                tsk.Subject='Email';
                tsk.Status='Not Started';
                tsk.Priority='High';
                tsk.WhatId=opp.Id;
                ltsk.add(tsk);
            }
        }
        insert ltsk;
    }*/
    public static void myopportunityhandler(list<Opportunity> opp){
        set<Id> setid=new set<Id>();
        for(Opportunity op:opp){
            setid.add(op.Id);
        }
        
        list<OpportunityLineItem> newlist=[select Id, OpportunityId, Name, Description from OpportunityLineItem where Id IN: setid];
        for(OpportunityLineItem oli:newlist){
            if(setid.contains(oli.Id)){
            oli.Description='Opportunity has been updated';
            }
        }
        update newlist;
        
    }
            
            
 }