#
# Module manifest for module 'Autotask'
#
# Generated by: Hugo Klemmestad
#
# Generated on: 16.06.2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Autotask.psm1'

# Version number of this module.
ModuleVersion = '2.0.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'abd8b426-797b-4702-b66d-5f871d0701dc'

# Author of this module
Author = 'Hugo Klemmestad'

# Company or vendor of this module
CompanyName = 'ECIT Solutions AS'

# Copyright statement for this module
Copyright = 'Copyright (c) ECIT Solutions AS. All rights reserved. Licensed under the MIT license.
See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md for license information.'

# Description of the functionality provided by this module
Description = 'This module connects to the Autotask web services API. It downloads information about entities and fields and generates Powershell functions with parameter validation to support Intellisense script editing. To download first all entities and then detailed information about all fields and selection lists is quite time consuming. To speed up module load time and get to coding faster the module caches both script functions and the field info cache to disk.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Build-AtwsModule', 'Connect-AtwsWebAPI', 'Get-AtwsAttachment', 
               'Get-AtwsConnectionObject', 'Get-AtwsFieldInfo', 
               'Get-AtwsInvoiceInfo', 'Get-AtwsModuleConfiguration', 
               'Get-AtwsPicklistValue', 'Get-AtwsThresholdAndUsageInfo', 
               'Get-AtwsWsdlVersion', 'New-AtwsAttachment', 
               'New-AtwsModuleConfiguration', 'Remove-AtwsAttachment', 
               'Remove-AtwsModuleConfiguration', 'Save-AtwsModuleConfiguration', 
               'Set-AtwsModuleConfiguration', 'Uninstall-AtwsOldModuleVersion', 
               'Update-AtwsFunctions', 'Update-AtwsManifest', 'Update-AtwsRamCache', 
               'Get-AtwsAccount', 'Get-AtwsAccountAlert', 'Get-AtwsAccountLocation', 
               'Get-AtwsAccountNote', 'Get-AtwsAccountPhysicalLocation', 
               'Get-AtwsAccountTeam', 'Get-AtwsAccountToDo', 
               'Get-AtwsAccountWebhook', 'Get-AtwsAccountWebhookExcludedResource', 
               'Get-AtwsAccountWebhookField', 'Get-AtwsAccountWebhookUdfField', 
               'Get-AtwsActionType', 'Get-AtwsAdditionalInvoiceFieldValue', 
               'Get-AtwsAllocationCode', 'Get-AtwsAppointment', 
               'Get-AtwsAttachmentInfo', 'Get-AtwsBillingItem', 
               'Get-AtwsBillingItemApprovalLevel', 'Get-AtwsBusinessDivision', 
               'Get-AtwsBusinessDivisionSubdivision', 
               'Get-AtwsBusinessDivisionSubdivisionResource', 
               'Get-AtwsBusinessLocation', 'Get-AtwsBusinessSubdivision', 
               'Get-AtwsChangeOrderCost', 'Get-AtwsChangeRequestLink', 
               'Get-AtwsChecklistLibrary', 'Get-AtwsChecklistLibraryChecklistItem', 
               'Get-AtwsClassificationIcon', 'Get-AtwsClientPortalUser', 
               'Get-AtwsComanagedAssociation', 'Get-AtwsContact', 
               'Get-AtwsContactBillingProductAssociation', 'Get-AtwsContactGroup', 
               'Get-AtwsContactGroupContact', 'Get-AtwsContactWebhook', 
               'Get-AtwsContactWebhookExcludedResource', 
               'Get-AtwsContactWebhookField', 'Get-AtwsContactWebhookUdfField', 
               'Get-AtwsContract', 'Get-AtwsContractBillingRule', 
               'Get-AtwsContractBlock', 'Get-AtwsContractCost', 
               'Get-AtwsContractExclusionAllocationCode', 
               'Get-AtwsContractExclusionRole', 'Get-AtwsContractExclusionSet', 
               'Get-AtwsContractExclusionSetExcludedRole', 
               'Get-AtwsContractExclusionSetExcludedWorkType', 
               'Get-AtwsContractFactor', 'Get-AtwsContractMilestone', 
               'Get-AtwsContractNote', 'Get-AtwsContractRate', 
               'Get-AtwsContractRetainer', 'Get-AtwsContractRoleCost', 
               'Get-AtwsContractService', 'Get-AtwsContractServiceBundle', 
               'Get-AtwsContractServiceBundleUnit', 'Get-AtwsContractServiceUnit', 
               'Get-AtwsContractTicketPurchase', 'Get-AtwsCountry', 
               'Get-AtwsCurrency', 'Get-AtwsDeletedTaskActivityLog', 
               'Get-AtwsDeletedTicketActivityLog', 'Get-AtwsDeletedTicketLog', 
               'Get-AtwsDepartment', 'Get-AtwsExpenseItem', 'Get-AtwsExpenseReport', 
               'Get-AtwsHoliday', 'Get-AtwsHolidaySet', 'Get-AtwsInstalledProduct', 
               'Get-AtwsInstalledProductBillingProductAssociation', 
               'Get-AtwsInstalledProductCategory', 
               'Get-AtwsInstalledProductCategoryUdfAssociation', 
               'Get-AtwsInstalledProductNote', 'Get-AtwsInstalledProductType', 
               'Get-AtwsInstalledProductTypeUdfAssociation', 
               'Get-AtwsInstalledProductWebhook', 
               'Get-AtwsInstalledProductWebhookExcludedResource', 
               'Get-AtwsInstalledProductWebhookField', 
               'Get-AtwsInstalledProductWebhookUdfField', 
               'Get-AtwsIntegrationVendorWidget', 'Get-AtwsInternalLocation', 
               'Get-AtwsInventoryItem', 'Get-AtwsInventoryItemSerialNumber', 
               'Get-AtwsInventoryLocation', 'Get-AtwsInventoryTransfer', 
               'Get-AtwsInvoice', 'Get-AtwsInvoiceTemplate', 
               'Get-AtwsNotificationHistory', 'Get-AtwsOpportunity', 
               'Get-AtwsPaymentTerm', 'Get-AtwsPhase', 
               'Get-AtwsPriceListMaterialCode', 'Get-AtwsPriceListProduct', 
               'Get-AtwsPriceListProductTier', 'Get-AtwsPriceListRole', 
               'Get-AtwsPriceListService', 'Get-AtwsPriceListServiceBundle', 
               'Get-AtwsPriceListWorkTypeModifier', 'Get-AtwsProduct', 
               'Get-AtwsProductNote', 'Get-AtwsProductTier', 'Get-AtwsProductVendor', 
               'Get-AtwsProject', 'Get-AtwsProjectCost', 'Get-AtwsProjectNote', 
               'Get-AtwsPurchaseApproval', 'Get-AtwsPurchaseOrder', 
               'Get-AtwsPurchaseOrderItem', 'Get-AtwsPurchaseOrderReceive', 
               'Get-AtwsQuote', 'Get-AtwsQuoteItem', 'Get-AtwsQuoteLocation', 
               'Get-AtwsQuoteTemplate', 'Get-AtwsResource', 'Get-AtwsResourceRole', 
               'Get-AtwsResourceRoleDepartment', 'Get-AtwsResourceRoleQueue', 
               'Get-AtwsResourceServiceDeskRole', 'Get-AtwsResourceSkill', 
               'Get-AtwsRole', 'Get-AtwsSalesOrder', 'Get-AtwsService', 
               'Get-AtwsServiceBundle', 'Get-AtwsServiceBundleService', 
               'Get-AtwsServiceCall', 'Get-AtwsServiceCallTask', 
               'Get-AtwsServiceCallTaskResource', 'Get-AtwsServiceCallTicket', 
               'Get-AtwsServiceCallTicketResource', 
               'Get-AtwsServiceLevelAgreementResults', 'Get-AtwsShippingType', 
               'Get-AtwsSkill', 'Get-AtwsSubscription', 'Get-AtwsSubscriptionPeriod', 
               'Get-AtwsSurvey', 'Get-AtwsSurveyResults', 'Get-AtwsTag', 
               'Get-AtwsTagAlias', 'Get-AtwsTagGroup', 'Get-AtwsTask', 
               'Get-AtwsTaskNote', 'Get-AtwsTaskPredecessor', 
               'Get-AtwsTaskSecondaryResource', 'Get-AtwsTax', 'Get-AtwsTaxCategory', 
               'Get-AtwsTaxRegion', 'Get-AtwsTicket', 
               'Get-AtwsTicketAdditionalContact', 
               'Get-AtwsTicketAdditionalInstalledProduct', 
               'Get-AtwsTicketCategory', 'Get-AtwsTicketCategoryFieldDefaults', 
               'Get-AtwsTicketChangeRequestApproval', 
               'Get-AtwsTicketChecklistItem', 'Get-AtwsTicketCost', 
               'Get-AtwsTicketHistory', 'Get-AtwsTicketNote', 
               'Get-AtwsTicketRmaCredit', 'Get-AtwsTicketSecondaryResource', 
               'Get-AtwsTicketTagAssociation', 'Get-AtwsTimeEntry', 
               'Get-AtwsUserDefinedFieldDefinition', 
               'Get-AtwsUserDefinedFieldListItem', 'Get-AtwsWebhookEventErrorLog', 
               'Get-AtwsWorkTypeModifier', 'New-AtwsAccount', 'New-AtwsAccountAlert', 
               'New-AtwsAccountNote', 'New-AtwsAccountPhysicalLocation', 
               'New-AtwsAccountTeam', 'New-AtwsAccountToDo', 
               'New-AtwsAccountWebhook', 'New-AtwsAccountWebhookExcludedResource', 
               'New-AtwsAccountWebhookField', 'New-AtwsAccountWebhookUdfField', 
               'New-AtwsActionType', 'New-AtwsAppointment', 
               'New-AtwsBillingItemApprovalLevel', 'New-AtwsBusinessDivision', 
               'New-AtwsBusinessDivisionSubdivision', 'New-AtwsBusinessLocation', 
               'New-AtwsBusinessSubdivision', 'New-AtwsChangeOrderCost', 
               'New-AtwsChangeRequestLink', 'New-AtwsChecklistLibrary', 
               'New-AtwsChecklistLibraryChecklistItem', 'New-AtwsClientPortalUser', 
               'New-AtwsComanagedAssociation', 'New-AtwsContact', 
               'New-AtwsContactBillingProductAssociation', 'New-AtwsContactGroup', 
               'New-AtwsContactGroupContact', 'New-AtwsContactWebhook', 
               'New-AtwsContactWebhookExcludedResource', 
               'New-AtwsContactWebhookField', 'New-AtwsContactWebhookUdfField', 
               'New-AtwsContract', 'New-AtwsContractBillingRule', 
               'New-AtwsContractBlock', 'New-AtwsContractCost', 
               'New-AtwsContractExclusionAllocationCode', 
               'New-AtwsContractExclusionRole', 'New-AtwsContractExclusionSet', 
               'New-AtwsContractExclusionSetExcludedRole', 
               'New-AtwsContractExclusionSetExcludedWorkType', 
               'New-AtwsContractFactor', 'New-AtwsContractMilestone', 
               'New-AtwsContractNote', 'New-AtwsContractRate', 
               'New-AtwsContractRetainer', 'New-AtwsContractRoleCost', 
               'New-AtwsContractService', 'New-AtwsContractServiceAdjustment', 
               'New-AtwsContractServiceBundle', 
               'New-AtwsContractServiceBundleAdjustment', 
               'New-AtwsContractTicketPurchase', 'New-AtwsDepartment', 
               'New-AtwsExpenseItem', 'New-AtwsExpenseReport', 'New-AtwsHoliday', 
               'New-AtwsHolidaySet', 'New-AtwsInstalledProduct', 
               'New-AtwsInstalledProductBillingProductAssociation', 
               'New-AtwsInstalledProductCategory', 
               'New-AtwsInstalledProductCategoryUdfAssociation', 
               'New-AtwsInstalledProductNote', 'New-AtwsInstalledProductType', 
               'New-AtwsInstalledProductTypeUdfAssociation', 
               'New-AtwsInstalledProductWebhook', 
               'New-AtwsInstalledProductWebhookExcludedResource', 
               'New-AtwsInstalledProductWebhookField', 
               'New-AtwsInstalledProductWebhookUdfField', 
               'New-AtwsIntegrationVendorWidget', 'New-AtwsInventoryItem', 
               'New-AtwsInventoryItemSerialNumber', 'New-AtwsInventoryLocation', 
               'New-AtwsInventoryTransfer', 'New-AtwsOpportunity', 
               'New-AtwsPaymentTerm', 'New-AtwsPhase', 'New-AtwsProduct', 
               'New-AtwsProductNote', 'New-AtwsProductTier', 'New-AtwsProductVendor', 
               'New-AtwsProject', 'New-AtwsProjectCost', 'New-AtwsProjectNote', 
               'New-AtwsPurchaseOrder', 'New-AtwsPurchaseOrderItem', 
               'New-AtwsPurchaseOrderReceive', 'New-AtwsQuote', 'New-AtwsQuoteItem', 
               'New-AtwsQuoteLocation', 'New-AtwsResourceRoleDepartment', 
               'New-AtwsResourceRoleQueue', 'New-AtwsResourceServiceDeskRole', 
               'New-AtwsRole', 'New-AtwsService', 'New-AtwsServiceBundle', 
               'New-AtwsServiceBundleService', 'New-AtwsServiceCall', 
               'New-AtwsServiceCallTask', 'New-AtwsServiceCallTaskResource', 
               'New-AtwsServiceCallTicket', 'New-AtwsServiceCallTicketResource', 
               'New-AtwsSubscription', 'New-AtwsTag', 'New-AtwsTagAlias', 
               'New-AtwsTagGroup', 'New-AtwsTask', 'New-AtwsTaskNote', 
               'New-AtwsTaskPredecessor', 'New-AtwsTaskSecondaryResource', 
               'New-AtwsTax', 'New-AtwsTaxCategory', 'New-AtwsTaxRegion', 
               'New-AtwsTicket', 'New-AtwsTicketAdditionalContact', 
               'New-AtwsTicketAdditionalInstalledProduct', 
               'New-AtwsTicketChangeRequestApproval', 
               'New-AtwsTicketChecklistItem', 'New-AtwsTicketChecklistLibrary', 
               'New-AtwsTicketCost', 'New-AtwsTicketNote', 'New-AtwsTicketRmaCredit', 
               'New-AtwsTicketSecondaryResource', 'New-AtwsTicketTagAssociation', 
               'New-AtwsTimeEntry', 'New-AtwsUserDefinedFieldDefinition', 
               'New-AtwsUserDefinedFieldListItem', 
               'Remove-AtwsAccountPhysicalLocation', 'Remove-AtwsAccountTeam', 
               'Remove-AtwsAccountToDo', 'Remove-AtwsAccountWebhook', 
               'Remove-AtwsAccountWebhookExcludedResource', 
               'Remove-AtwsAccountWebhookField', 
               'Remove-AtwsAccountWebhookUdfField', 'Remove-AtwsActionType', 
               'Remove-AtwsAppointment', 'Remove-AtwsChangeOrderCost', 
               'Remove-AtwsChangeRequestLink', 'Remove-AtwsChecklistLibrary', 
               'Remove-AtwsChecklistLibraryChecklistItem', 
               'Remove-AtwsComanagedAssociation', 'Remove-AtwsContact', 
               'Remove-AtwsContactBillingProductAssociation', 
               'Remove-AtwsContactGroup', 'Remove-AtwsContactGroupContact', 
               'Remove-AtwsContactWebhook', 
               'Remove-AtwsContactWebhookExcludedResource', 
               'Remove-AtwsContactWebhookField', 
               'Remove-AtwsContactWebhookUdfField', 
               'Remove-AtwsContractBillingRule', 'Remove-AtwsContractCost', 
               'Remove-AtwsContractExclusionAllocationCode', 
               'Remove-AtwsContractExclusionRole', 
               'Remove-AtwsContractExclusionSet', 
               'Remove-AtwsContractExclusionSetExcludedRole', 
               'Remove-AtwsContractExclusionSetExcludedWorkType', 
               'Remove-AtwsHoliday', 'Remove-AtwsHolidaySet', 
               'Remove-AtwsInstalledProductBillingProductAssociation', 
               'Remove-AtwsInstalledProductCategoryUdfAssociation', 
               'Remove-AtwsInstalledProductType', 
               'Remove-AtwsInstalledProductTypeUdfAssociation', 
               'Remove-AtwsInstalledProductWebhook', 
               'Remove-AtwsInstalledProductWebhookExcludedResource', 
               'Remove-AtwsInstalledProductWebhookField', 
               'Remove-AtwsInstalledProductWebhookUdfField', 
               'Remove-AtwsIntegrationVendorWidget', 'Remove-AtwsProductTier', 
               'Remove-AtwsProjectCost', 'Remove-AtwsQuoteItem', 
               'Remove-AtwsServiceBundle', 'Remove-AtwsServiceBundleService', 
               'Remove-AtwsServiceCall', 'Remove-AtwsServiceCallTask', 
               'Remove-AtwsServiceCallTaskResource', 
               'Remove-AtwsServiceCallTicket', 
               'Remove-AtwsServiceCallTicketResource', 'Remove-AtwsSubscription', 
               'Remove-AtwsTag', 'Remove-AtwsTagAlias', 'Remove-AtwsTagGroup', 
               'Remove-AtwsTaskPredecessor', 'Remove-AtwsTaskSecondaryResource', 
               'Remove-AtwsTicketAdditionalContact', 
               'Remove-AtwsTicketAdditionalInstalledProduct', 
               'Remove-AtwsTicketChangeRequestApproval', 
               'Remove-AtwsTicketChecklistItem', 'Remove-AtwsTicketCost', 
               'Remove-AtwsTicketRmaCredit', 'Remove-AtwsTicketSecondaryResource', 
               'Remove-AtwsTicketTagAssociation', 'Remove-AtwsTimeEntry', 
               'Remove-AtwsWebhookEventErrorLog', 'Set-AtwsAccount', 
               'Set-AtwsAccountAlert', 'Set-AtwsAccountLocation', 
               'Set-AtwsAccountNote', 'Set-AtwsAccountPhysicalLocation', 
               'Set-AtwsAccountToDo', 'Set-AtwsAccountWebhook', 
               'Set-AtwsAccountWebhookField', 'Set-AtwsAccountWebhookUdfField', 
               'Set-AtwsActionType', 'Set-AtwsAppointment', 'Set-AtwsBillingItem', 
               'Set-AtwsBusinessDivision', 'Set-AtwsBusinessDivisionSubdivision', 
               'Set-AtwsBusinessLocation', 'Set-AtwsBusinessSubdivision', 
               'Set-AtwsChangeOrderCost', 'Set-AtwsChecklistLibrary', 
               'Set-AtwsChecklistLibraryChecklistItem', 'Set-AtwsClientPortalUser', 
               'Set-AtwsContact', 'Set-AtwsContactBillingProductAssociation', 
               'Set-AtwsContactGroup', 'Set-AtwsContactWebhook', 
               'Set-AtwsContactWebhookField', 'Set-AtwsContactWebhookUdfField', 
               'Set-AtwsContract', 'Set-AtwsContractBillingRule', 
               'Set-AtwsContractBlock', 'Set-AtwsContractCost', 
               'Set-AtwsContractExclusionSet', 'Set-AtwsContractFactor', 
               'Set-AtwsContractMilestone', 'Set-AtwsContractNote', 
               'Set-AtwsContractRate', 'Set-AtwsContractRetainer', 
               'Set-AtwsContractRoleCost', 'Set-AtwsContractService', 
               'Set-AtwsContractServiceBundle', 'Set-AtwsContractTicketPurchase', 
               'Set-AtwsCountry', 'Set-AtwsCurrency', 'Set-AtwsDepartment', 
               'Set-AtwsExpenseItem', 'Set-AtwsExpenseReport', 'Set-AtwsHoliday', 
               'Set-AtwsHolidaySet', 'Set-AtwsInstalledProduct', 
               'Set-AtwsInstalledProductBillingProductAssociation', 
               'Set-AtwsInstalledProductCategory', 
               'Set-AtwsInstalledProductCategoryUdfAssociation', 
               'Set-AtwsInstalledProductNote', 'Set-AtwsInstalledProductType', 
               'Set-AtwsInstalledProductTypeUdfAssociation', 
               'Set-AtwsInstalledProductWebhook', 
               'Set-AtwsInstalledProductWebhookField', 
               'Set-AtwsInstalledProductWebhookUdfField', 
               'Set-AtwsIntegrationVendorWidget', 'Set-AtwsInventoryItem', 
               'Set-AtwsInventoryItemSerialNumber', 'Set-AtwsInventoryLocation', 
               'Set-AtwsInvoice', 'Set-AtwsOpportunity', 'Set-AtwsPaymentTerm', 
               'Set-AtwsPhase', 'Set-AtwsPriceListMaterialCode', 
               'Set-AtwsPriceListProduct', 'Set-AtwsPriceListProductTier', 
               'Set-AtwsPriceListRole', 'Set-AtwsPriceListService', 
               'Set-AtwsPriceListServiceBundle', 
               'Set-AtwsPriceListWorkTypeModifier', 'Set-AtwsProduct', 
               'Set-AtwsProductNote', 'Set-AtwsProductTier', 'Set-AtwsProductVendor', 
               'Set-AtwsProject', 'Set-AtwsProjectCost', 'Set-AtwsProjectNote', 
               'Set-AtwsPurchaseApproval', 'Set-AtwsPurchaseOrder', 
               'Set-AtwsPurchaseOrderItem', 'Set-AtwsQuote', 'Set-AtwsQuoteItem', 
               'Set-AtwsQuoteLocation', 'Set-AtwsResource', 
               'Set-AtwsResourceRoleDepartment', 'Set-AtwsResourceRoleQueue', 
               'Set-AtwsResourceServiceDeskRole', 'Set-AtwsResourceSkill', 
               'Set-AtwsRole', 'Set-AtwsSalesOrder', 'Set-AtwsService', 
               'Set-AtwsServiceBundle', 'Set-AtwsServiceCall', 
               'Set-AtwsSubscription', 'Set-AtwsTag', 'Set-AtwsTagGroup', 
               'Set-AtwsTask', 'Set-AtwsTaskNote', 'Set-AtwsTaskPredecessor', 
               'Set-AtwsTax', 'Set-AtwsTaxCategory', 'Set-AtwsTaxRegion', 
               'Set-AtwsTicket', 'Set-AtwsTicketCategory', 
               'Set-AtwsTicketChecklistItem', 'Set-AtwsTicketCost', 
               'Set-AtwsTicketNote', 'Set-AtwsTicketRmaCredit', 'Set-AtwsTimeEntry', 
               'Set-AtwsUserDefinedFieldDefinition', 
               'Set-AtwsUserDefinedFieldListItem', 'Set-AtwsWorkTypeModifier'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Autotask', 'Function', 'SOAP'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/ecitsolutions/Autotask'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/ecitsolutions/Autotask/blob/master/README.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://aka.ms/ps-modules-help'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

