/**
*	@Author: Vartika Rai
*	@Company: HCL Technologies
*	@Class: TestOpportunityLineItemTrigger class
*	@Comments: consists of methods to test OpportunityTrigger, OpportunityTriggerHandler, OpportunityLineItemTrigger and OpportunityLineItemTrigger methods
*	@Created Date: 07/27/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	1.0             Lucas Silva     10-11-2023      Insert Bypass_Configuration__c in testhandlerMethods()
*	==========================================================================================
*/
@isTest
public class TestOpportunityLineItemTrigger {

      @testSetUp
    public static void setUpTestData()
    {
       List<Account> accList = TestDataFactory.createAccounts(2, true);
        accList[0].RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Reseller').getRecordTypeId();
        update accList;
        List<PriceBook2> pricebook = TestDataFactory.createPricebooks(1,true);
        List<Price_Book_Automation__c> pbaList = TestDataFactory.createPriceBookAutomation (2, true);
        pbaList[1].Price_Book__c = pricebook[0].id;
        pbaList[1].Reseller__c = accList[0].Id;
        pbaList[1].Market__c = '';
        pbaList[1].Region__c = '';   
        pbaList[1].Channel__c = '';   
        pbaList[1].Partner_Status__c = '';   
        update pbaList[1];
        TestDataFactory.createProductDiscount (1, true);        
        List<Opportunity> oppList = TestDataFactory.createOpportunities(1, true, accList[1].Id);
        List<Opportunity> oppWithResellersList = TestDataFactory.createOpportunitiesWithResellers (1, true, accList[1].Id, accList[0].Id);
    }
    
    @isTest
    public static void testhandlerMethods()
    {        
        System.runAs(TestDataFactory.createUser())
        {
            Opportunity opp = [Select id from Opportunity limit 1];
            Test.startTest();
            //Create ByPass record to bypass unnecessary processes
            Bypass_Configuration__c bypassConfiguration = new Bypass_Configuration__c();
            bypassConfiguration.Opportunity_Process__c = true;
            bypassConfiguration.SetupOwnerId = UserInfo.getUserId();
        	insert bypassConfiguration;
            
            List<OpportunityLineItem> oppLineItemList = TestDataFactory.createOppLineItems(1, true,opp.Id);
            oppLineItemList[0].quantity = 650;
            update oppLineItemList[0];
            oppLineItemList[0].quantity = 1500;
            update oppLineItemList[0];
            oppLineItemList[0].quantity = 100;
            update oppLineItemList[0];
            oppLineItemList[0].quantity = 2000;
            update oppLineItemList[0];
            oppLineItemList[0].quantity = 310;
            update oppLineItemList[0];
            Test.stopTest();
        }        
    }

}