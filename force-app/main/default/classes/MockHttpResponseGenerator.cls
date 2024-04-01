/**
*	@Author: Vartika Rai
*	@Company: HCL Technologies
*	@Class: Mock HTTP Response Generator class
*	@Comments: Contains various mock responses for testing web callouts
*	@Created Date: 07/16/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*/ 

@isTest
public class MockHttpResponseGenerator{
    
    public class MockHttpResponseGeneratorSuccess implements HttpCalloutMock {
        public HTTPResponse respond (HTTPRequest req)
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"totalRate": "0.0625","rates": [{"rate": 0.0625,"name": "CALIFORNIA","type": "State"}]}');
            res.setStatusCode(200);
            return res;
        }
	}
    
    public class MockHttpResponseGeneratorFailure implements HttpCalloutMock {
        public HTTPResponse respond (HTTPRequest req)
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"totalRate": "0.00"}');
            res.setStatusCode(800);
            return res;
        }
	}


}