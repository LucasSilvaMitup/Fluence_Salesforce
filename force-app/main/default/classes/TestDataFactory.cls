/**
*	@Author: Vartika Rai
*	@Company: HCL Technologies
*	@Class: TestDataFactory class
*	@Comments: consists of methods to create Test Data
*	@Created Date: 07/22/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	-              Lucas Silva     11/01/2024      Changed createQuoteLineItems() adding SAPQuoteLineItem__c = true
*	-              Lucas Silva     25/01/2024      Remove createAIRecord() method
*	==========================================================================================
*/
@isTest
public class TestDataFactory {
    
    /**
     * *******************************************************
     * This method is to create test data for SYS ADMIN USER
     * *******************************************************
     */
    public static User createUser()
    {
        String uniqueUserName = 'standardadmin' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName,Allow_Pricebook_update_on_Opportunity__c=true);
        insert u;
        return u;
    }
    
    /**
     * *******************************************************
     * This method is to create test data for ACCOUNT object
     * *******************************************************
     */
    public static List<Account> createAccounts(Integer count,Boolean doInsert)
    {
        List<Account> accList = new List<Account>();
        System.runAs(createUser())
        {
           
            for(Integer i = 0 ; i < count ; i++)
            {
                Account acc = new Account();
                acc.Name = 'Test Account+++ '+i;
                acc.Region__c = 'APAC';
                acc.Application__c = 'Indoor';
                acc.Channel__c = 'System Integrator';
                acc.Market__c = 'Cannabis';
                acc.Partner_Status__c = 'Signed';
                acc.BillingCountry = 'United States';
                acc.BillingCity = 'New York';
                acc.BillingState = 'New York';
                acc.BillingPostalCode = '94085';
                acc.BillingStreet = 'Test Street';
                acc.ShippingCountryCode = 'US';
                acc.ShippingCountry = 'United States'; 
                acc.ShippingCity = 'Austin'; 
                acc.ShippingPostalCode = '78744'; 
                acc.ShippingState = 'Texas'; 
                acc.ShippingStreet = '4129 Commercial Center Drive'; 
                acc.ShippingStateCode = 'TX';
                accList.add(acc);
            }
            if(doInsert){
                insert accList;
            }            
        } 
        return accList; 
    }
    
    /**
     * ************************************************************
     * These methods are to create test data for CONTACT object
     * ************************************************************
     */
    public static List<Contact> createContacts(Integer count,Boolean doInsert)
    {
        List<Account> accList = createAccounts(count,true);
        List<Contact> contactList = new List<Contact>();
        System.runAs(createUser())
        {
           for(Integer i = 0 ; i < count ; i++)
            {
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'contact'+i;
                con.AccountId = accList[i].Id;
                con.Email = con.LastName+'@abc.com';
                con.Phone = '99999999';
                contactList.add(con);
            }
            if(doInsert){
                insert contactList;
            } 
        }        
        return contactList;
    } 
    
	public static List<Contact> createContacts(Integer count,Boolean doInsert,Id accId)
    {
        List<Contact> contactList = new List<Contact>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'contact'+i;
                con.AccountId = accId;
                con.Email = con.LastName+'@abc.com';
                con.Phone = '99999999';
                contactList.add(con);
            }
            if(doInsert){
                insert contactList;
            }
        }        
        return contactList;
    }
    
    /**
     * *****************************************************************
     * These methods are to create test data for OPPORTUNITY object
     * *****************************************************************
     */
    
    public static List<Opportunity> createOpportunities(Integer count,Boolean doInsert)
    {
        List<Account> accList = createAccounts(count,true);
        List<Opportunity> oppList = new List<Opportunity>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Opportunity opp = new Opportunity();
                opp.Name = 'Test Opportunity++++ '+i;
                opp.AccountId = accList[i].Id;
                opp.Amount = 3000;
                opp.StageName = 'Discovery';
                opp.CloseDate = Date.today();
                opp.currencyIsoCode = 'USD';
        		opp.Market__c = 'Cannabis';
                opp.Status__c = 'Open';
                opp.Region__c = 'EMEA';
                opp.Pricebook2Id = Test.getStandardPricebookId();
                opp.Application__c = 'Greenhouse';
                opp.Reason__c = ''; 
                oppList.add(opp);
            }
            if(doInsert){
                insert oppList;
            }
        }        
        return oppList;
    }
    
    public static List<Opportunity> createOpportunities(Integer count,Boolean doInsert,Id accId)
    {
        List<Opportunity> oppList = new List<Opportunity>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Opportunity opp = new Opportunity();
                opp.Name = 'Test Opportunity '+i;
                opp.AccountId = accId;
                opp.Amount = 3000;
                opp.StageName = 'Discovery';
                opp.CloseDate = Date.today();
                opp.currencyIsoCode = 'USD';
        		opp.Market__c = 'Cannabis';
                opp.Status__c = 'Open';
                opp.Region__c = 'EMEA';
                opp.Application__c = 'Greenhouse';
                opp.Pricebook2Id = Test.getStandardPricebookId();
               opp.Reason__c = '';
                oppList.add(opp);
            }
            if(doInsert){
                insert oppList;
            }
        }        
        return oppList;
    }
    
    public static List<Opportunity> createOpportunitiesWithResellers(Integer count,Boolean doInsert,Id accId, Id resellerId)
    {
        List<Opportunity> oppList = new List<Opportunity>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Opportunity opp = new Opportunity();
                opp.Name = 'Test Opportunity++ '+i;
                opp.AccountId = accId;
                opp.Amount = 3000;
                opp.StageName = 'Discovery';
                opp.CloseDate = Date.today();
                opp.currencyIsoCode = 'USD';
        		opp.Market__c = 'Cannabis';
                opp.Status__c = 'Open';
                opp.Region__c = 'EMEA';
                opp.Application__c = 'Greenhouse';
                opp.Reseller__c = resellerId;
                oppList.add(opp);
            }
            if(doInsert){
                insert oppList;
            }
        }        
        return oppList;
    }
    
    /**
    * *****************************************************************
    * These methods are to create test data for CASE object
    * *****************************************************************
    */
    public static List<Case> createCases(Integer count, Boolean doInsert, String contactId)
    {
        List<Case> caseList = new List<Case>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Case cas = new Case(ContactId = contactId, Status ='New', Priority = 'Medium', Origin = 'Email',Subject = 'Test Case '+i, recordtypeid=Schema.SObjectType.Case.getRecordTypeInfosByName().get('General').getRecordTypeId());
                caseList.add(cas);
            }
            if(doInsert)
            {
                insert caseList ;
            }
        }        
        return caseList ;
    } 
    
    /**
    * *****************************************************************
    * These methods are to create test data for QUOTE object
    * *****************************************************************
    */
    public static List<Quote> createQuotes(Integer count, Boolean doInsert)
    {
        List<Opportunity> oppList = createOpportunities(count, true);
        List<Quote> quotesList = new List<Quote>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Quote qt = new Quote(Name = 'Quote '+i, OpportunityId = oppList[i].Id, ShippingHandling = 2000, ShippingCountryCode = 'US', ShippingCountry = 'United States', ShippingCity = 'Austin', ShippingPostalCode = '78744', ShippingState = 'Texas', ShippingStreet = '4129 Commercial Center Drive', ShippingStateCode = 'TX', Temporary_Address__c = true);
                quotesList.add(qt);
            }
            if(doInsert)
            {
                insert quotesList ;
            }
        }        
        return quotesList ;
    }
    
    public static List<Quote> createQuotes(Integer count, Boolean doInsert, Id OppId)
    {
        List<Quote> quotesList = new List<Quote>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Quote qt = new Quote(Name = 'Quote '+i, OpportunityId = OppId, ShippingHandling = 2000, ShippingCountryCode = 'US', ShippingCountry = 'United States', ShippingCity = 'Austin', ShippingPostalCode = '78744', ShippingState = 'Texas', ShippingStreet = '4129 Commercial Center Drive', ShippingStateCode = 'TX', Temporary_Address__c = true);
                quotesList.add(qt);
            }
            if(doInsert)
            {
                insert quotesList ;
            }
        }        
        return quotesList ;
    }
    
    public static List<Quote> createQuotes(Integer count, Boolean doInsert, Id OppId, Id ConId)
    {
        List<Quote> quotesList = new List<Quote>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                 	
                Quote qt = new Quote(Name = 'Quote '+i, ContactId = ConId, OpportunityId = OppId, ShippingHandling = 2000, ShippingCountryCode = 'US', ShippingCountry = 'United States', ShippingCity = 'Austin', ShippingPostalCode = '78744', ShippingState = 'Texas', ShippingStreet = '4129 Commercial Center Drive', ShippingStateCode = 'TX', Temporary_Address__c = true);
                quotesList.add(qt);
            }
            if(doInsert)
            {
                insert quotesList ;
            }
        }        
        return quotesList ;
    }
    
    /**
    * *****************************************************************
    * This method is to create test data for QUOTE LINE ITEM object
    * *****************************************************************
    */
    public static List<QuoteLineItem> createQuoteLineItems(Integer count, Boolean doInsert, Id qId)
    {
        List<QuoteLineItem> quotesLineItemsList = new List<QuoteLineItem>();
        System.runAs(createUser())
        {
            List<PricebookEntry> lstPricebookEntryToInsert = new List<PricebookEntry>();
            List<Product2> lstProductToInsert = new List<Product2>();
            Product2 pro = new Product2(Name = 'Test Product', Family = 'Mobile');
            lstProductToInsert.add(pro);
            
            pro = new Product2(Name = 'Surcharge', Family = 'Mobile');
            lstProductToInsert.add(pro);
            Insert lstProductToInsert;

            PricebookEntry pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(),Product2Id = lstProductToInsert[0].Id,UnitPrice = 1020,IsActive = true);
            lstPricebookEntryToInsert.add(pbe);
            
            pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(),Product2Id = lstProductToInsert[1].Id,UnitPrice = 1020,IsActive = true);
            lstPricebookEntryToInsert.add(pbe);
            
            Insert lstPricebookEntryToInsert;
            
            for(Integer i = 0 ; i < count ; i++)
            {
                QuoteLineItem qli = new QuoteLineItem(Product2Id = lstProductToInsert[0].Id, QuoteId = qId, Quantity = 5, PricebookEntryId = lstPricebookEntryToInsert[0].Id, UnitPrice = 1020, SAPQuoteLineItem__c = true);
                quotesLineItemsList.add(qli);
            }
            if(doInsert)
            {
                insert quotesLineItemsList ;
            }
        }        
        return quotesLineItemsList ;
    }
	
	/**
    * ****************************************************************************
    * This methods is to create test data for Opportunity Line Item object
    * ****************************************************************************
    */
    public static List<OpportunityLineItem> createOppLineItems(Integer count, Boolean doInsert)
    {
        List<Opportunity> oppList = createOpportunities(count, true);
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        System.runAs(createUser())
        {
            Product2 pro = new Product2(Name = 'Test Product', Family = 'Mobile');
            Insert pro;
            for(Integer i = 0 ; i < count ; i++)
            {
                OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = oppList[i].Id, Quantity = 1000, product2id = pro.id);
                oliList.add(oli);
            }
            if(doInsert)
            {
                insert oliList ;
            }
        }        
        return oliList ;
    }
    
    public static List<OpportunityLineItem> createOppLineItems(Integer count, Boolean doInsert, Id OppId)
    {
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        System.runAs(createUser())
        {            
            Opportunity opp = [select id,Pricebook2Id from opportunity where id =: OppId];
            opp.Pricebook2Id = Test.getStandardPricebookId();
            update opp;
        	Product2 pro = [select id from product2 where name = 'Test Product'];
            PricebookEntry pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(),Product2Id = pro.Id,UnitPrice = 1020,IsActive = true);
            Insert pbe;
            for(Integer i = 0 ; i < count ; i++)
            {
                OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = OppId, Quantity = 1000,  product2id = pro.id);
                oliList.add(oli);
            }
            if(doInsert)
            {
                insert oliList ;
            }
        }        
        return oliList ;
    }
    
    /**
    * ****************************************************************************
    * This methods is to create test data for PriceBook Automation object
    * ****************************************************************************
    */
    public static List<Price_Book_Automation__c> createPriceBookAutomation(Integer count, Boolean doInsert)
    {
        //Pricebook2 pbook = Test.getStandardPricebookId();
        List<Price_Book_Automation__c> pbaList = new List<Price_Book_Automation__c>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Price_Book_Automation__c pba = new Price_Book_Automation__c(Channel__c = 'System Integrator', Market__c = 'Cannabis', Partner_Status__c = 'Signed', Price_Book__c = Test.getStandardPricebookId(), Region__c = 'APAC', Key__c = 'PBA '+i, currencyisocode = 'USD');
                pbaList.add(pba);
            }
            if(doInsert)
            {
                Database.DMLOptions dml = new Database.DMLOptions(); 
 				dml.DuplicateRuleHeader.allowSave = true;
                Database.insert( pbaList, dml) ;
            }
        }        
        return pbaList ;
    }
    
    /**
    * ****************************************************************************
    * This methods is to create test data for Product Discount object
    * ****************************************************************************
    */
    public static List<Product_Discount__c> createProductDiscount(Integer count, Boolean doInsert)
    {
        //Pricebook2 pbook = Test.getStandardPricebookId();
        Product2 pro = new Product2(Name = 'Test Product', Family = 'Mobile');
        Insert pro;
        List<Product_Discount__c> pdList = new List<Product_Discount__c>();
        System.runAs(createUser())
        {
            for(Integer i = 0 ; i < count ; i++)
            {
                Product_Discount__c pd = new Product_Discount__c(Product__c = pro.id, Price_Book__c = Test.getStandardPricebookId(), Key__c = 'Product Discount '+i, First_Range__c = 250, First_Range_Value__c = 6000, Second_Range__c = 499, Second_Range_Value__c = 5000, Third_Range__c = 999, Third_Range_Value__c	= 4000, Fourth_Range__c = 1499, Fourth_Range_Value__c = 3000, Fifth_Range__c = 1999, Fifth_Range_Value__c = 2000, Sixth_Range_Value__c = 1000);
                pdList.add(pd);
            }
            if(doInsert)
            {
                insert pdList ;
            }
        }        
        return pdList ;
    }
    
     /**
    * ****************************************************************************
    * This methods is to create test data for Pricebook2 object
    * ****************************************************************************
    */
    public static List<PriceBook2> createPricebooks (integer count, Boolean doInsert)
    {
        List<PriceBook2> priceBookList = new List<PriceBook2>();
        for(integer i=0 ; i < count ; i++)
        {
            PriceBook2 pb2=new PriceBook2();
            pb2.Name = 'test' + i;
            pb2.IsActive = true;
            pb2.CurrencyIsoCode='USD';
            priceBookList.add(pb2);
        }
        if(doInsert)
        {
            insert priceBookList;
        }
        return priceBookList;
    }
    
     /**
    * ****************************************************************************
    * This methods is to create test data for SPAM_Email__c object
    * ****************************************************************************
    */
    public static List<SPAM_Email__c> createSPAMEmailRecords (integer count, Boolean doInsert)
    {
        List<SPAM_Email__c> spamEmailList = new List<SPAM_Email__c>();
        for(integer i=0 ; i < count ; i++)
        {
            SPAM_Email__c spemail = new SPAM_Email__c();
            spemail.Email_ID__c = 'contact'+i+'@abc.com';
            spemail.Sources_to_Block__c = 'Email;Email To Case;Web;Phone';
            spamEmailList.add(spemail);
        }
        if(doInsert)
        {
            insert spamEmailList;
        }
        return spamEmailList;
    }
}