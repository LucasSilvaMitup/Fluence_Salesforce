/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Data class for Quote's Object.
*	@Comments: 
*	@Created Date: 07/12/2021
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	@Author:
*	@Date: 
*	@Reason: 
*/ 
public class QuoteDAO {
    private static final QuoteDAO instance = new QuoteDAO();    
    private QuoteDAO(){}
    
    public static QuoteDAO getInstance() {
        return instance;
    }
    public List<Quote> getQuoteListInfobyIds(Set<Id> quoteIds)
    {
        return [SELECT Id, Tax, ShippingPostalCode, ShippingStateCode, ShippingHandling, TotalPrice FROM Quote 
                WHERE Id IN:quoteIds];
    }
}