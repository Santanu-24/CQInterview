@isTest(SeeAllData=false)
public class Test_AccoutTriggerHadler {
    public static testMethod void testAccountTrigger(){
        Account acc1 = new Account();
        acc1.Name = 'Test Santanu2';
        acc1.Type = 'Customer - Direct';
        acc1.Account_Active__c = true;
        insert acc1;
               
        Account acc2 = new Account();
        acc2.Name = 'Test Santanu2';
        insert acc2;
        
        Account acc =  [Select Id From Account Where Id =:acc2.Id limit 1];
        acc.Account_Active__c = true;
        acc.Type = 'Customer - Direct';
        acc.Account_Active__c = true;
        acc.Company_Email__c = 'santanu.pati@kvpcorp.com';
        acc.Phone = '8480902532';
        Test.startTest();
        
        update acc;
        
        System.debug([Select Id from Contact where AccountId =:acc.Id].size());
        Test.stopTest();
    }
}