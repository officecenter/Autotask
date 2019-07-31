﻿#Requires -Version 4.0
#Version 1.6.2.17
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function New-AtwsProduct
{


<#
.SYNOPSIS
This function creates a new Product through the Autotask Web Services API. All required properties are marked as required parameters to assist you on the command line.
.DESCRIPTION
The function supports all properties of an [Autotask.Product] that can be updated through the Web Services API. The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values. Any required paramterer is marked as Mandatory in the PowerShell function to assist you on the command line.

If you need very complicated queries you can write a filter directly and pass it using the -Filter parameter. To get the Product with Id number 0 you could write 'New-AtwsProduct -Id 0' or you could write 'New-AtwsProduct -Filter {Id -eq 0}.

'New-AtwsProduct -Id 0,4' could be written as 'New-AtwsProduct -Filter {id -eq 0 -or id -eq 4}'. For simple queries you can see that using parameters is much easier than the -Filter option. But the -Filter option supports an arbitrary sequence of most operators (-eq, -ne, -gt, -ge, -lt, -le, -and, -or, -beginswith, -endswith, -contains, -like, -notlike, -soundslike, -isnotnull, -isnull, -isthisday). As you can group them using parenthesis '()' you can write arbitrarily complex queries with -Filter. 

To create a new Product you need the following required fields:
 -Name
 -Active
 -ProductAllocationCodeID
 -Serialized

Entities that have fields that refer to the base entity of this CmdLet:

ContactBillingProductAssociation
 ContractBillingRule
 ContractCost
 InstalledProduct
 InstalledProductBillingProductAssociation
 InventoryItem
 InventoryTransfer
 Opportunity
 PriceListProduct
 ProductTier
 ProductVendor
 ProjectCost
 PurchaseOrderItem
 QuoteItem
 TicketCost

.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.Product]. This function outputs the Autotask.Product that was created by the API.
.EXAMPLE
$result = New-AtwsProduct -Name [Value] -Active [Value] -ProductAllocationCodeID [Value] -Serialized [Value]
Creates a new [Autotask.Product] through the Web Services API and returns the new object.
 .EXAMPLE
$result = Get-AtwsProduct -Id 124 | New-AtwsProduct 
Copies [Autotask.Product] by Id 124 to a new object through the Web Services API and returns the new object.
 .EXAMPLE
Get-AtwsProduct -Id 124 | New-AtwsProduct | Set-AtwsProduct -ParameterName <Parameter Value>
Copies [Autotask.Product] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsProduct to modify the object.
 .EXAMPLE
$result = Get-AtwsProduct -Id 124 | New-AtwsProduct | Set-AtwsProduct -ParameterName <Parameter Value> -Passthru
Copies [Autotask.Product] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsProduct to modify the object and returns the new object.

.LINK
Get-AtwsProduct
 .LINK
Set-AtwsProduct

#>

  [CmdLetBinding(SupportsShouldProcess = $true, DefaultParameterSetName='By_parameters', ConfirmImpact='Low')]
  Param
  (
# An array of objects to create
    [Parameter(
      ParametersetName = 'Input_Object',
      ValueFromPipeline = $true
    )]
    [ValidateNotNullOrEmpty()]
    [Autotask.Product[]]
    $InputObject,

# Product Name
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(0,100)]
    [string]
    $Name,

# Product Description
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,2000)]
    [string]
    $Description,

# Product SKU
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string]
    $SKU,

# Product Link
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,500)]
    [string]
    $Link,

# Product Category
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [string]
    $ProductCategory,

# External ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string]
    $ExternalProductID,

# Unit Cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitCost,

# Unit Price
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitPrice,

# MSRP
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $MSRP,

# Vendor Account ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $DefaultVendorID,

# Vendor Product Number
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string]
    $VendorProductNumber,

# Manufacturer Account Name
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,100)]
    [string]
    $ManufacturerName,

# Manufacturer Product Number
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string]
    $ManufacturerProductName,

# Active
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [boolean]
    $Active,

# Period Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [string]
    $PeriodType,

# Allocation Code ID
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $ProductAllocationCodeID,

# Is Serialized
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [boolean]
    $Serialized,

# Cost Allocation Code ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $CostAllocationCodeID,

# Does Not Require Procurement
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [boolean]
    $DoesNotRequireProcurement,

# markup_rate
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $MarkupRate,

# Internal Product ID
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,50)]
    [string]
    $InternalProductID,

# Billing Type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [string]
    $BillingType,

# Price Cost Method
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [string]
    $PriceCostMethod
  )
 
    begin { 
        $entityName = 'Product'
           
        # Enable modern -Debug behavior
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) { $DebugPreference = 'Continue' }
    
        Write-Debug -Message ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
    
        $processObject = @()
    }

    process {
    
        if ($InputObject) {
            Write-Verbose -Message ('{0}: Copy Object mode: Setting ID property to zero' -F $MyInvocation.MyCommand.Name)  

            $fields = Get-AtwsFieldInfo -Entity $entityName
      
            $CopyNo = 1

            foreach ($object in $InputObject) { 
                # Create a new object and copy properties
                $newObject = New-Object -TypeName Autotask.$entityName
        
                # Copy every non readonly property
                $fieldNames = $fields.Where( { $_.Name -ne 'id' }).Name

                if ($PSBoundParameters.ContainsKey('UserDefinedFields')) { 
                    $fieldNames += 'UserDefinedFields' 
                }

                foreach ($field in $fieldNames) { 
                    $newObject.$field = $object.$field 
                }

                if ($newObject -is [Autotask.Ticket]) {
                    Write-Verbose -Message ('{0}: Copy Object mode: Object is a Ticket. Title must be modified to avoid duplicate detection.' -F $MyInvocation.MyCommand.Name)  
                    $title = '{0} (Copy {1})' -F $newObject.Title, $CopyNo
                    $copyNo++
                    $newObject.Title = $title
                }
                $processObject += $newObject
            }   
        }
        else {
            Write-Debug -Message ('{0}: Creating empty [Autotask.{1}]' -F $MyInvocation.MyCommand.Name, $entityName) 
            $processObject += New-Object -TypeName Autotask.$entityName    
        }
        
        # Prepare shouldProcess comments
        $caption = $MyInvocation.MyCommand.Name
        $verboseDescription = '{0}: About to create {1} {2}(s). This action cannot be undone.' -F $caption, $processObject.Count, $entityName
        $verboseWarning = '{0}: About to create {1} {2}(s). This action may not be undoable. Do you want to continue?' -F $caption, $processObject.Count, $entityName

        # Lets don't and say we did!
        if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) { 
            
            # Process parameters and update objects with their values
            $processObject = $processObject | Update-AtwsObjectsWithParameters -BoundParameters $PSBoundParameters -EntityName $EntityName
            
            $result = Set-AtwsData -Entity $processObject -Create
        }
    }

    end {
        Write-Debug -Message ('{0}: End of function, returning {1} {2}(s)' -F $MyInvocation.MyCommand.Name, $result.count, $entityName)
        Return $result
    }

}
