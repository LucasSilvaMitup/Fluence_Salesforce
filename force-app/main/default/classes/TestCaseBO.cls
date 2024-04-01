/**
*	@Author: Lucas Silva
*	@Company: Biz2People
*	@Class: Test class for CaseBO.
*	@Created Date: 20/09/2023
*
------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason
*   -               -               -               -
*   ==========================================================================================
 */

@IsTest
private class TestCaseBO {

    @TestSetup
    public static void setUpTestData(){
        Case caseLDRF = TestDataFactory.createCases (1, false, null)[0];
        caseLDRF.RecordTypeId = Constants.RECORDTYPE_ID_CASE_LDRF;
        insert caseLDRF;

    }

    @IsTest
    static void testRemoveFieldValuesForClonedLDRFCases(){
        List<Case> clonedCases = new List<Case>();
        Case caseLDRF = [SELECT Id, CaseNumber, Flex_Design__c, RecordTypeId FROM Case WHERE RecordTypeId =: Constants.RECORDTYPE_ID_CASE_LDRF LIMIT 1];
        //Updating Flex_Design__c once that is part of Lighting Design Details section
        caseLDRF.Flex_Design__c = 'New';
        update caseLDRF;

        //Simulates high number of records to process
        for(Integer i = 0; i < 200; i++){
            Case caseLDRFClone = caseLDRF.clone(false, true);
            clonedCases.add(caseLDRFClone);
        }

        Test.startTest();
        CaseBO.removeFieldValuesForClonedLDRFCases(clonedCases);
        Test.stopTest();
        Assert.areEqual(null, clonedCases[0].Flex_Design__c, 'Flex_Design__c was updated to null');
    }
}