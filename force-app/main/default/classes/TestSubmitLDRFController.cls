/**
*   @Author: Vartika Rai
*   @Company: HCL Technologies
*   @Class: TestSubmitLDRFController class
*   @Comments: consists of methods to test submitLDRFController classes
*   @Created Date: 10/20/2021
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason 
*   ==========================================================================================
*/
@isTest
public class TestSubmitLDRFController {
    
    @testSetUp
    public static void setUpTestData()
    {
        List<Contact> conList = TestDataFactory.createContacts(1, true); 
        TestDataFactory.createCases(1, true, conList[0].Id);        
    }
    
    @isTest
    public static void testhandlerMethods()
    {  
        Case c = [select id from case limit 1];
        c.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('LDRF').getRecordTypeId();
        Database.update(c);
        submitLDRFController.submitLDRFCase(c.id);
    }
}