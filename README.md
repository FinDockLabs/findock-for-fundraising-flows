# FinDock for Fundraising Flows

<!-- INSTALL_LINK:START -->
<a href="https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP4000001mo6nIAA" target="_blank" rel="noopener noreferrer"><img alt="Install in a production or Developer org" src="https://img.shields.io/badge/Install-Production%20or%20Developer%20org-00A1E0?style=for-the-badge"></a>
<a href="https://test.salesforce.com/packaging/installPackage.apexp?p0=04tP4000001mo6nIAA" target="_blank" rel="noopener noreferrer"><img alt="Install in a sandbox" src="https://img.shields.io/badge/Install-Sandbox-6B7A8F?style=for-the-badge"></a>

Version 0.1.0-1
<!-- INSTALL_LINK:END -->

This application is distributed as an org-dependent unlocked package.

```text
NOTE: for source deployments to your Salesforce production environment your overall test code coverage needs to meet Salesforce thresholds.
Although this project has 100% coverage, existing custom code in your environment might push the overall coverage below the threshold. 
```

A quick description for what this repo contains:
- FinDock versions of Salesforce Fundraising Flows (cloned & customised)
- Quick Action buttons linked to FinDock versions of Flows
- Gift Commitment Management LWC component linked to FinDock versions of Flows

Supporting permissions are included.

## Requirements

The prerequisites to deploy this repository are:
- Salesforce Winter '27 or later
- Fundraising enabled and configured in your Salesforce environment
- The FinDock for Fundraising package is installed

The flows are updated to be compatible with Salesforce Winter '27.

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
1. Make sure your user has the required FinDock and Fundraising permissions.
2. Install the package using the appropriate button above.
3. Activate both FinDock flows and complete the configuration below.

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
