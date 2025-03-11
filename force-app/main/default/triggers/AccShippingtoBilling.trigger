trigger AccShippingtoBilling on Account (before insert,before update) {

    
    for(Account acc : Trigger.New)
    {
        if(trigger.IsInsert && Trigger.IsUpdate){
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingCountry = acc.BillingCountry;
            acc.ShippingState = acc.BillingState;
            
        }
    }
    
}