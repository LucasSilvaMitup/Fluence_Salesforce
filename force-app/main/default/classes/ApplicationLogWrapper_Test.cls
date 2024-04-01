/**
 * Created by Barbara Neves on 16/04/2022.
 */

@IsTest
private class ApplicationLogWrapper_Test {
   @IsTest
    static void testApplicationLogCreation() {

        Application_Log__c appLog;
        ApplicationLogWrapper logWrapper = new ApplicationLogWrapper();
        appLog = logWrapper.createApplicationLog('Quote','Amount','38.0','40.2','a0V05000000sUaaEAE');
        System.assertEquals(appLog.Object_Name__c,'Quote');
        System.assertEquals(appLog.Field__c,'Amount');
        System.assertEquals(appLog.Old_Value__c,'38.0');
        System.assertEquals(appLog.New_Value__c,'40.2');
        System.assertEquals(appLog.Record_ID__c,'a0V05000000sUaaEAE');

      
    }
}