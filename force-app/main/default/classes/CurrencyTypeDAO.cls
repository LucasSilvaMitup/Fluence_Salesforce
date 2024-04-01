/**
*	@Author: Lucas Silva
*	@Company: Biz2People
*	@Class: Data class for CurrencyType Standard Object.
*	@Comments:
*	@Created Date: 10/11/2023
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	==========================================================================================
*/
public with sharing class CurrencyTypeDAO {

    public static CurrencyTypeDAO getInstance(){
        return new CurrencyTypeDAO();
    }

    public List<CurrencyType> getActiveCurrencyTypes(){
        return [SELECT IsoCode, ConversionRate FROM CurrencyType WHERE IsActive=TRUE];
    }

}