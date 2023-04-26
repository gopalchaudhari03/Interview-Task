trigger AccountTrigger on Account (before insert, after insert,before update) {
    
    if(Trigger.isBefore && Trigger.isInsert)
    {
        AccountHandler.accountCreationAsInactive(Trigger.new);
    }
	if(Trigger.isAfter && Trigger.isInsert)
    {
        AccountHandler.teamMemberCreatedOnceAccountCreation(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        AccountHandler.checkMemberTypeToActivateAccount(Trigger.oldMap, Trigger.new,Trigger.newMap);
    }
}