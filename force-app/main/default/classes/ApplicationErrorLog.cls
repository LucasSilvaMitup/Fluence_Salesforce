public class ApplicationErrorLog {
  
    private String error;
    private String obj;
    private String stackTrace;
    private String shortError;
    private Id userId;
  
  
    public System.Exception exceptionObj;

    private Error_Log__c applicationLog;

    public Error_Log__c getApplicationLog() {
        if (applicationLog == null) {
            applicationLog = new Error_Log__c(
                Error_Log_Details__c = getError(),
                Object__c = getObject(),
                Stack_Trace__c = getStackTrace(),
                User__c = getUserId()             
            );
        }
        return applicationLog;
    }
    
    
    private String getShortError() {
        if (exceptionObj != null) {
            shortError = exceptionObj.getTypeName() + ':' + exceptionObj.getMessage();
        }
        return shortError;
    }

    private String getError() {
        if (error == null && exceptionObj != null) {
            error = getShortError();
        }
        return error.left(131000);
    }



    private String getObject() {
        return obj;
    }

    private String getStackTrace() {
        if (stackTrace == null) {
            if (exceptionObj != null) {
                stackTrace = exceptionObj.getStackTraceString();
            } else {
                stackTrace = new DmlException().getStackTraceString();
            }
        }
        return stackTrace;
    }

   

    private Id getUserId() {
        if (userId == null) {
            userId = UserInfo.getUserId();
        }
        return userId;
    }
  
}