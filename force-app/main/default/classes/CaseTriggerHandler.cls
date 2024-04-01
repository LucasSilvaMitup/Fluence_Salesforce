/**
*   @Author: Vartika Rai
*   @Company: HCL Technologies
*   @Class: Consists of methods based on trigger events on Case records
*   @Comments: 
*   @Created Date: 10/11/2021
*   @Version: 0.0
*
*   --------------------------------------------------------------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason 
*   ==========================================================================================
*   1.0             Vartika Rai     10/21/2021      SFS-3: SPAM filter on Cases
*   1.1             Vartika Rai     10/26/2021      SFS-175: Email when SPAM deleted
*   1.2             Lucas Silva     09/08/2023      SFS-1114: Case deletion notice
*   1.3             Lucas Silva     20/09/2023      SFS-638: Blank values on Lighting Design Detail Section...
*   --------------------------------------------------------------------------------------------------------------------------------------------------
*/

public class CaseTriggerHandler {
    //Method to handle BeforeInsert event for Case
    public void handleCaseBeforeInsert(List<Case> newCases)
    {
        //START: prevents creation of General cases from spam email IDs
        Error_Handlers__mdt errorMessage = [Select MasterLabel,Error_Message__c from Error_Handlers__mdt where MasterLabel = 'SPAM Email'];
        Map<String,String>  spamEmailsMap = SpamEmailDAO.getInstance().getSpamEmails();
        for(Case c : newCases)
        {
            if(c.RecordTypeId == Label.General)
            {
                if(spamEmailsMap.ContainsKey(!string.isBlank(c.SuppliedEmail) ? c.SuppliedEmail : c.Contact_Email__c)){
                    Set<String> blockedSourcesSet = new Set<String>(!string.isBlank(c.SuppliedEmail) ? spamEmailsMap.get(c.SuppliedEmail).split(';') : spamEmailsMap.get(c.Contact_Email__c).split(';'));
                    if(blockedSourcesSet.contains(c.Origin)){
                        //c.addError(errorMessage.Error_Message__c);
                    }
                }
            }
        }
        //END: prevents creation of General cases from spam email IDs

        CaseBO.removeFieldValuesForClonedLDRFCases(newCases);
    }
   
    /*---------------------------------------------------------------------------------------------------------------------------
     * Author: Vartika Rai
     * Method Description: Method to handle AfterUpdate event for Case
     * CreatedDate: Oct 22, 2021
     * Reason: SFS-3: SPAM filter on Cases
     * Modification Comments:
    -----------------------------------------------------------------------------------------------------------------------------*/
    public void handleCaseAfterUpdate(Map<Id,Case> oldCasesMap,List<Case> newCases)
    {  
        List<SPAM_Email__c> spamEmailToBeInserted = new List<SPAM_Email__c>();
        Set<Id> caseIdsToBeDeleted = new Set<Id>();
        for(Case c : newCases)
        {
             if(c.RecordTypeId == Label.General && c.Spam__c && !oldCasesMap.get(c.Id).Spam__c && (!string.isBlank(oldCasesMap.get(c.Id).SuppliedEmail) ||!string.isBlank(oldCasesMap.get(c.Id).Contact_Email__c) ))
             {
                 caseIdsToBeDeleted.add(c.Id);
                 SPAM_Email__c spamEmailRecord = new SPAM_Email__c (Email_ID__c = !string.isBlank(oldCasesMap.get(c.Id).SuppliedEmail) ? oldCasesMap.get(c.Id).SuppliedEmail : oldCasesMap.get(c.Id).Contact_Email__c,Sources_to_Block__c = Label.Sources_To_Block);
                 spamEmailToBeInserted.add(spamEmailRecord);
             }
        }
        if(!spamEmailToBeInserted.isEmpty())
        {
            insert spamEmailToBeInserted;
        }
        if(!caseIdsToBeDeleted.isEmpty())
        {
            deleteSpamCases(caseIdsToBeDeleted);
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------------
     * Author: Vartika Rai
     * Method Description: Method to delete spam cases
     * CreatedDate: Oct 25, 2021
     * Reason: SFS-3: SPAM filter on Cases
     * Modification Comments:
    -----------------------------------------------------------------------------------------------------------------------------*/    
    @future
    public static void deleteSpamCases(Set<Id> caseIdsToBeDeleted)
    {
        if(caseIdsToBeDeleted != null && !caseIdsToBeDeleted.isEmpty())
        {
            List<Case> casesToBeDeleted = [Select id from Case where id IN: caseIdsToBeDeleted];
            delete casesToBeDeleted;
        }
    }
    
     /*---------------------------------------------------------------------------------------------------------------------------
     * Author: Vartika Rai
     * Method Description: Method to handle BeforeDelete event for Case
     * CreatedDate: Oct 26, 2021
     * Reason: SFS-175: Email when SPAM deleted
     * Modification Comments:
    -----------------------------------------------------------------------------------------------------------------------------*/
    public void handleCaseBeforeUpdate(Map<Id,Case> oldCasesMap,List<Case> newCases)
    {  
        
    }

}