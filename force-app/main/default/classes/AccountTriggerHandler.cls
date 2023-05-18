public class AccountTriggerHandler {
    public static void createdDefaultContact(List<Account> accLst){
        List<Contact> conLstToInsert = new List<Contact>();
        if(accLst.size() > 0){
            Contact objCon;
            for(Account acc:accLst){
                if(acc.Type == 'Customer - Direct' || acc.Type == 'Customer - Channel'){
                    if(acc.Account_Active__c == true){
                        objCon = new Contact();
                        objCon.FirstName = acc.Name;
                        objCon.LastName = 'Customer Representative';
                        objCon.Email = acc.Company_Email__c;
                        objCon.AccountId = acc.Id;
                        objCon.Default_Contact__c = true;
                        objCon.Phone = acc.Phone;
                        conLstToInsert.add(objCon);
                    }
                }
            }
            if(conLstToInsert.size() > 0){
                insert conLstToInsert;
            }
        }
    }
    public static void afterUpdateHandler(List<Account> accLst, Map<Id,Account> mapOfAccount){
        List<Id> accIdLst = new List<Id>();
        List<Contact> conLstToInsert = new List<Contact>();
        if(accLst.size() > 0){
            for(Account objAcc:accLst){
               accIdLst.add(objAcc.Id); 
            }
            List<Contact> conList = [Select Id,AccountId,Default_Contact__c From Contact Where AccountId =:accIdLst And Default_Contact__c = true];
            for(Contact con:conList){
                integer index = accIdLst.indexOf(con.AccountId);
                accIdLst.remove(index);
            }
            Contact objCon;
            for(Account acc:accLst){ 
                if(accIdLst.contains(acc.Id)){
                    if(acc.Account_Active__c == true){
                        if(acc.Account_Active__c != mapOfAccount.get(acc.Id).Account_Active__c){
                            if(acc.Type == 'Customer - Direct' && mapOfAccount.get(acc.Id).Type != 'Customer - Channel'  || acc.Type == 'Customer - Channel' && mapOfAccount.get(acc.Id).Type != 'Customer - Direct'){
                                objCon = new Contact();
                                objCon.FirstName = acc.Name;
                                objCon.LastName = 'Customer Representative';
                                objCon.Email = acc.Company_Email__c;
                                objCon.AccountId = acc.Id;
                                objCon.Default_Contact__c = true;
                                objCon.Phone = acc.Phone;
                                conLstToInsert.add(objCon);
                            }  
                        }
                    } 
                }
            } 
            
            System.debug('conLstToInsert'+conLstToInsert);
            if(conLstToInsert.size() > 0){
                insert conLstToInsert;
            }
        }
    }
}