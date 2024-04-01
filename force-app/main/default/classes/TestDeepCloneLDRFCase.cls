/**
*   @Author: Allan Pecli
*   @Company: HCL Technologies
*   @Class: TestDeepCloneLDRFCase class
*   @Comments: consists of methods to test deepCloneLDRFCase class
*   @Created Date: 03/04/2022
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason 
*   ==========================================================================================
*/
@isTest
public class TestDeepCloneLDRFCase {
    
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
        deepCloneLDRFCaseController.deepCloneLDRFCase(c.id);
    }
    
}