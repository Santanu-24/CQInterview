@RestResource(urlMapping='/LoanRequest/*') 

Global class LoanWebService  

{ 

    @HttpPost 

    Global static void submitLoanRequest() 

    { 

        RestRequest request = RestContext.request; 

        RestResponse response = RestContext.response; 

        String jsonString=request.requestBody.toString(); 

        System.debug('request-->'+jsonString); 

         

        try{ 

            System.debug(jsonString); 

            LoanObject lObj=(LoanObject) System.JSON.deserialize(jsonString, LoanObject.class); 

            Alpine_Loan__c lObj2=new Alpine_Loan__c(); 

            lObj2.Name=lObj.firstName; 

            lObj2.Last_Name__c=lObj.lastName; 

            lObj2.Zip_Code__c=lObj.zipCode; 

            lObj2.Loan_Amount__c=Decimal.valueOf(lObj.loanAmount); 

            lObj2.Phone__c=lObj.phone; 

            lObj2.rating__c=lObj.rating; 

            insert lObj2; 

            response.responseBody = Blob.valueOf('Success--> '); 

             

            //return 'Success--> '+acc.Id; 

        }catch(Exception exp){ 

            response.responseBody = Blob.valueOf('Failed--> '+exp.getMessage()); 

            //return Blob.valueOf('Failed--> '+exp.getMessage(); 

        } 

    } 

    @HttpGet 

    Global static void getLoanRecords() 

    { 

        try 

        { 

            RestResponse response = RestContext.response; 

            List<Alpine_Loan__c> lList=[Select id,Name,Last_Name__c,Zip_Code__c,Loan_Amount__c,Phone__c,Rating__c from Alpine_Loan__c]; 

            String jsonStr = JSON.serialize(lList); 

            response.responseBody = Blob.valueOf(jsonStr.remove('__c')); 

        } 

        catch(Exception e) 

        { 

            System.debug('Error==>'+e.getMessage()); 

            System.debug('Error==>'+e.getLineNumber()); 

            //return 'Unsuccessful'; 

        } 

         

    } 

    @HttpPATCH 

    Global static void updateLoanRequest() 

    { 

        RestRequest request = RestContext.request; 

        RestResponse response = RestContext.response; 

        String jsonString=request.requestBody.toString(); 

        System.debug('request-->'+jsonString); 

         

        try{ 

            System.debug(jsonString); 

            LoanObjectUpdate lObj=(LoanObjectUpdate) System.JSON.deserialize(jsonString, LoanObjectUpdate.class); 

            Alpine_Loan__c lObj2=new Alpine_Loan__c(); 

            lObj2.Id=lObj.id; 

            lObj2.Name=lObj.firstName; 

            lObj2.Last_Name__c=lObj.lastName; 

            lObj2.Zip_Code__c=lObj.zipCode; 

            lObj2.Loan_Amount__c=Decimal.valueOf(lObj.loanAmount); 

            lObj2.Phone__c=lObj.phone;             

            lObj2.rating__c=lObj.rating; 

            update lObj2; 

            response.responseBody = Blob.valueOf('Success--> '); 

             

            //return 'Success--> '+acc.Id; 

        }catch(Exception exp){ 

            response.responseBody = Blob.valueOf('Failed--> '+exp.getMessage()); 

            //return Blob.valueOf('Failed--> '+exp.getMessage(); 

        } 

    } 

    @HttpDelete 

    Global static void deleteLoanRequest() 

    { 

        RestRequest request = RestContext.request; 

        RestResponse response = RestContext.response; 

        String jsonString=request.requestBody.toString(); 

        System.debug('request-->'+jsonString); 

         

        try{ 

            System.debug(jsonString); 

            Alpine_Loan__c lObj2=new Alpine_Loan__c(); 

            lObj2.Id=jsonString;           

            delete lObj2; 

            response.responseBody = Blob.valueOf('Success--> '); 

             

        }catch(Exception exp){ 

            response.responseBody = Blob.valueOf('Failed--> '+exp.getMessage()); 

        } 

    } 

    Global class LoanObject  

    {        

        public String firstName; 

        public String lastName; 

        public String zipCode; 

        public String loanAmount; 

        public String phone; 

        public String rating; 

    } 

    public class LoanObjectUpdate {        

        public String firstName; 

        public String lastName; 

        public String zipCode; 

        public String loanAmount; 

        public String phone; 

        public String rating; 

        public String id; 

    } 

}