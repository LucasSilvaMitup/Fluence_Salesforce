public class ErrorLoggingUtility {
    
    
     public static Error_Log__c insertApplicationErrorLog(String err,String obj,String stackTrc,Id userId){
      
        Error_Log__c appLog = new Error_Log__c(Error_Log_Details__c = err,Object__c =obj,Stack_Trace__c= stackTrc,User__c = userId);                        
      
        insert appLog;  
        return appLog;
    }

}