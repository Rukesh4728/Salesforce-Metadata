trigger PreventContactTrigger on Contact (before insert) {
    PreventContactCreation.PreventContacthandler(Trigger.new);

}