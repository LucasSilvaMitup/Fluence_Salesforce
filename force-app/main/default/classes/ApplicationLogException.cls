/**
 * Created by Barbara Neves on 16/04/2022.
 */

public class ApplicationLogException extends Exception {  
 
    private  Application_Log__c applicationLog;
  
    public Application_Log__c createApplicationLog(String object_Name,String field,String prior_Value,String new_Value,String recordID) {
       
        applicationLog = new Application_Log__c(         
            Object_Name__c = object_Name,
            Field__c = field,
            Record_ID__c = recordID,
            Old_Value__c = prior_Value,
            New_Value__c = new_Value

        );
        
        return applicationLog;
    }

  
}