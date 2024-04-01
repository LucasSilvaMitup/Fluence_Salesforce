/**
*	@Author: Vartika Rai
*	@Company: HCL Technologies
*	@Trigger: Execution trigger on Case Object
*	@Comments: Actually responsible to handle logic on trigger events
*	@Created Date: 10/11/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*      1.0				Vartika Rai			10/21/2021		SFS-3: SPAM filter on Cases
*      1.1				Vartika Rai			10/26/2021		SFS-175: Email when SPAM deleted
*      1.2              Lucas Silva         09/08/2023      SFS-1114: Case deletion notice
*	--------------------------------------------------------------------------------------------------------------------------------------------------
*/
trigger CaseTrigger on Case (before insert, after update) {
    
    if(!Bypass_Configuration__c.getInstance(UserInfo.getUserId()).Case_Trigger__c)
    {
        CaseTriggerHandler handler = new CaseTriggerHandler();
        
        //Before operations
        if(Trigger.isBefore)
        {	
            //Handle Before Insert trigger event
            if(trigger.isInsert)
            {
             	handler.handleCaseBeforeInsert(trigger.new);
            }
        }
         //After operations
        if(Trigger.isAfter)
        {	
            //Handle After Update trigger event
            if(trigger.isUpdate)
            {
             	handler.handleCaseAfterUpdate(trigger.oldMap,trigger.new);
            }
        }
    }   
}