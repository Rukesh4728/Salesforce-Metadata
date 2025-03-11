trigger createopponaccount on Account (after insert) {
    List<Account> accList=Trigger.new;
    Account acc=accList[0];
    
    Opportunity opp=new Opportunity();
    opp.Name=acc.name+'-opp';
    opp.StageName='Prospecting';
    opp.CloseDate=system.today()+30;
    opp.AccountId=acc.Id;
    
    insert opp;

}