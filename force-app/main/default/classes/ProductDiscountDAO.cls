/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Data class for Product Discount's Object.
*	@Comments: 
*	@Created Date: 07/26/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*/
public class ProductDiscountDAO {
    private static final ProductDiscountDAO instance = new ProductDiscountDAO();    
    private ProductDiscountDAO(){}
    
    public static ProductDiscountDAO getInstance() {
        return instance;
    }
    /*---------------------------------------------------------------------------------------------------------------------------
* Author: Allan Pecli
* Method Description: Retrieve the Product Discount Map with ID = Product__c + Price_Book__c + CurrencyIsoCode
* CreatedDate: July 26, 2021
* Modification Comments:
-----------------------------------------------------------------------------------------------------------------------------*/
    public Map<String,Product_Discount__c> getProductDiscountMapInfobyParameters(Set<Id> productIds, Set<Id> pricebookIds, Set<String> currencyIsoCodes)
    {
        Map<String,Product_Discount__c> mapProductDiscount = new Map<String,Product_Discount__c>();
        For(Product_Discount__c productDisc : [SELECT Id, Product__c, Price_Book__c, CurrencyIsoCode, First_Range__c, First_Range_Value__c, Second_Range__c, Second_Range_Value__c, Third_Range__c, Third_Range_Value__c, Fourth_Range__c, Fourth_Range_Value__c, Fifth_Range__c, Fifth_Range_Value__c, Sixth_Range_Value__c FROM Product_Discount__c WHERE Product__c IN:productIds AND Price_Book__c IN:pricebookIds AND CurrencyIsoCode IN:currencyIsoCodes ]){
            mapProductDiscount.put(String.valueOf(productDisc.Product__c) + String.valueOf(productDisc.Price_Book__c).left(15) + productDisc.CurrencyIsoCode,productDisc);
        }
        if(!mapProductDiscount.IsEmpty()){
            return mapProductDiscount;
        }else{
            return new Map<String,Product_Discount__c>();
        }
    }
}