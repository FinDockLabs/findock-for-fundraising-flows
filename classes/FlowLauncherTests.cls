@IsTest
public with sharing class FlowLauncherTests {
    static testMethod void customMetadataShouldContainTwoRecords() {
        Map<String, String> flowConfiguration = FlowLauncherController.getFlowConfigurations();
        Assert.areEqual(flowConfiguration.size(), 2);
    }
}