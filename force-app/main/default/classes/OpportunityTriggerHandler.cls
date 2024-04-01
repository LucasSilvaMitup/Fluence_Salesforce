/**
*   @Author: Allan Pecli
*   @Company: HCL Technologies
*   @Class: OpportunityTriggerHandler class
*   @Comments: Consists of methods based on trigger events on Opportunity records
*   @Created Date: 07/26/2021
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason 
*   ==========================================================================================
*/
public class OpportunityTriggerHandler{
    //Prevent recursion of trigger from Process builder
    private static Boolean isTriggerRan = false;
    //Method to handle BeforeInsert event for Opportunity
    public void handleOpportunityBeforeInsert(List<Opportunity> newOpportunities)
    {        
        //Calculate the Product Discount for OpportunityLineItem for which Quantity has been updated
        if(!newOpportunities.isEmpty())
        {
            OpportunityBO.automaticallyAssignPriceBook(newOpportunities);
        }
    }
    
    //Method to handle BeforeInsert event for Opportunity
    public void handleOpportunityBeforeUpdate(Map<Id, Opportunity> newMapOfOpportunities, Map<Id, Opportunity> oldMapOfOpportunities)
    {        
        //Throw Error for any changes done on closed opportunities except for system admins    
        String profileName = [Select id, Name from Profile where Id=:UserInfo.getProfileId()].Name;
        if(!isTriggerRan && !profileName.equalsIgnoreCase(CONSTANTS.PROFILE_SYSTEM_ADMIN)){
            isTriggerRan = true;
            preventUpdateOnClosedOpps(newMapOfOpportunities, oldMapOfOpportunities);
        }
        
        
    }
    
     // Issue if done through Validation rule since Process builder triggering validation rules even on new records and throws the error.
     
     public static void preventUpdateOnClosedOpps(Map<Id, Opportunity> newMapOfOpportunities, Map<Id, Opportunity> oldMapOfOpportunities){
         User currentUser = [select id, Allowed_to_Re_open_Opportunity__c from user where id=:userinfo.getuserid()];
         for(Opportunity oppRecords : newMapOfOpportunities.Values()){
             if(!currentUser.Allowed_to_Re_open_Opportunity__c && ((oldMapOfOpportunities.get(oppRecords.Id).StageName).equalsIgnoreCase(CONSTANTS.OPP_STAGENAME_PO_RECEIVED) ||
                 (oldMapOfOpportunities.get(oppRecords.Id).StageName).equalsIgnoreCase(CONSTANTS.OPP_STAGENAME_CLOSEDLOST))){
                 //ADD ERROR MESSAGE
                 oppRecords.addError( new OpportunityTriggerHandlerException (LABEL.ERR_MSG_EDITS_ON_CLOSED_OPPS));
             
             }      
         }   
     }
     
     private class OpportunityTriggerHandlerException extends Exception{}
}