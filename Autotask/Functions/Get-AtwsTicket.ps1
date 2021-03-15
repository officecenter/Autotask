#Requires -Version 5.0
<#
    .COPYRIGHT
    Copyright (c) ECIT Solutions AS. All rights reserved. Licensed under the MIT license.
    See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md for license information.
#>
Function Get-AtwsTicket
{


<#
.SYNOPSIS
This function get one or more Ticket through the Autotask Web Services API.
.DESCRIPTION
This function creates a query based on any parameters you give and returns any resulting objects from the Autotask Web Services Api. By default the function returns any objects with properties that are Equal (-eq) to the value of the parameter. To give you more flexibility you can modify the operator by using -NotEquals [ParameterName[]], -LessThan [ParameterName[]] and so on.

Possible operators for all parameters are:
 -NotEquals
 -GreaterThan
 -GreaterThanOrEqual
 -LessThan
 -LessThanOrEquals 

Additional operators for [string] parameters are:
 -Like (supports * or % as wildcards)
 -NotLike
 -BeginsWith
 -EndsWith
 -Contains

Properties with picklists are:
IssueType
Priority
QueueID
Source
Status
SubIssueType
ServiceLevelAgreementID
TicketType
ChangeApprovalBoard
ChangeApprovalType
ChangeApprovalStatus
MonitorTypeID
TicketCategory
CreatorType
LastActivityPersonType
CurrentServiceThermometerRating
PreviousServiceThermometerRating
ApiVendorID
RmaStatus
RmaType

Entities that have fields that refer to the base entity of this CmdLet:


.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.Ticket[]]. This function outputs the Autotask.Ticket that was returned by the API.
.EXAMPLE
Get-AtwsTicket -Id 0
Returns the object with Id 0, if any.
 .EXAMPLE
Get-AtwsTicket -TicketName SomeName
Returns the object with TicketName 'SomeName', if any.
 .EXAMPLE
Get-AtwsTicket -TicketName 'Some Name'
Returns the object with TicketName 'Some Name', if any.
 .EXAMPLE
Get-AtwsTicket -TicketName 'Some Name' -NotEquals TicketName
Returns any objects with a TicketName that is NOT equal to 'Some Name', if any.
 .EXAMPLE
Get-AtwsTicket -TicketName SomeName* -Like TicketName
Returns any object with a TicketName that matches the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsTicket -TicketName SomeName* -NotLike TicketName
Returns any object with a TicketName that DOES NOT match the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsTicket -IssueType <PickList Label>
Returns any Tickets with property IssueType equal to the <PickList Label>. '-PickList' is any parameter on .
 .EXAMPLE
Get-AtwsTicket -IssueType <PickList Label> -NotEquals IssueType 
Returns any Tickets with property IssueType NOT equal to the <PickList Label>.
 .EXAMPLE
Get-AtwsTicket -IssueType <PickList Label1>, <PickList Label2>
Returns any Tickets with property IssueType equal to EITHER <PickList Label1> OR <PickList Label2>.
 .EXAMPLE
Get-AtwsTicket -IssueType <PickList Label1>, <PickList Label2> -NotEquals IssueType
Returns any Tickets with property IssueType NOT equal to NEITHER <PickList Label1> NOR <PickList Label2>.
 .EXAMPLE
Get-AtwsTicket -Id 1234 -TicketName SomeName* -IssueType <PickList Label1>, <PickList Label2> -Like TicketName -NotEquals IssueType -GreaterThan Id
An example of a more complex query. This command returns any Tickets with Id GREATER THAN 1234, a TicketName that matches the simple pattern SomeName* AND that has a IssueType that is NOT equal to NEITHER <PickList Label1> NOR <PickList Label2>.

.LINK
New-AtwsTicket
 .LINK
Set-AtwsTicket

#>

  [CmdLetBinding(SupportsShouldProcess = $true, DefaultParameterSetName='Filter', ConfirmImpact='None')]
  Param
  (
# A filter that limits the number of objects that is returned from the API
    [Parameter(
      Mandatory = $true,
      ValueFromRemainingArguments = $true,
      ParametersetName = 'Filter'
    )]
    [ValidateNotNullOrEmpty()]
    [Collections.Generic.List[string]]
    $Filter,

# Follow this external ID and return any external objects
    [Parameter(
      ParametersetName = 'Filter'
    )]
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Alias('GetRef')]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('AccountID', 'AccountPhysicalLocationID', 'AllocationCodeID', 'AssignedResourceID', 'AssignedResourceRoleID', 'BusinessDivisionSubdivisionID', 'CompletedByResourceID', 'ContactID', 'ContractID', 'ContractServiceBundleID', 'ContractServiceID', 'CreatedByContactID', 'CreatorResourceID', 'ImpersonatorCreatorResourceID', 'InstalledProductID', 'LastActivityResourceID', 'OpportunityId', 'ProblemTicketId', 'ProjectID')]
    [string]
    $GetReferenceEntityById,

# Return all objects in one query
    [Parameter(
      ParametersetName = 'Get_all'
    )]
    [switch]
    $All,

# A single user defined field can be used pr query
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Alias('UDF')]
    [ValidateNotNullOrEmpty()]
    [Autotask.UserDefinedField]
    $UserDefinedField,

# Client
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Collections.Generic.List[Nullable[Int]]]
    $AccountID,

# Account Physical Location
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $AccountPhysicalLocationID,

# AEM Alert ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [Collections.Generic.List[string]]
    $AEMAlertID,

# Allocation Code Name
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $AllocationCodeID,

# API Vendor ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName ApiVendorID -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName ApiVendorID -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $ApiVendorID,

# Resource
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $AssignedResourceID,

# Resource Role Name
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $AssignedResourceRoleID,

# Business Division Subdivision ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $BusinessDivisionSubdivisionID,

# Change Approval Board ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName ChangeApprovalBoard -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName ChangeApprovalBoard -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $ChangeApprovalBoard,

# Change Approval Status
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName ChangeApprovalStatus -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName ChangeApprovalStatus -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $ChangeApprovalStatus,

# Change Approval Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName ChangeApprovalType -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName ChangeApprovalType -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $ChangeApprovalType,

# Change Info Field 1
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [Collections.Generic.List[string]]
    $ChangeInfoField1,

# Change Info Field 2
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [Collections.Generic.List[string]]
    $ChangeInfoField2,

# Change Info Field 3
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [Collections.Generic.List[string]]
    $ChangeInfoField3,

# Change Info Field 4
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [Collections.Generic.List[string]]
    $ChangeInfoField4,

# Change Info Field 5
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [Collections.Generic.List[string]]
    $ChangeInfoField5,

# Ticket Completed By
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $CompletedByResourceID,

# Ticket Date Completed by Complete Project Wizard
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $CompletedDate,

# Ticket Contact
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $ContactID,

# Contract
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $ContractID,

# Contract Service Bundle ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[long]]]
    $ContractServiceBundleID,

# Contract Service ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[long]]]
    $ContractServiceID,

# Ticket Creation Date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $CreateDate,

# Created By Contact ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $CreatedByContactID,

# Ticket Creator
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $CreatorResourceID,

# Current Service Thermometer Rating
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName CurrentServiceThermometerRating -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName CurrentServiceThermometerRating -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $CurrentServiceThermometerRating,

# Ticket Description
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [Collections.Generic.List[string]]
    $Description,

# Ticket End Date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $DueDateTime,

# Ticket Estimated Hours
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[double]]]
    $EstimatedHours,

# Ticket External ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [Collections.Generic.List[string]]
    $ExternalID,

# First Response Assigned Resource
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $FirstResponseAssignedResourceID,

# First Response Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $FirstResponseDateTime,

# First Response Due Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $FirstResponseDueDateTime,

# First Response Initiating Resource
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $FirstResponseInitiatingResourceID,

# Hours to be Scheduled
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[decimal]]]
    $HoursToBeScheduled,

# Ticket ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Collections.Generic.List[Nullable[long]]]
    $id,

# Impersonator Creator Resource ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $ImpersonatorCreatorResourceID,

# Configuration Item
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $InstalledProductID,

# Ticket Issue
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName IssueType -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName IssueType -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $IssueType,

# Ticket Last Activity Date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $LastActivityDate,

# Last Edited Resource ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $LastActivityResourceID,

# Last Customer Notification
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $LastCustomerNotificationDateTime,

# Last Customer Visible Activity
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $LastCustomerVisibleActivityDateTime,

# Last Tracked Modification Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $LastTrackedModificationDateTime,

# Monitor ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $MonitorID,

# Monitor Type ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName MonitorTypeID -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName MonitorTypeID -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $MonitorTypeID,

# Opportunity ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $OpportunityId,

# Previous Service Thermometer Rating
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName PreviousServiceThermometerRating -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName PreviousServiceThermometerRating -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $PreviousServiceThermometerRating,

# Ticket Priority
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName Priority -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName Priority -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $Priority,

# Problem Ticket ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $ProblemTicketId,

# Project ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $ProjectID,

# purchase_order_number
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [Collections.Generic.List[string]]
    $PurchaseOrderNumber,

# Ticket Department Name OR Ticket Queue Name
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName QueueID -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName QueueID -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $QueueID,

# Resolution
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,32000)]
    [Collections.Generic.List[string]]
    $Resolution,

# Resolution Plan Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $ResolutionPlanDateTime,

# Resolution Plan Due Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $ResolutionPlanDueDateTime,

# Resolved Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $ResolvedDateTime,

# Resolved Due Date Time
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[datetime]]]
    $ResolvedDueDateTime,

# RMA Status
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName RmaStatus -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName RmaStatus -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $RmaStatus,

# RMA Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName RmaType -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName RmaType -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $RmaType,

# Has Met SLA
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[boolean]]]
    $ServiceLevelAgreementHasBeenMet,

# Service Level Agreement ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName ServiceLevelAgreementID -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName ServiceLevelAgreementID -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $ServiceLevelAgreementID,

# Service Thermometer Temperature
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Collections.Generic.List[Nullable[Int]]]
    $ServiceThermometerTemperature,

# Ticket Source
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName Source -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName Source -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $Source,

# Ticket Status
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName Status -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName Status -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $Status,

# Ticket Subissue Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter( {
        param($Cmd, $Param, $Word, $Ast, $FakeBound)
        if ($fakeBound.IssueType) {
            $parentvalue = $fakeBound.IssueType
            if (!([int]::TryParse($parentvalue, [ref]$null))) {
                $parentPicklist = Get-AtwsPicklistValue -Entity Ticket -Field IssueType -Label -Hashtable
                $parentValue = $parentPicklist[$parentValue]
            }      
            $picklists = Get-AtwsPicklistValue -Entity Ticket -FieldName SubIssueType
            $picklists[$parentValue]['byLabel'].Keys
        }
        else {
            Get-AtwsPicklistValue -Entity Ticket -FieldName SubIssueType -Label
        }
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName SubIssueType -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $SubIssueType,

# Ticket Category
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName TicketCategory -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName TicketCategory -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $TicketCategory,

# Ticket Number
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [Collections.Generic.List[string]]
    $TicketNumber,

# Ticket Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity Ticket -FieldName TicketType -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity Ticket -FieldName TicketType -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [Collections.Generic.List[string]]
    $TicketType,

# Ticket Title
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(0,255)]
    [Collections.Generic.List[string]]
    $Title,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('ChangeInfoField3', 'CreatedByContactID', 'MonitorID', 'HoursToBeScheduled', 'CurrentServiceThermometerRating', 'RmaType', 'SubIssueType', 'IssueType', 'Description', 'InstalledProductID', 'FirstResponseDueDateTime', 'ServiceLevelAgreementPausedNextEventHours', 'CreatorResourceID', 'ServiceLevelAgreementHasBeenMet', 'BusinessDivisionSubdivisionID', 'ChangeApprovalBoard', 'Resolution', 'MonitorTypeID', 'ProjectID', 'CreatorType', 'ContractID', 'CreateDate', 'LastCustomerNotificationDateTime', 'TicketCategory', 'ImpersonatorCreatorResourceID', 'AssignedResourceID', 'TicketType', 'ResolvedDueDateTime', 'AccountPhysicalLocationID', 'LastCustomerVisibleActivityDateTime', 'PurchaseOrderNumber', 'RmaStatus', 'AllocationCodeID', 'ChangeInfoField5', 'Source', 'ChangeInfoField2', 'ResolutionPlanDateTime', 'DueDateTime', 'LastActivityResourceID', 'QueueID', 'FirstResponseDateTime', 'ContactID', 'AEMAlertID', 'CompletedByResourceID', 'PreviousServiceThermometerRating', 'LastActivityDate', 'ResolutionPlanDueDateTime', 'ServiceThermometerTemperature', 'ProblemTicketId', 'ApiVendorID', 'ChangeInfoField4', 'LastTrackedModificationDateTime', 'id', 'OpportunityId', 'CompletedDate', 'ContractServiceID', 'ChangeApprovalType', 'ExternalID', 'ResolvedDateTime', 'AccountID', 'ChangeInfoField1', 'Title', 'ServiceLevelAgreementID', 'ContractServiceBundleID', 'Priority', 'ChangeApprovalStatus', 'EstimatedHours', 'FirstResponseInitiatingResourceID', 'AssignedResourceRoleID', 'FirstResponseAssignedResourceID', 'TicketNumber', 'LastActivityPersonType', 'Status', '')]
    [Collections.Generic.List[string]]
    $NotEquals,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('ChangeInfoField3', 'CreatedByContactID', 'MonitorID', 'HoursToBeScheduled', 'CurrentServiceThermometerRating', 'RmaType', 'SubIssueType', 'IssueType', 'Description', 'InstalledProductID', 'FirstResponseDueDateTime', 'ServiceLevelAgreementPausedNextEventHours', 'CreatorResourceID', 'ServiceLevelAgreementHasBeenMet', 'BusinessDivisionSubdivisionID', 'ChangeApprovalBoard', 'Resolution', 'MonitorTypeID', 'ProjectID', 'CreatorType', 'ContractID', 'CreateDate', 'LastCustomerNotificationDateTime', 'TicketCategory', 'ImpersonatorCreatorResourceID', 'AssignedResourceID', 'TicketType', 'ResolvedDueDateTime', 'AccountPhysicalLocationID', 'LastCustomerVisibleActivityDateTime', 'PurchaseOrderNumber', 'RmaStatus', 'AllocationCodeID', 'ChangeInfoField5', 'Source', 'ChangeInfoField2', 'ResolutionPlanDateTime', 'DueDateTime', 'LastActivityResourceID', 'QueueID', 'FirstResponseDateTime', 'ContactID', 'AEMAlertID', 'CompletedByResourceID', 'PreviousServiceThermometerRating', 'LastActivityDate', 'ResolutionPlanDueDateTime', 'ServiceThermometerTemperature', 'ProblemTicketId', 'ApiVendorID', 'ChangeInfoField4', 'LastTrackedModificationDateTime', 'id', 'OpportunityId', 'CompletedDate', 'ContractServiceID', 'ChangeApprovalType', 'ExternalID', 'ResolvedDateTime', 'AccountID', 'ChangeInfoField1', 'Title', 'ServiceLevelAgreementID', 'ContractServiceBundleID', 'Priority', 'ChangeApprovalStatus', 'EstimatedHours', 'FirstResponseInitiatingResourceID', 'AssignedResourceRoleID', 'FirstResponseAssignedResourceID', 'TicketNumber', 'LastActivityPersonType', 'Status', '')]
    [Collections.Generic.List[string]]
    $IsNull,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('ChangeInfoField3', 'CreatedByContactID', 'MonitorID', 'HoursToBeScheduled', 'CurrentServiceThermometerRating', 'RmaType', 'SubIssueType', 'IssueType', 'Description', 'InstalledProductID', 'FirstResponseDueDateTime', 'ServiceLevelAgreementPausedNextEventHours', 'CreatorResourceID', 'ServiceLevelAgreementHasBeenMet', 'BusinessDivisionSubdivisionID', 'ChangeApprovalBoard', 'Resolution', 'MonitorTypeID', 'ProjectID', 'CreatorType', 'ContractID', 'CreateDate', 'LastCustomerNotificationDateTime', 'TicketCategory', 'ImpersonatorCreatorResourceID', 'AssignedResourceID', 'TicketType', 'ResolvedDueDateTime', 'AccountPhysicalLocationID', 'LastCustomerVisibleActivityDateTime', 'PurchaseOrderNumber', 'RmaStatus', 'AllocationCodeID', 'ChangeInfoField5', 'Source', 'ChangeInfoField2', 'ResolutionPlanDateTime', 'DueDateTime', 'LastActivityResourceID', 'QueueID', 'FirstResponseDateTime', 'ContactID', 'AEMAlertID', 'CompletedByResourceID', 'PreviousServiceThermometerRating', 'LastActivityDate', 'ResolutionPlanDueDateTime', 'ServiceThermometerTemperature', 'ProblemTicketId', 'ApiVendorID', 'ChangeInfoField4', 'LastTrackedModificationDateTime', 'id', 'OpportunityId', 'CompletedDate', 'ContractServiceID', 'ChangeApprovalType', 'ExternalID', 'ResolvedDateTime', 'AccountID', 'ChangeInfoField1', 'Title', 'ServiceLevelAgreementID', 'ContractServiceBundleID', 'Priority', 'ChangeApprovalStatus', 'EstimatedHours', 'FirstResponseInitiatingResourceID', 'AssignedResourceRoleID', 'FirstResponseAssignedResourceID', 'TicketNumber', 'LastActivityPersonType', 'Status', '')]
    [Collections.Generic.List[string]]
    $IsNotNull,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AccountID', 'AllocationCodeID', 'AssignedResourceID', 'AssignedResourceRoleID', 'CompletedDate', 'ContactID', 'ContractID', 'CreateDate', 'CreatorResourceID', 'Description', 'DueDateTime', 'EstimatedHours', 'ExternalID', 'id', 'InstalledProductID', 'IssueType', 'LastActivityDate', 'Priority', 'QueueID', 'Source', 'Status', 'SubIssueType', 'TicketNumber', 'Title', 'FirstResponseDateTime', 'ResolutionPlanDateTime', 'ResolvedDateTime', 'FirstResponseDueDateTime', 'ResolutionPlanDueDateTime', 'ResolvedDueDateTime', 'ServiceLevelAgreementID', 'Resolution', 'PurchaseOrderNumber', 'TicketType', 'ProblemTicketId', 'OpportunityId', 'ChangeApprovalBoard', 'ChangeApprovalType', 'ChangeApprovalStatus', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'LastCustomerNotificationDateTime', 'LastCustomerVisibleActivityDateTime', 'ContractServiceID', 'ContractServiceBundleID', 'MonitorTypeID', 'MonitorID', 'AEMAlertID', 'HoursToBeScheduled', 'TicketCategory', 'FirstResponseInitiatingResourceID', 'FirstResponseAssignedResourceID', 'ProjectID', 'BusinessDivisionSubdivisionID', 'CreatorType', 'CompletedByResourceID', 'AccountPhysicalLocationID', 'LastActivityPersonType', 'LastActivityResourceID', 'ServiceLevelAgreementPausedNextEventHours', 'CurrentServiceThermometerRating', 'PreviousServiceThermometerRating', 'ServiceThermometerTemperature', 'ApiVendorID', 'LastTrackedModificationDateTime', 'RmaStatus', 'RmaType', 'ImpersonatorCreatorResourceID', 'CreatedByContactID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $GreaterThan,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AccountID', 'AllocationCodeID', 'AssignedResourceID', 'AssignedResourceRoleID', 'CompletedDate', 'ContactID', 'ContractID', 'CreateDate', 'CreatorResourceID', 'Description', 'DueDateTime', 'EstimatedHours', 'ExternalID', 'id', 'InstalledProductID', 'IssueType', 'LastActivityDate', 'Priority', 'QueueID', 'Source', 'Status', 'SubIssueType', 'TicketNumber', 'Title', 'FirstResponseDateTime', 'ResolutionPlanDateTime', 'ResolvedDateTime', 'FirstResponseDueDateTime', 'ResolutionPlanDueDateTime', 'ResolvedDueDateTime', 'ServiceLevelAgreementID', 'Resolution', 'PurchaseOrderNumber', 'TicketType', 'ProblemTicketId', 'OpportunityId', 'ChangeApprovalBoard', 'ChangeApprovalType', 'ChangeApprovalStatus', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'LastCustomerNotificationDateTime', 'LastCustomerVisibleActivityDateTime', 'ContractServiceID', 'ContractServiceBundleID', 'MonitorTypeID', 'MonitorID', 'AEMAlertID', 'HoursToBeScheduled', 'TicketCategory', 'FirstResponseInitiatingResourceID', 'FirstResponseAssignedResourceID', 'ProjectID', 'BusinessDivisionSubdivisionID', 'CreatorType', 'CompletedByResourceID', 'AccountPhysicalLocationID', 'LastActivityPersonType', 'LastActivityResourceID', 'ServiceLevelAgreementPausedNextEventHours', 'CurrentServiceThermometerRating', 'PreviousServiceThermometerRating', 'ServiceThermometerTemperature', 'ApiVendorID', 'LastTrackedModificationDateTime', 'RmaStatus', 'RmaType', 'ImpersonatorCreatorResourceID', 'CreatedByContactID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $GreaterThanOrEquals,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AccountID', 'AllocationCodeID', 'AssignedResourceID', 'AssignedResourceRoleID', 'CompletedDate', 'ContactID', 'ContractID', 'CreateDate', 'CreatorResourceID', 'Description', 'DueDateTime', 'EstimatedHours', 'ExternalID', 'id', 'InstalledProductID', 'IssueType', 'LastActivityDate', 'Priority', 'QueueID', 'Source', 'Status', 'SubIssueType', 'TicketNumber', 'Title', 'FirstResponseDateTime', 'ResolutionPlanDateTime', 'ResolvedDateTime', 'FirstResponseDueDateTime', 'ResolutionPlanDueDateTime', 'ResolvedDueDateTime', 'ServiceLevelAgreementID', 'Resolution', 'PurchaseOrderNumber', 'TicketType', 'ProblemTicketId', 'OpportunityId', 'ChangeApprovalBoard', 'ChangeApprovalType', 'ChangeApprovalStatus', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'LastCustomerNotificationDateTime', 'LastCustomerVisibleActivityDateTime', 'ContractServiceID', 'ContractServiceBundleID', 'MonitorTypeID', 'MonitorID', 'AEMAlertID', 'HoursToBeScheduled', 'TicketCategory', 'FirstResponseInitiatingResourceID', 'FirstResponseAssignedResourceID', 'ProjectID', 'BusinessDivisionSubdivisionID', 'CreatorType', 'CompletedByResourceID', 'AccountPhysicalLocationID', 'LastActivityPersonType', 'LastActivityResourceID', 'ServiceLevelAgreementPausedNextEventHours', 'CurrentServiceThermometerRating', 'PreviousServiceThermometerRating', 'ServiceThermometerTemperature', 'ApiVendorID', 'LastTrackedModificationDateTime', 'RmaStatus', 'RmaType', 'ImpersonatorCreatorResourceID', 'CreatedByContactID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $LessThan,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AccountID', 'AllocationCodeID', 'AssignedResourceID', 'AssignedResourceRoleID', 'CompletedDate', 'ContactID', 'ContractID', 'CreateDate', 'CreatorResourceID', 'Description', 'DueDateTime', 'EstimatedHours', 'ExternalID', 'id', 'InstalledProductID', 'IssueType', 'LastActivityDate', 'Priority', 'QueueID', 'Source', 'Status', 'SubIssueType', 'TicketNumber', 'Title', 'FirstResponseDateTime', 'ResolutionPlanDateTime', 'ResolvedDateTime', 'FirstResponseDueDateTime', 'ResolutionPlanDueDateTime', 'ResolvedDueDateTime', 'ServiceLevelAgreementID', 'Resolution', 'PurchaseOrderNumber', 'TicketType', 'ProblemTicketId', 'OpportunityId', 'ChangeApprovalBoard', 'ChangeApprovalType', 'ChangeApprovalStatus', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'LastCustomerNotificationDateTime', 'LastCustomerVisibleActivityDateTime', 'ContractServiceID', 'ContractServiceBundleID', 'MonitorTypeID', 'MonitorID', 'AEMAlertID', 'HoursToBeScheduled', 'TicketCategory', 'FirstResponseInitiatingResourceID', 'FirstResponseAssignedResourceID', 'ProjectID', 'BusinessDivisionSubdivisionID', 'CreatorType', 'CompletedByResourceID', 'AccountPhysicalLocationID', 'LastActivityPersonType', 'LastActivityResourceID', 'ServiceLevelAgreementPausedNextEventHours', 'CurrentServiceThermometerRating', 'PreviousServiceThermometerRating', 'ServiceThermometerTemperature', 'ApiVendorID', 'LastTrackedModificationDateTime', 'RmaStatus', 'RmaType', 'ImpersonatorCreatorResourceID', 'CreatedByContactID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $LessThanOrEquals,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'ExternalID', 'TicketNumber', 'Title', 'Resolution', 'PurchaseOrderNumber', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'AEMAlertID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $Like,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'ExternalID', 'TicketNumber', 'Title', 'Resolution', 'PurchaseOrderNumber', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'AEMAlertID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $NotLike,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'ExternalID', 'TicketNumber', 'Title', 'Resolution', 'PurchaseOrderNumber', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'AEMAlertID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $BeginsWith,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'ExternalID', 'TicketNumber', 'Title', 'Resolution', 'PurchaseOrderNumber', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'AEMAlertID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $EndsWith,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'ExternalID', 'TicketNumber', 'Title', 'Resolution', 'PurchaseOrderNumber', 'ChangeInfoField1', 'ChangeInfoField2', 'ChangeInfoField3', 'ChangeInfoField4', 'ChangeInfoField5', 'AEMAlertID', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $Contains,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('CompletedDate', 'CreateDate', 'DueDateTime', 'LastActivityDate', 'FirstResponseDateTime', 'ResolutionPlanDateTime', 'ResolvedDateTime', 'FirstResponseDueDateTime', 'ResolutionPlanDueDateTime', 'ResolvedDueDateTime', 'LastCustomerNotificationDateTime', 'LastCustomerVisibleActivityDateTime', 'LastTrackedModificationDateTime', 'UserDefinedField')]
    [Collections.Generic.List[string]]
    $IsThisDay
  )

    begin {
        $entityName = 'Ticket'

        # Enable modern -Debug behavior
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {
            $DebugPreference = 'Continue'
        }
        else {
            # Respect configured preference
            $DebugPreference = $Script:Atws.Configuration.DebugPref
        }

        Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)

        if (!($PSCmdlet.MyInvocation.BoundParameters['Verbose'].IsPresent)) {
            # No local override of central preference. Load central preference
            $VerbosePreference = $Script:Atws.Configuration.VerbosePref
        }

        $result = [collections.generic.list[psobject]]::new()
        $iterations = [collections.generic.list[psobject]]::new()
    }


    process {
        # Parameterset Get_All has a single parameter: -All
        # Set the Filter manually to get every single object of this type
        if ($PSCmdlet.ParameterSetName -eq 'Get_all') {
            $Filter = @('id', '-ge', 0)
            $iterations.Add($Filter)
        }
        # So it is not -All. If Filter does not exist it has to be By_parameters
        elseif (-not ($Filter)) {

            Write-Debug ('{0}: Query based on parameters, parsing' -F $MyInvocation.MyCommand.Name)

           
            # Count the values of the first parameter passed. We will not try do to this on more than 1 parameter, nor on any 
            # other parameter than the first. This is lazy, but efficient.
            $count = $PSBoundParameters.Values[0].count

            # If the count is less than or equal to 200 we pass PSBoundParameters as is
            if ($count -le 200) {
                [collections.generic.list[string]]$Filter = ConvertTo-AtwsFilter -BoundParameters $PSBoundParameters -EntityName $entityName
                $iterations.Add($Filter)
            }
            # More than 200 values. This will cause a SQL query nested too much. Break a single parameter
            # into segments and create multiple queries with max 200 values
            else {
                # Deduplicate the value list or the same ID may be included in more than 1 query
                $outerLoop = $PSBoundParameters.Values[0] | Sort-Object -Unique

                Write-Verbose ('{0}: Received {1} objects containing {2} unique values for parameter {3}' -f $MyInvocation.MyCommand.Name, $count, $outerLoop.Count, $param)

                # Make a writable copy of PSBoundParameters
                $BoundParameters = $PSBoundParameters
                for ($i = 0; $i -lt $outerLoop.count; $i += 200) {
                    $j = $i + 199
                    if ($j -ge $outerLoop.count) {
                        $j = $outerLoop.count - 1
                    }

                    # make a selection
                    $BoundParameters[$param] = $outerLoop[$i .. $j]

                    Write-Verbose ('{0}: Asking for {1} values {2} to {3}' -f $MyInvocation.MyCommand.Name, $param, $i, $j)

                    # Convert named parameters to a filter definition that can be parsed to QueryXML
                    [collections.generic.list[string]]$Filter = ConvertTo-AtwsFilter -BoundParameters $BoundParameters -EntityName $entityName
                    $iterations.Add($Filter)
                }
            }
        }
        # Not parameters, nor Get_all. There are only three parameter sets, so now we know
        # that we were passed a Filter
        else {

            Write-Debug ('{0}: Query based on manual filter, parsing' -F $MyInvocation.MyCommand.Name)

            # Parse the filter string and expand variables in _this_ scope (dot-sourcing)
            # or the variables will not be available and expansion will fail
            $Filter = . Update-AtwsFilter -Filterstring $Filter
            $iterations.Add($Filter)
        }

        # Prepare shouldProcess comments
        $caption = $MyInvocation.MyCommand.Name
        $verboseDescription = '{0}: About to query the Autotask Web API for {1}(s).' -F $caption, $entityName
        $verboseWarning = '{0}: About to query the Autotask Web API for {1}(s). Do you want to continue?' -F $caption, $entityName

        # Lets do it and say we didn't!
        if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) {
            foreach ($Filter in $iterations) {

                try {
                    # Make the query and pass the optional parameters to Get-AtwsData
                    # Force list even if result is only 1 object to be compatible with addrange()
                    [collections.generic.list[psobject]]$response = Get-AtwsData -Entity $entityName -Filter $Filter `
                        -NoPickListLabel:$NoPickListLabel.IsPresent `
                        -GetReferenceEntityById $GetReferenceEntityById
                }
                catch {
                    write-host "ERROR: " -ForegroundColor Red -NoNewline
                    write-host $_.Exception.Message
                    write-host ("{0}: {1}" -f $_.CategoryInfo.Category,$_.CategoryInfo.Reason) -ForegroundColor Cyan
                    $_.ScriptStackTrace -split '\n' | ForEach-Object {
                        Write-host "  |  " -ForegroundColor Cyan -NoNewline
                        Write-host $_
                    }
                }
                # Add response to result
                $result.AddRange($response)

                Write-Verbose ('{0}: Number of entities returned by base query: {1}' -F $MyInvocation.MyCommand.Name, $result.Count)
            }
        }
    }

    end {
        Write-Debug ('{0}: End of function' -F $MyInvocation.MyCommand.Name)
        if ($result) {
            Return [array]$result
        }
    }


}