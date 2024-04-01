/**
*	@Author: Vartika Rai
*	@Company: HCL Technologies
*	@Class: Data class for Spam Email Object.
*	@Comments: 
*	@Created Date: 10/11/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*/
public class SpamEmailDAO {
    private static final SpamEmailDAO instance = new SpamEmailDAO();    
    private SpamEmailDAO(){}
    
    public static SpamEmailDAO getInstance() {
        return instance;
    }
    public Map<String,String>  getSpamEmails()
    {
        Map<String,String> spamEmailsMap = new Map<String,String>();
        for(SPAM_Email__c s : [SELECT Id, Name, Email_ID__c,Sources_to_Block__c from SPAM_Email__c])
        {
            spamEmailsMap.put(s.Email_ID__c,s.Sources_to_Block__c);
        }
        return !spamEmailsMap.isEmpty() ? spamEmailsMap : new Map<String,String>();       
    }
}