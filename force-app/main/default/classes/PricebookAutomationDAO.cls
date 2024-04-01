public class PricebookAutomationDAO {
    private static final PricebookAutomationDAO instance = new PricebookAutomationDAO();    
    private PricebookAutomationDAO(){}
    
    public static PricebookAutomationDAO getInstance() {
        return instance;
    }
    /*---------------------------------------------------------------------------------------------------------------------------
* Author: Allan Pecli
* Method Description: Retrieve the Price Book Automation Map with ID = Product__c + Price_Book__c + CurrencyIsoCode
* CreatedDate: July 27, 2021
* Modification Comments:
-----------------------------------------------------------------------------------------------------------------------------*/
    public Map<String,Price_Book_Automation__c> getPricebookAutomationMapInfobyParameters(Set<Id> resellerIDs, Set<String> channelValues, Set<String> regionValues, Set<String> marketValues, Set<String> partnerStatusValues, Set<String> currencyIsoCodes)
    {
        Map<String,Price_Book_Automation__c> mapPricebookAutomation = new Map<String,Price_Book_Automation__c>();
        for(Price_Book_Automation__c pricebookAutomation : [SELECT Id, Reseller__c, Channel__c, Region__c, Market__c, Price_Book__c, Partner_Status__c, CurrencyIsoCode FROM Price_Book_Automation__c WHERE  (Reseller__c IN : resellerIDs) OR ( Channel__c IN:channelValues AND Region__c IN:regionValues AND Market__c IN:marketValues AND Partner_Status__c IN:partnerStatusValues AND CurrencyIsoCode IN:currencyIsoCodes)  ]){
            if( pricebookAutomation.Reseller__c != null)
            {
                mapPricebookAutomation.put(String.valueOf(pricebookAutomation.Reseller__c),pricebookAutomation);
            }
            else
            {
                mapPricebookAutomation.put(String.valueOf(pricebookAutomation.Channel__c) + String.valueOf(pricebookAutomation.Region__c) + String.valueOf(pricebookAutomation.Market__c) + String.valueOf(pricebookAutomation.Partner_Status__c) + pricebookAutomation.CurrencyIsoCode,pricebookAutomation);
            }            
        }
        if(!mapPricebookAutomation.IsEmpty()){
            return mapPricebookAutomation;
        }else{
            return new Map<String,Price_Book_Automation__c>();
        }
    }
}