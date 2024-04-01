/**
*   @Author: Allan Pecli
*   @Company: HCL Technologies
*   @Class: TestUtil class
*   @Comments: consists of methods to test Util class
*   @Created Date: 03/04/2022
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason
*   1.0             Lucas Silva     20-09-2023      Added new test methods
*   ==========================================================================================
*/
@IsTest
public class TestUtil {
    
    @IsTest
    public static void testhandlerMethods()
    {  
        Integer workingDays = Util.calculateWorkingDays(system.today(),system.today()+10);
        Date dateWithWorkingDays = Util.addBussinessDays(system.today(),10);
    }

    @IsTest
    public static void testGetLayoutMetadataByName(){
        List<Metadata.Metadata> metadataRecord = new List<Metadata.Metadata>();
        String layoutName = Label.LDRFLayoutName;
        Test.startTest();
        metadataRecord = Util.getLayoutMetadataByName(new List<String>{layoutName});
        Test.stopTest();
        Assert.areEqual(false, metadataRecord.isEmpty(), 'Layout metadata retrieved with success.');
    }

    @IsTest
    public static void testGetFieldNamesInLayoutByLayoutSection(){
        String layoutName = Label.LDRFLayoutName;
        String sectionName = Label.LDRFLayoutSectionLightingDesignDetails;
        List<Metadata.Metadata> metadataRecord = Util.getLayoutMetadataByName(new List<String>{layoutName});
        Set<String> fieldNames = new Set<String>();
        Test.startTest();
        fieldNames = Util.getFieldNamesInLayoutByLayoutSection((Metadata.Layout)metadataRecord[0], new Set<String>{sectionName});
        Test.stopTest();
        Assert.areEqual(false, fieldNames.isEmpty(), 'Field names were retrieved with success.');
    }
    
}