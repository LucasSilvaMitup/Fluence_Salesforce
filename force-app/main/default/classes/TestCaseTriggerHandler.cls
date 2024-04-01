/**
*   @Author: Vartika Rai
*   @Company: HCL Technologies
*   @Class: TestCaseTriggerHandler class
*   @Comments: consists of methods to test CaseTrigger, CaseTriggerHandler, SpamEmailDAO classes
*   @Created Date: 10/18/2021
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason 
*   ==========================================================================================
*/
@isTest
public class TestCaseTriggerHandler {
    
    @testSetUp
    public static void setUpTestData()
    {
        TestDataFactory.createSPAMEmailRecords (1, true);
        List<Contact> conList = TestDataFactory.createContacts(1, true);              
    }
    
    @isTest
    public static void testhandlerMethods()
    {  
        List<Contact> conList = [Select id from contact limit 1];
        Error_Handlers__mdt errorMessage = [Select MasterLabel,Error_Message__c from Error_Handlers__mdt where MasterLabel = 'SPAM Email'];
        List<Case> casesToBeInserted = TestDataFactory.createCases(1, false, conList[0].Id);
        casesToBeInserted[0].ContactId = conList[0].Id; 
        List<Database.SaveResult> results = Database.insert(casesToBeInserted,false);
        for(Database.SaveResult rs : results)
        {
            for(Database.Error err: rs.getErrors())
            {
                System.assertEquals(errorMessage.Error_Message__c, err.getMessage());
            }
        }
        Spam_Email__c spam = [Select id from Spam_Email__c limit 1];
        delete spam;
        //insert casesToBeInserted;
        Case c = [select id from case limit 1];
        c.spam__c = true;
        update c;
    }
    
}