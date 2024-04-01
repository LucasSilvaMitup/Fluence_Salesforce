/**
*   @Author: Allan Pecli
*   @Company: HCL Technologies
*   @Trigger: Execution trigger on Opportunity Object
*   @Comments: Actually responsible to add the pricebook automatically upon creation.
*   @Created Date: 07/26/2021
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason 
*   ==========================================================================================
*/
trigger OpportunityTrigger on Opportunity (before insert, before Update) {
    
    if(!Bypass_Configuration__c.getInstance(UserInfo.getUserId()).Opportunity_Trigger__c)
    {
        OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
        
        //Before operations
        if(Trigger.isBefore)
        {   
            //Handle Before Insert trigger event
            if(trigger.isInsert)
            {
                handler.handleOpportunityBeforeInsert(trigger.new);
            }
            //Handle Before Insert trigger event
            if(trigger.isUpdate)
            {
                handler.handleOpportunityBeforeUpdate(trigger.newMap, trigger.oldMap);
            }
        }
    }
   
}