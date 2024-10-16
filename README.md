<a href="https://githubsfdeploy.herokuapp.com?owner=FinDockLabs&repo=findock-for-fundraising-flows&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png"></a>

```text
NOTE: to be able to deploy this project to your Salesforce production environment your overall test code coverage needs to meet Salesforce thresholds.
Although this project has 100% coverage, existing custom code in your environment might push the overall coverage below the threshold. 
```

# FinDock for Fundraising Flows

A quick description for what this repo contains:
- FinDock versions of Salesforce Fundraising Flows (cloned & customised)
- Quick Action buttons linked to FinDock versions of Flows
- Gift Commitment Management LWC component linked to FinDock versions of Flows

Supporting permissions are included.

## Requirements

The prerequisites to deploy this repository are:
- Fundraising enabled and configured in your Salesforce environment
- The FinDock for Fundraising package is installed
The flows are updated to be compatible with Salesforce Winter '25.

The flows are updated to be compatible with Salesforce Summer '24'.

## Full list of components

```text
**classes**
classes/FlowLauncherController.cls
classes/FlowLauncherController.cls-meta.xml
classes/FlowLauncherTests.cls
classes/FlowLauncherTests.cls-meta.xml
classes/GfitCommitmentSetupControllerTest.cls
classes/GfitCommitmentSetupControllerTest.cls-meta.xml
classes/GiftCommitmentSetupController.cls
classes/GiftCommitmentSetupController.cls-meta.xml

**customMetadata**
customMetadata/FinDock_Flow_Configuration.Manage_Commitment_Schedules.md
customMetadata/FinDock_Flow_Configuration.Update_Commitment_Schedule.md

**flexipages**
flexipages/Gift_Commitment_Record_Page.flexipage

**flows**
flows/Manage_Gift_Commitment_Schedules_FinDock.flow
flows/Update_Recurring_Gift_Commitment_Schedule_FinDock.flow

**layouts**
layouts/FinDock_Flow_Configuration__mdt-FinDock Flow Configuration Layout.layout

**objects**
objects/FinDock_Flow_Configuration__mdt.object

**permissionsets**
permissionsets/FinDock_Fundraising_Flows.permissionset

**quickActions**
quickActions/GiftCommitment.Manage_Gift_Commitment_Schedules.quickAction
quickActions/GiftCommitment.fd_update_paymentmethod.quickAction
quickActions/GiftCommitment.fd_upgrade_downgrade.quickAction
```

## Installation
- make sure your user has permissions to all objects referenced by the components in this repository. This includes FinDock permissions and Fundraising permissions.
- use `sfdx` to deploy a selection of or all components.
- press the "Deploy to Salesforce" button at the top of this README and then press "Login to Salesforce" in the top right of your screen. Please note, the GitHub Salesforce Deploy Tool is provided open source by [andyinthecloud](http://andyinthecloud.com/category/githubsfdeploy/). No FinDock support is provided.
- any other deployment method you prefer.

## Configuration
- Assign the deployed Gift Commitment Lightning Record page to profiles or as organization default to include the custom Gift Commitment Management LWC component
- Assign the permission set `FinDock Fundraising Flows` to the right users
- Replace all Salesforce versions of the components like buttons with the FinDock versions:
  - Got to the Salesforce Layout editor for Gift Commitment, Account, Gift Transaction
  - Under Salesforce Mobile and Lightning Experience Actions press "override actions"
  - Remove the following default actions and replace them with the FinDock Mobile & Lightning Actions:
    - `Manage Gift Commitment Schedules`
    - `Upgrade | Downgrade`
    - `Update Payment Method`
  - Create new or change your Action Launcher Deployments and replace them on your layouts 


## Contributing

When contributing to this repository, please first discuss the change you wish to make via an issue or any other method with FinDock before making a change.

## Support

FinDock Labs is a non-supported group in FinDock that releases applications. Despite the name, assistance for any of these applications is not provided by FinDock Support because they are not officially supported features. For a list of these apps, visit the FinDock Labs account on Github.

## License

This project is licensed under the MIT License - see the [LICENSE](/LICENSE) file for details
