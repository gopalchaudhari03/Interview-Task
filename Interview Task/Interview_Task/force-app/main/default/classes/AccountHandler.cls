public class AccountHandler {
	
    Public Static Void accountCreationAsInactive(List<Account> list_acc)
    {
        for(Account acc : list_acc)
        {
            acc.Active__c = 'false';
        }
    }
    
    Public Static Void teamMemberCreatedOnceAccountCreation(List<Account>list_account)
    {     
        List<SQX_Team_Members__c> list_teamMembers = new List<SQX_Team_Members__c>();
        for(Account acc :list_account)
        {
               
               SQX_Team_Members__c teamMember1= new SQX_Team_Members__c();
               teamMember1.Account__c = acc.id;
               teamMember1.Name = 'Team Member 1';
               list_teamMembers.add(teamMember1);
            
               SQX_Team_Members__c teamMember2= new SQX_Team_Members__c();
               teamMember2.Account__c = acc.id;
               teamMember2.Name = 'Team Member 2';
               list_teamMembers.add(teamMember2);
           
        }
        if(!list_teamMembers.isEmpty())
        {
            insert list_teamMembers;
        }
    }
    
    public static void checkMemberTypeToActivateAccount(Map<Id, Account> list_accountOld, List<Account> list_account,Map<Id, Account> list_accountNew )
    {
         Set<Id> accountIds = new Set<Id>();
        for(Account oldAcc: list_account){
            accountIds.add(oldAcc.Id);
        }
         Set<Id> accountId = new Set<Id>();
        // List<Account>oldAccountList = [Select Id, Name,Active__c, (SELECT Id, Name,Account__c, Member_Type__c FROM Team_Members__r where Id In :accountIds) From Account WHERE Id In: accountIds];
       List<SQX_Team_Members__c> oldAccountList = [SELECT Id, Name,Account__c, Member_Type__c FROM SQX_Team_Members__c where Account__c In :accountIds];
		system.debug('oldAccountList :'+oldAccountList);
        for(SQX_Team_Members__c tm :oldAccountList ){
            if(tm.Member_Type__c != 'Admin' || tm.Member_Type__c != 'HR'){
                accountId.add(tm.Account__c);
            }
        }
        List<Account>oldAccountList11 = [Select Id, Name,Active__c from Account where Id In : accountId];
        for(Account a : oldAccountList11){
            if(list_accountOld.get(a.id).Active__c != list_accountNew.get(a.id).Active__c && list_accountNew.get(a.id).Active__c=='true'){
               a.Active__c.addError('Can Not Update'); 
            }
            

        }
    }
}