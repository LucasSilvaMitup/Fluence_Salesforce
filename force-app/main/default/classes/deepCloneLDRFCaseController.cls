/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Consists of methods to Deep Clone LDRF Case.
*	@Comments: 
*	@Created Date: 02/17/2021
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason 
*	==========================================================================================
*/
public class deepCloneLDRFCaseController {
    
    @AuraEnabled
    public static boolean deepCloneLDRFCase(Id recordId)	
    {
        // Get the Map of Schema of Case SObject
        Map<String, Schema.SObjectField> caseFieldMap = Case.sObjectType.getDescribe().fields.getMap();
        
        // Get the Map of Schema of Case SObject 
        Map<String, Schema.SObjectField> ldrfFieldMap =  Schema.getGlobalDescribe().get('LDRF_Room__c').getdescribe().fields.getmap();
        
        // Get all of the fields on the object 
        Set<String> setCaseFieldNames = caseFieldMap.keySet();
        list<String> lstFieldNames = new List<String>(setCaseFieldNames);
        Set<String> setLDRFFieldNames = ldrfFieldMap.keySet();
        list<String> lstLDRFFieldNames = new List<String>(setLDRFFieldNames);
        
        // Dynamic Case Query String.
        Case caseToBeCloned = Database.query('SELECT ' + String.join(lstFieldNames, ',') + ' FROM Case where ID =\'' + recordId + '\'');

        Case clonedCase = caseToBeCloned.clone(false, true);
        clonedCase.ParentId = caseToBeCloned.Id;
        clonedCase.Status = 'New';
        clonedCase.Subject = 'Cloned: ' + clonedCase.Subject;
        clonedCase.External_ERP_ID__c ='';
        clonedCase.Opp_Prob_when_LDRF_submitted__c = 0;
        Database.SaveResult sr = Database.insert(clonedCase, false);
        
        List<LDRF_Room__c> clonedLDRFs = new List<LDRF_Room__c>();
        FOR(LDRF_Room__c ldrf : Database.query('SELECT ' + String.join(lstLDRFFieldNames, ',') + ' FROM LDRF_Room__c where Case__c IN (\'' + recordId + '\')')){
            LDRF_Room__c ldrfToCopy = ldrf.clone(false,true);
            ldrfToCopy.Case__c = sr.getId();
            clonedLDRFs.add(ldrfToCopy);
        }
        List<Database.SaveResult> ldrfSR = Database.insert(clonedLDRFs, false);
        
        Boolean childFailed = false;
        FOR(Database.SaveResult saveResult : ldrfSR){
            IF(!saveResult.isSuccess()){
                system.debug(saveResult.errors);
                childFailed = true;
            }
        }
        return (sr.isSuccess() && !childFailed ? true: false);
    }
}