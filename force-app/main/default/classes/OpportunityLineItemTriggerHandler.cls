/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Consists of methods based on trigger events on OpportunityLineItem records
*	@Comments: 
*	@Created Date: 07/26/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	1.0             Lucas Silva     10-11-2023      Changed calculateOpportunityMargin() to calculateOpportunityCurrencyFields()
*	1.1             Lucas Silva     02-02-2024      Removed logic in handleOpportunityLineItemAfterInsert(), handleOpportunityLineItemAfterUpdate()
*                                                   and handleOpportunityLineItemAfterDelete() methods
*	==========================================================================================
*/
public class OpportunityLineItemTriggerHandler {
    //Method to handle BeforeInsert event for OpportunityLineItem
    public void handleOpportunityLineItemBeforeInsert(List<OpportunityLineItem> newOpportunityLineItems)
    {        
        //Calculate the Product Discount for OpportunityLineItem for which Quantity has been updated
        if(!newOpportunityLineItems.isEmpty())
        {
            OpportunityLineItemBO.calculateProductDiscount(newOpportunityLineItems);
        }
    }
    //Method to handle BeforeUpdate event for Opportunity
    public void handleOpportunityLineItemBeforeUpdate(Map<Id,OpportunityLineItem> newOpportunityLineItemsMap,Map<Id,OpportunityLineItem> oldOpportunityLineItemsMap)
    {        
        //prepare sets of OpportunityLineItem Ids from trigger.newMap for which Quantity has been updated
        List<OpportunityLineItem> lstOpportunityLineItemsToUpdate = new List<OpportunityLineItem>();
        for(OpportunityLineItem oppLineItem : newOpportunityLineItemsMap.values())
        {
            if(oldOpportunityLineItemsMap.containsKey(oppLineItem.Id))
            {
                if(oldOpportunityLineItemsMap.get(oppLineItem.Id).Quantity != oppLineItem.Quantity)
                {
                    lstOpportunityLineItemsToUpdate.add(oppLineItem);
                }
            }
        }          
        //Re-calculate the Product Discount for OpportunityLineItem for which Quantity has been updated
        if(!lstOpportunityLineItemsToUpdate.isEmpty())
        {
            OpportunityLineItemBO.calculateProductDiscount(lstOpportunityLineItemsToUpdate);
        }
    }
    //Method to handle AfterInsert event for Opportunity
    public void handleOpportunityLineItemAfterInsert(List<OpportunityLineItem> newOpportunityLineItems)
    {
    }  
    //Method to handle AfterUpdate event for Opportunity
    public void handleOpportunityLineItemAfterUpdate(Map<Id,OpportunityLineItem> newOpportunityLineItemsMap,Map<Id,OpportunityLineItem> oldOpportunityLineItemsMap)
    {
    }
    //Method to handle AfterDelete event for Opportunity
    public void handleOpportunityLineItemAfterDelete(List<OpportunityLineItem> newOpportunityLineItems)
    {
    }
}