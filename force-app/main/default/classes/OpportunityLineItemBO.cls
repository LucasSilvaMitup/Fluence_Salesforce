/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Helper class for Opportunity Line Item's Business Object actions.
*	@Comments: Actually responsible to calculate the discount applicable on one Line Item basing on the quantity.
*	@Created Date: 07/12/2021
*
*	---------------------------------------------------------FF---------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	1.0             Lucas Silva     10-11-2023      Changed calculateOpportunityMargin() to calculateOpportunityCurrencyFields()
*	1.1             Lucas Silva     02-02-2024      Removed calculateOpportunityCurrencyFields(), buildWAPCalculationTaxesMap(),
*	                                                getOpportunities(), calculateInitialPricesMap(), calculateProductPrice(),
*	                                                getProductCostAndProductWalkWay(), calculateProductCost(), calculateProductWalkAwayPrice(),
*	                                                calculateMargin() methods
*	==========================================================================================
*/
public class OpportunityLineItemBO {
    /*---------------------------------------------------------------------------------------------------------------------------
* Author: Allan Pecli
* Method Description: Calculation of the product discount basing on the quantity.
* CreatedDate: July 26, 2021
* Modification Comments:
-----------------------------------------------------------------------------------------------------------------------------*/
    public static void calculateProductDiscount(List<OpportunityLineItem> lstOpportunityLineItem)
    {
        Set<Id> productIds = new Set<Id>();
        Set<Id> pricebookIds = new Set<Id>();
        Set<String> currencyIsoCodes = new Set<String>();
        
        for(OpportunityLineItem oppLineItem : lstOpportunityLineItem){
            productIds.add(oppLineItem.Product2Id);
            pricebookIds.add(oppLineItem.TECH_Opportunity_PricebookId_Formula__c);
            currencyIsoCodes.add(oppLineItem.currencyIsoCode);
        } 
        Map<String,Product_Discount__c> productDiscounts = ProductDiscountDAO.getInstance().getProductDiscountMapInfobyParameters(productIds, pricebookIds, currencyIsoCodes);
        if(!productDiscounts.isEmpty()){
            for(OpportunityLineItem oppLineItem : lstOpportunityLineItem){
                if(productDiscounts.containsKey(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode)){
                    if(oppLineItem.Quantity < productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).First_Range__c){
                        oppLineItem.UnitPrice = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).First_Range_Value__c;
                    }
                    else if(oppLineItem.Quantity < productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Second_Range__c){
                        oppLineItem.UnitPrice = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Second_Range_Value__c; 
                    }else if(oppLineItem.Quantity < productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Third_Range__c){
                        oppLineItem.UnitPrice = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Third_Range_Value__c;
                    }else if(oppLineItem.Quantity < productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Fourth_Range__c){
                        oppLineItem.UnitPrice = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Fourth_Range_Value__c;
                    }else if(oppLineItem.Quantity < productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Fifth_Range__c){
                        oppLineItem.UnitPrice = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Fifth_Range_Value__c;
                    }else{
                        oppLineItem.UnitPrice = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Sixth_Range_Value__c;
                    }
                    oppLineItem.Applied_Product_Discount__c = productDiscounts.get(String.ValueOf(oppLineItem.Product2Id)+String.valueOf(oppLineItem.TECH_Opportunity_PricebookId_Formula__c)+oppLineItem.currencyIsoCode).Id;
                }
            } 
        }
    }

}