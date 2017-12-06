﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Set-AtwsPurchaseOrderItem
{
  <#
      .SYNOPSIS
      This function sets parameters on the PurchaseOrderItem specified by the -id parameter through the Autotask Web Services API.
      .DESCRIPTION
      This function sets parameters on the PurchaseOrderItem specified by the -id parameter through the Autotask Web Services API.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autototask.PurchaseOrderItem]. This function returns the updated Autotask.PurchaseOrderItem that was returned by the API.
      .EXAMPLE
      Set-AtwsPurchaseOrderItem  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Set-AtwsPurchaseOrderItem
      .NOTES
      NAME: Set-AtwsPurchaseOrderItem
  #>
	  [CmdLetBinding(DefaultParameterSetName='By_parameters')]
    Param
    (
                [Parameter(
          Mandatory = $true,
          ValueFromRemainingArguments = $true,
          ParameterSetName = 'By_parameters')]
        [ValidateNotNullOrEmpty()]
        [Int]
        $Id ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [Int]
         $ProductID
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [Int]
         $InventoryLocationID
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [Int]
         $Quantity
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Memo
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [double]
         $UnitCost

    )



          

  Begin
  { 
    If (-not($global:atws.Url))
    {
      Throw [ApplicationException] 'Not connected to Autotask WebAPI. Run Connect-AutotaskWebAPI first.'
    }
    Write-Verbose ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)

  }   

  Process
  {   

    $InputObject =  Get-AtwsData -Entity PurchaseOrderItem -Filter {id -eq $Id}

    Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
    {
        $InputObject.$($Parameter.Key) = $Parameter.Value
    }
        
    
    Set-AtwsData -Entity $InputObject }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}