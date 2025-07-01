/**
* @File Name : AccountController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : May 14, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | May 14, 2025 |   | Initial Version
**/

public class AccountController {
	@AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(Id accountId) {
        return [SELECT Id, Name, Industry, Phone FROM Account WHERE Id = :accountId LIMIT 1];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(){
        return [SELECT Id, Name, Amount, StageName FROM Opportunity LIMIT 100];
    }
    @AuraEnabled
    public static void updateOpportunities(List<Opportunity> oppList){
        update oppList;
    }
}