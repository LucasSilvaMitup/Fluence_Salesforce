/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Data class for Opportunity Line Item Object.
*	@Comments: 
*	@Created Date: 11/12/2021
*
------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason
*   -              Lucas Silva     18/01/2024      Added getOppLineItemByProduct2Ids() method
*   ==========================================================================================
*/
public class OpportunityLineItemDAO {
    private static final OpportunityLineItemDAO instance = new OpportunityLineItemDAO();    
    private OpportunityLineItemDAO(){}
    
    public static OpportunityLineItemDAO getInstance() {
        return instance;
    }
    public Map<String,List<OpportunityLineItem>> getOpportunityLineItemMapInfobyOpportunityId(Set<Id> opportunityIds)
    {
        Map<String,List<OpportunityLineItem>> mapOpportunityAndLineItems = new Map<String,List<OpportunityLineItem>>();
        For(OpportunityLineItem opportunityLineItem : [SELECT Id, OpportunityId,Product2.AMEA_ICOS__c,Product2.EMEA_ICOS__c,Opportunity.Pricebook2Id,UnitPrice, Quantity, Product2.Standard_Cost__c, CurrencyIsoCode FROM OpportunityLineItem WHERE OpportunityId IN:opportunityIds AND Product2.Name !=: Label.Surcharge_Product_Name]){
            IF(!mapOpportunityAndLineItems.containsKey(opportunityLineItem.OpportunityId)){
                mapOpportunityAndLineItems.put(opportunityLineItem.OpportunityId, new List<opportunityLineItem>{opportunityLineItem});
            }else{
                List<opportunityLineItem> lst = mapOpportunityAndLineItems.get(opportunityLineItem.OpportunityId);
                lst.add(opportunityLineItem);mapOpportunityAndLineItems.put(opportunityLineItem.OpportunityId, lst);
            }
        }
        if(!mapOpportunityAndLineItems.IsEmpty()){
            return mapOpportunityAndLineItems;
        }else{
            return new Map<String,List<OpportunityLineItem>>();
        }
    }

    public List<OpportunityLineItem> getOppLineItemByProduct2Ids(Set<Id> product2Ids){
        return [SELECT Id, OpportunityId FROM OpportunityLineItem WHERE Product2Id IN :product2Ids AND Opportunity.IsClosed = FALSE];
    }
}