#Requires -Version 5.0
<#
    .COPYRIGHT
    Copyright (c) ECIT Solutions AS. All rights reserved. Licensed under the MIT license.
    See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md for license information.
#>
Function Get-AtwsTicketCost
{


<#
.SYNOPSIS
This function get one or more TicketCost through the Autotask Web Services API.
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
CostType
Status

Entities that have fields that refer to the base entity of this CmdLet:


.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.TicketCost[]]. This function outputs the Autotask.TicketCost that was returned by the API.
.EXAMPLE
Get-AtwsTicketCost -Id 0
Returns the object with Id 0, if any.
 .EXAMPLE
Get-AtwsTicketCost -TicketCostName SomeName
Returns the object with TicketCostName 'SomeName', if any.
 .EXAMPLE
Get-AtwsTicketCost -TicketCostName 'Some Name'
Returns the object with TicketCostName 'Some Name', if any.
 .EXAMPLE
Get-AtwsTicketCost -TicketCostName 'Some Name' -NotEquals TicketCostName
Returns any objects with a TicketCostName that is NOT equal to 'Some Name', if any.
 .EXAMPLE
Get-AtwsTicketCost -TicketCostName SomeName* -Like TicketCostName
Returns any object with a TicketCostName that matches the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsTicketCost -TicketCostName SomeName* -NotLike TicketCostName
Returns any object with a TicketCostName that DOES NOT match the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsTicketCost -CostType <PickList Label>
Returns any TicketCosts with property CostType equal to the <PickList Label>. '-PickList' is any parameter on .
 .EXAMPLE
Get-AtwsTicketCost -CostType <PickList Label> -NotEquals CostType 
Returns any TicketCosts with property CostType NOT equal to the <PickList Label>.
 .EXAMPLE
Get-AtwsTicketCost -CostType <PickList Label1>, <PickList Label2>
Returns any TicketCosts with property CostType equal to EITHER <PickList Label1> OR <PickList Label2>.
 .EXAMPLE
Get-AtwsTicketCost -CostType <PickList Label1>, <PickList Label2> -NotEquals CostType
Returns any TicketCosts with property CostType NOT equal to NEITHER <PickList Label1> NOR <PickList Label2>.
 .EXAMPLE
Get-AtwsTicketCost -Id 1234 -TicketCostName SomeName* -CostType <PickList Label1>, <PickList Label2> -Like TicketCostName -NotEquals CostType -GreaterThan Id
An example of a more complex query. This command returns any TicketCosts with Id GREATER THAN 1234, a TicketCostName that matches the simple pattern SomeName* AND that has a CostType that is NOT equal to NEITHER <PickList Label1> NOR <PickList Label2>.

.LINK
New-AtwsTicketCost
 .LINK
Remove-AtwsTicketCost
 .LINK
Set-AtwsTicketCost

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
    [string[]]
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
    [ValidateSet('AllocationCodeID', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CreatorResourceID', 'ProductID', 'TicketID')]
    [string]
    $GetReferenceEntityById,

# Return all objects in one query
    [Parameter(
      ParametersetName = 'Get_all'
    )]
    [switch]
    $All,

# Allocation Code
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[long][]]
    $AllocationCodeID,

# Billable Amount
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[double][]]
    $BillableAmount,

# Billable To Client
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[boolean][]]
    $BillableToAccount,

# Billed
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[boolean][]]
    $Billed,

# Business Division Subdivision ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[Int][]]
    $BusinessDivisionSubdivisionID,

# Contract Service Bundle ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[long][]]
    $ContractServiceBundleID,

# Contract Service ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[long][]]
    $ContractServiceID,

# Cost Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity TicketCost -FieldName CostType -Label
    })]
    [ValidateScript({
      $set = (Get-AtwsPicklistValue -Entity TicketCost -FieldName CostType -Label) + (Get-AtwsPicklistValue -Entity TicketCost -FieldName CostType -Value)
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [string[]]
    $CostType,

# Create Date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[datetime][]]
    $CreateDate,

# Created By
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[long][]]
    $CreatorResourceID,

# Date Purchased
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[datetime][]]
    $DatePurchased,

# Description
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,8000)]
    [string[]]
    $Description,

# Extended Cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[double][]]
    $ExtendedCost,

# id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[long][]]
    $id,

# Internal Currency Billable Amount
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[double][]]
    $InternalCurrencyBillableAmount,

# Internal Currency Unit Price
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[double][]]
    $InternalCurrencyUnitPrice,

# Internal Purchase Order Number
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string[]]
    $InternalPurchaseOrderNumber,

# Name
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(0,100)]
    [string[]]
    $Name,

# Notes
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,2000)]
    [string[]]
    $Notes,

# Product
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[long][]]
    $ProductID,

# Purchase Order Number
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string[]]
    $PurchaseOrderNumber,

# Status
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity TicketCost -FieldName Status -Label
    })]
    [ValidateScript({
      $set = (Get-AtwsPicklistValue -Entity TicketCost -FieldName Status -Label) + (Get-AtwsPicklistValue -Entity TicketCost -FieldName Status -Value)
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [string[]]
    $Status,

# Last Modified By
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[long][]]
    $StatusLastModifiedBy,

# Last Modified Date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[datetime][]]
    $StatusLastModifiedDate,

# Ticket
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[long][]]
    $TicketID,

# Unit Cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[double][]]
    $UnitCost,

# Unit Price
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Nullable[double][]]
    $UnitPrice,

# Unit Quantity
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[double][]]
    $UnitQuantity,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BillableToAccount', 'Billed', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $NotEquals,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BillableToAccount', 'Billed', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $IsNull,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BillableToAccount', 'Billed', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $IsNotNull,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $GreaterThan,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $GreaterThanOrEquals,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $LessThan,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('AllocationCodeID', 'BillableAmount', 'BusinessDivisionSubdivisionID', 'ContractServiceBundleID', 'ContractServiceID', 'CostType', 'CreateDate', 'CreatorResourceID', 'DatePurchased', 'Description', 'ExtendedCost', 'id', 'InternalCurrencyBillableAmount', 'InternalCurrencyUnitPrice', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'ProductID', 'PurchaseOrderNumber', 'Status', 'StatusLastModifiedBy', 'StatusLastModifiedDate', 'TicketID', 'UnitCost', 'UnitPrice', 'UnitQuantity')]
    [string[]]
    $LessThanOrEquals,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'PurchaseOrderNumber')]
    [string[]]
    $Like,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'PurchaseOrderNumber')]
    [string[]]
    $NotLike,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'PurchaseOrderNumber')]
    [string[]]
    $BeginsWith,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'PurchaseOrderNumber')]
    [string[]]
    $EndsWith,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('Description', 'InternalPurchaseOrderNumber', 'Name', 'Notes', 'PurchaseOrderNumber')]
    [string[]]
    $Contains,

    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateSet('CreateDate', 'DatePurchased', 'StatusLastModifiedDate')]
    [string[]]
    $IsThisDay
  )

    begin {
        $entityName = 'TicketCost'

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

            # What is the highest number of values for a parameter and is it higher than 200?
            $max = $PSBoundParameters.Values[0].length | Measure-Object -Maximum

            # If the count is less than or equal to 200 we pass PSBoundParameters as is
            if ($max.Maximum -le 200) {
                [collections.generic.list[string]]$Filter = ConvertTo-AtwsFilter -BoundParameters $PSBoundParameters -EntityName $entityName
                $iterations.Add($Filter)
            }
            # More than 200 values. This will cause a SQL query nested too much error. Break a single parameter
            # into segments and create multiple queries with max 200 values
            else {
                
                # Find the parameter with the $max.Maximum number of items
                foreach ($param in $PSCmdlet.MyInvocation.BoundParameters.GetEnumerator() ) {
                    # When we have found the right parameter, stop iterating
                    if ($param.Value.length -eq $max.Maximum) { break }
                }
     
                # Deduplicate the value list or the same ID may be included in more than 1 query
                $outerLoop = $PSCmdlet.MyInvocation.BoundParameters.$($param.key) | Sort-Object -Unique

                Write-Verbose ('{0}: Received {1} objects containing {2} unique values for parameter {3}' -f $MyInvocation.MyCommand.Name, $count, $outerLoop.Count, $param.key)
                  
                for ($s = 0; $s -lt $outerLoop.count; $s += 200) {
                    $e = $s + 199
                    if ($e -ge $outerLoop.count) {
                        $e = $outerLoop.count - 1
                    }
                  
                    # Make writable of BoundParameters
                    $BoundParameters = $PSCmdlet.MyInvocation.BoundParameters

                    # make a selection
                    $BoundParameters.$($param.key) = $outerLoop[$s .. $e]

                    Write-Verbose ('{0}: Asking for {1} values {2} to {3}' -f $MyInvocation.MyCommand.Name, $param, $s, $e)

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
                    $reason = ("{0}: {1}" -f $_.CategoryInfo.Category, $_.CategoryInfo.Reason)
                    $message = "Autotask API Responded with error:`r`n`r`n{0}`r`n`r`n{1} {2}" -f $_.Exception.Message, $reason, $_.ScriptStackTrace
                    throw [System.Configuration.Provider.ProviderException]::new($message)
                }
                # Add response to result - if there are any response to add
                if ($response.count -gt 0) { 
                    $result.AddRange($response)
                }

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
