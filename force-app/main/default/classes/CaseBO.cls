/**
*	@Author: Lucas Silva
*	@Company: Biz2People
*	@Class: Helper class for Case and contains Business Object actions.
*	@Created Date: 19/09/2023
*
------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason
*   -               -               -               -
*   ==========================================================================================
 */
public class CaseBO {

    /********************************************************
    * @param        cases - Case records
    * @description  Update Cloned LDRF Case's fields to null
    * @author       Lucas Silva
    * @date         20/09/2023  - Initial Version
    * ***************************************************/
    public static void removeFieldValuesForClonedLDRFCases(List<Case> cases){
        String layoutName = Label.LDRFLayoutName;
        String layoutSectionName = Label.LDRFLayoutSectionLightingDesignDetails;
        Set<String> fieldApiNames = Util.getFieldNamesInLayoutByLayoutSection(
                                    (Metadata.Layout)Util.getLayoutMetadataByName(new List<String>{layoutName})[0],
                                                                 new Set<String>{layoutSectionName}
                                    );
        if(!fieldApiNames.isEmpty()){
            for(Case caseObj : cases){
                //Apply logic only for LDRF Cloned Cases
                Boolean isLDRFCase = caseObj.RecordTypeId.equals(Constants.RECORDTYPE_ID_CASE_LDRF);
                Boolean isClonedCase = caseObj.isClone();
                if(isLDRFCase && isClonedCase){
                    for(String fieldAPIName : fieldApiNames){
                        caseObj.put(fieldAPIName,null);
                    }
                }
            }
        }
    }

}