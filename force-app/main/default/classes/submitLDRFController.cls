/**
*	@Author: Vartika Rai
*	@Company: HCL Technologies
*	@Class: Consists of methods to submit LDRF Case and trigger Case Assignment rules
*	@Comments: 
*	@Created Date: 10/20/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*/
public class submitLDRFController {
    
    @AuraEnabled 
    public static boolean submitLDRFCase(Id recordId)	
    {
        Boolean isSuccess;
        //Fetching the assignment rules on case
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        
        //Creating the DMLOptions for "Assign using active assignment rules" checkbox
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        
        Case caseToBeSubmitted = [Select Id,Status,Submit_case__c,Is_FAE_Review_rejected__c,Is_FAE_Review_complete__c,RecordTypeId, Opportunity__r.Probability, Opp_Prob_when_LDRF_submitted__c, OwnerId, First_LDRF_Designer__c from case where Id =: recordId] ;
        //Setting the DMLOption on Case instance
        if(String.valueOf(caseToBeSubmitted.RecordTypeId).contains(Label.LDRF)){
            If(!Label.LDRFCaseStatusToPreventSubmission.contains(caseToBeSubmitted.Status)){
                if(Label.LDRFCaseStatusToChangeToSubmitted.contains(caseToBeSubmitted.Status)){
                    if(caseToBeSubmitted.Opp_Prob_when_LDRF_submitted__c == null || caseToBeSubmitted.Opp_Prob_when_LDRF_submitted__c == 0){
                        caseToBeSubmitted.Opp_Prob_when_LDRF_submitted__c = caseToBeSubmitted.Opportunity__r.Probability;
                        caseToBeSubmitted.Date_when_first_time_submitted__c = system.today();
                    } 
                    if(String.isBlank(caseToBeSubmitted.First_LDRF_Designer__c) && String.valueOf(caseToBeSubmitted.OwnerId).left(3) != '00G'){
                        caseToBeSubmitted.First_LDRF_Designer__c = caseToBeSubmitted.OwnerId;
                    }
                  
                    if(Label.LDRFCaseStatusToChangeToUrgentPriorityOnSubmission.contains(caseToBeSubmitted.Status) && caseToBeSubmitted.Is_FAE_Review_rejected__c){
   
                        caseToBeSubmitted.Priority = 'Urgent';
                        caseToBeSubmitted.Status = 'Submitted';

                    }else if(!Label.LDRFCaseStatusToChangeToUrgentPriorityOnSubmission.contains(caseToBeSubmitted.Status)){
                        if(Label.LDRFCaseStatusToChangeToHighPriorityOnSubmission.contains(caseToBeSubmitted.Status)){
                            caseToBeSubmitted.Priority = 'High';
                            caseToBeSubmitted.LDRF_Auto_Close_Date__c = Util.addBussinessDays(system.today(),10);
                        }
                        caseToBeSubmitted.Status = 'Submitted';    
                    }           
                    caseToBeSubmitted.Is_FAE_Review_rejected__c = FALSE;
                }
                caseToBeSubmitted.Submit_case__c = true;
                caseToBeSubmitted.setOptions(dmlOpts);
                Database.SaveResult sr = Database.update(caseToBeSubmitted, false);
                isSuccess = sr.isSuccess() ? true: false;
            } else{
                isSuccess = false;
            }
        } 
        return isSuccess;
    }
}