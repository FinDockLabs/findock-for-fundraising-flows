public with sharing class FlowLauncherController {
    @AuraEnabled
    public static Map<String, String> getFlowConfigurations() {
        Map<String, String> returnList = new Map<String, String>();

        for ( FinDock_Flow_Configuration__mdt flowConfig : [select id, DeveloperName, Flow_Api_Name__c  from FinDock_Flow_Configuration__mdt ] ) {
            returnList.put( flowConfig.DeveloperName , flowConfig.Flow_Api_Name__c);
        }
        return returnList;
    }
}