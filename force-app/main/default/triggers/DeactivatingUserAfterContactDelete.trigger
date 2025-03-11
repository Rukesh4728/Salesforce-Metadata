trigger DeactivatingUserAfterContactDelete on Contact (after delete) {
    List<User> usersToDeactivate = new List<User>();
    for (Contact con : Trigger.Old) {
        if (con.User__c != null) {
            User user = [SELECT Id, IsActive FROM User WHERE Id = :con.User__c];
            user.IsActive = false;
            usersToDeactivate.add(user);
        }
    }
    update usersToDeactivate;
}