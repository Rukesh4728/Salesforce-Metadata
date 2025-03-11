trigger UpdatingCampaignMemberTrigger on Lead (after update) {
    UpdatingCampaignMemberStatus.UpdateCampaignMember(Trigger.new, Trigger.oldmap);

}