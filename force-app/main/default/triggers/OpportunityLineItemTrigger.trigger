/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Trigger: Execution trigger on OpportunityLineItem Object
*	@Comments: Actually responsible to add the pricebook automatically upon creation.
*	@Created Date: 07/26/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	1.0             Lucas Silva     08/04/2024      Commented line in before context - SSC-1303
*	==========================================================================================
*/
trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update, after insert, after update, after delete) {
    
     if(!Bypass_Configuration__c.getInstance(UserInfo.getUserId()).OpportunityLineItem_Trigger__c)
    {
        OpportunityLineItemTriggerHandler handler = new OpportunityLineItemTriggerHandler();
        
        //Before operations
        if(Trigger.isBefore)
        {	   
            //Handle Before Insert trigger event
            if(trigger.isInsert)
            {
                handler.handleOpportunityLineItemBeforeInsert(trigger.new);
            }
            //Handle Before Update trigger event
            if(trigger.isUpdate)
            {
                //handler.handleOpportunityLineItemBeforeUpdate(trigger.newMap,trigger.oldMap); 
            } 
        }
        //After operations
        if(Trigger.isAfter)
        {
            //Handle After Insert trigger event
            if(trigger.isInsert)
            {
                handler.handleOpportunityLineItemAfterInsert(trigger.new);
            }
            //Handle After Update trigger event
            if(trigger.isUpdate)
            {
                handler.handleOpportunityLineItemAfterUpdate(trigger.newMap,trigger.oldMap); 
            } 
             //Handle After Delete trigger event
            if(trigger.isDelete)
            {
                handler.handleOpportunityLineItemAfterDelete(trigger.old); 
            } 
        }
    }
}