/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Helper class for Opportunity Line Item's Business Object actions.
*	@Comments: Actually responsible to automatically assign the pricebook basing on the parameters.
*	@Created Date: 07/12/2021
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*/
public class OpportunityBO {
    /*---------------------------------------------------------------------------------------------------------------------------
* Author: Allan Pecli
* Method Description: Automatically assignment of the pricebook basing on the Reseller / parameters.
* CreatedDate: July 26, 2021
* Modification Comments:
-----------------------------------------------------------------------------------------------------------------------------*/
    public static void automaticallyAssignPriceBook(List<Opportunity> lstOpportunities)
    {
        Set<String> channelValues = new Set<String>(); 
        Set<String> regionValues = new Set<String>();
        Set<String> partnerStatusValues = new Set<String>();
        Set<String> marketValues = new Set<String>();         
        Set<String> currencyIsoCodes = new Set<String>();
        Set<Id> resellerIds = new Set<Id>();
        Map<String,Price_Book_Automation__c> pricebookAutomations = new Map<String,Price_Book_Automation__c>();
        Boolean allowPricebookUpdate = [Select Allow_Pricebook_update_on_Opportunity__c From User Where Id = :UserInfo.getUserId()][0].Allow_Pricebook_update_on_Opportunity__c;
        
        for(Opportunity opp : lstOpportunities){
            if( opp.Pricebook2Id != null && !Bypass_Configuration__c.getInstance(UserInfo.getUserId()).Opportunity_Validation_Rule__c && !allowPricebookUpdate){
                opp.AddError(Label.Opportunity_Pricebook_on_creation_error_message);
            }else{
                resellerIds.add(opp.Reseller__c);
                channelValues.add(opp.Channel__c);
                regionValues.add(opp.Region__c);
                partnerStatusValues.add(opp.TECH_Account_Partner_Status_Formula__c);
                marketValues.add(opp.Market__c);
                currencyIsoCodes.add(opp.currencyIsoCode);
            }
        }
            pricebookAutomations = PricebookAutomationDAO.getInstance().getPricebookAutomationMapInfobyParameters(resellerIds, channelValues, regionValues, marketValues,partnerStatusValues, currencyIsoCodes);

        if(!pricebookAutomations.isEmpty()){
        for(Opportunity opp : lstOpportunities){
            if(opp.Reseller__c != null && pricebookAutomations.containsKey(String.valueOf(opp.Reseller__c )))
            {
                opp.Pricebook2Id = pricebookAutomations.get(String.valueOf(opp.Reseller__c )).Price_Book__c;
            }
            else
            {
                if(pricebookAutomations.containsKey(String.ValueOf(opp.Channel__c)+String.valueOf(opp.Region__c)+String.valueOf(opp.Market__c)+String.valueOf(opp.TECH_Account_Partner_Status_Formula__c)+opp.currencyIsoCode)){
                    opp.Pricebook2Id = pricebookAutomations.get(String.ValueOf(opp.Channel__c)+String.valueOf(opp.Region__c)+String.valueOf(opp.Market__c)+String.valueOf(opp.TECH_Account_Partner_Status_Formula__c)+opp.currencyIsoCode).Price_Book__c;
                }
            }            
        } 
    }
}
}