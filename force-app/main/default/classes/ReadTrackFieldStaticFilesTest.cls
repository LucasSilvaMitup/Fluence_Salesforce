@isTest 
private class ReadTrackFieldStaticFilesTest{

   static testmethod void testLoadData() {
        
     
        ReadTrackFieldStaticFiles loadFile = new ReadTrackFieldStaticFiles();
        Set<String> testFields  = loadFile.checkObjectInFile('Quote');


        System.assertEquals(testFields.isEmpty(),false);
        System.assertEquals(testFields.size(),23);
       

    }


}