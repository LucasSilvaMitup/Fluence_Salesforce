/**
*   @Author: Phanindra Reddy B
*   @Company: Robert half
*   @Class: Constants class
*   @Comments: Consists of all static value that refers in another classes
*   @Created Date: 12/16/2021
*   @Version: 0.0
*
*   ------------------------------------------------------------------------------------------
*   Modification Log:
*   ==========================================================================================
*   @Version        @Author         @Date           @Reason
*   1.0             Lucas Silva     20-09-2023      Added new constants
*   ==========================================================================================
*/

public class Constants {

    //Opprunity StageName Values
    public static final String OPP_STAGENAME_DISCOVERY ='Discovery';
    public static final String OPP_STAGENAME_EVALUATION ='Evaluation';
    public static final String OPP_STAGENAME_SOLUTION_DESIGN ='Solution Design';
    public static final String OPP_STAGENAME_QUOTING_TERMS ='Quoting and Terms';
    public static final String OPP_STAGENAME_CUSTOMER_HURDLES ='Customer Hurdles';
    public static final String OPP_STAGENAME_VERBAL_COMMIT ='Verbal Commitment';
    public static final String OPP_STAGENAME_FINAL_REVIEW ='Final Review';
    public static final String OPP_STAGENAME_PO_AWAITING ='Awaiting PO';
    public static final String OPP_STAGENAME_PO_RECEIVED ='PO Received';
    public static final String OPP_STAGENAME_CLOSEDLOST ='Closed Lost';
    
    //Quote Status Values
    public static final String QUOTE_STATUS_PRESENTED ='Presented';
    public static final String QUOTE_STATUS_REJECTED ='Rejected';
    public static final String QUOTE_STATUS_APPROVED ='Approved';
    public static final String QUOTE_STATUS_PROMOTE_TO_ORDER ='Promote to Order';
    
    //Profiles
    public static final String PROFILE_SYSTEM_ADMIN ='System Administrator';

    //Case Record Type Ids;
    public static final Id RECORDTYPE_ID_CASE_LDRF = Schema.SObjectType.Case.getRecordTypeInfosByName().get('LDRF').getRecordTypeId();



}