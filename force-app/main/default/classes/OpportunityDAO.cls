/**
*	@Author: Lucas Silva
*	@Company: Biz2People
*	@Class: Data class for Opportunity Standard Object.
*	@Comments:
*	@Created Date: 10/11/2023
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	==========================================================================================
*/
public with sharing class OpportunityDAO {

    public static OpportunityDAO getInstance(){
        return new OpportunityDAO();
    }

    public List<Opportunity> getOpportunitiesByIds(Set<Id> opportunityIds){
        return [SELECT Id, Margin__c, Walk_Away_Price__c, CurrencyIsoCode, Pricebook2Id,
               (SELECT Id, UnitPrice, Quantity, Product2Id, Product2.AMEA_ICOS__c, Product2.EMEA_ICOS__c, Opportunity.Pricebook2Id
               FROM OpportunityLineItems WHERE Product2.Name !=: Label.Surcharge_Product_Name)
               FROM Opportunity WHERE Id IN :opportunityIds];
    }

}