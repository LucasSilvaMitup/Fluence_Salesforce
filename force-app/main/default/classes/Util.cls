/**
*	@Author: Allan Pecli
*	@Company: HCL Technologies
*	@Class: Consists of generic methods.
*	@Comments: 
*	@Created Date: 02/16/2022
*	@Version: 0.0
*
*	------------------------------------------------------------------------------------------
*	Modification Log:
*	==========================================================================================
*	@Version		@Author			@Date			@Reason
*	1.0             Lucas Silva     20-09-2023      Added new utility methods
*   1.1             Lucas Silva     10-11-2023      Added buildISOCodesMap()
*	==========================================================================================
*/
public class Util {
    
    //Util method to calculate working days between dates.
    public static Integer calculateWorkingDays(Date startDate, Date endDate)  
    {          
        Set<Date> holidaysSet = new Set<Date>();  
        
        for(Holiday currHoliday : [SELECT ActivityDate FROM Holiday])  
        {  
            holidaysSet.add(currHoliday.ActivityDate);  
        }  
        
        Integer workingDays = 0;  
        
        for(integer i=0; i <= startDate.daysBetween(endDate); i++)  
        {  
            Date dt = startDate + i;  
            DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());  
            String todayDay = currDate.format('EEEE');  
            if(todayDay != 'Saturday' && todayDay !='Sunday' && (!holidaysSet.contains(dt)))  
            {  
                workingDays = workingDays + 1;  
            }     
            
        }  
        return workingDays;  
    } 
    
    //Util method to get N working days from N day.
    public static Date addBussinessDays(Date startDate, Integer iDays)
    {
        Integer businessDaysAdded = 0;
        Date currentDate = startDate;
        while (businessDaysAdded < iDays) {
            currentDate = currentDate.addDays(1);
            Datetime d = datetime.newInstance(currentDate.year(), currentDate.month(),currentDate.day());
            if (d.format('E') != 'Sat' && d.format('E') != 'Sun' && checkifItisWorkingDay(currentDate)) {
                // it's a business day, so add 1 to the counter that works towards the amount of days to add
                businessDaysAdded = businessDaysAdded + 1;
            } 
        }       
        return currentDate-1;
    }
    
    public static List<Holiday> holidays {
        get {
            if(holidays == null)
                holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
            return holidays;
        }
        private set;
    }
    
    public static boolean checkifItisWorkingDay(Date currentDate){
        Date weekStart  = currentDate.toStartofWeek();
        for(Holiday hDay:holidays){
            if(currentDate.daysBetween(hDay.ActivityDate) == 0){
                return false;
            }
        }
        if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } else 
            return true;
    }

    /********************************************************
    * @param        layoutNames - Layout Name records
    * @return       List of Metadata
    * @description  Retrieve Metadata record
    * @author       Lucas Silva
    * @date         20/09/2023  - Initial Version
    * ***************************************************/
    public static List<Metadata.Metadata> getLayoutMetadataByName(List<String> layoutNames){
        List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, layoutNames);
        return layouts;
    }

    /********************************************************
    * @param        layoutMd - Layout Metadata record
    * @param        layoutSectionNames - Layout Metadata record
    * @return       Set of object field's names found on layout sections
    * @description  Retrieve Object Field's Names
    * @author       Lucas Silva
    * @date         20/09/2023  - Initial Version
    * ***************************************************/
    public static Set<String> getFieldNamesInLayoutByLayoutSection(Metadata.Layout layoutMd, Set<String> layoutSectionNames){
        Set<String> fieldNames = new Set<String>();
        for (Metadata.LayoutSection section : layoutMd.layoutSections) {
            if (layoutSectionNames.contains(section.label)) {
                for (Metadata.LayoutColumn column : section.layoutColumns) {
                    if (column.layoutItems != null) {
                        for (Metadata.LayoutItem item : column.layoutItems) {
                            fieldNames.add(item.field);
                        }
                    }
                }
            }
        }
        return fieldNames;
    }

    /********************************************************
    * @return       Map of ConversionRate by CurrencyISOCode
    * @description  Retrieve ConversionRate by CurrencyISOCode
    * @author       Lucas Silva
    * @date         10/11/2023  - Initial Version
    * ***************************************************/
    public static Map<String, Decimal> buildISOCodesMap(){
        Map<String, Decimal> isoCodes = new Map<String, Decimal>();
        for(CurrencyType currencyTypeObj : CurrencyTypeDAO.getInstance().getActiveCurrencyTypes()){
            isoCodes.put(currencyTypeObj.IsoCode,currencyTypeObj.ConversionRate);
        }
        return isoCodes;
    }

}