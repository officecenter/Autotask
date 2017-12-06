﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Update-AtwsProductVendor
{
  <#
      .SYNOPSIS
      This function updates a ProductVendor through the Autotask Web Services API.
      .DESCRIPTION
      This function updates a ProductVendor through the Autotask Web Services API.
      .INPUTS
      [Autotask.ProductVendor[]]. This function takes objects as input. Pipeline is supported.
      .OUTPUTS
      [Autototask.ProductVendor[]]. This function returns the updated Autotask.ProductVendor that was returned by the API.
      .EXAMPLE
      Update-AtwsProductVendor  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Update-AtwsProductVendor
      .NOTES
      NAME: Update-AtwsProductVendor
  #>
	  [CmdLetBinding(DefaultParameterSetName='Input_Object')]
    Param
    (
                [Parameter(
          Mandatory = $True,
          ParameterSetName = 'Input_Object',
          ValueFromPipeline = $True
        )]
        [ValidateNotNullOrEmpty()]
        [Autotask.ProductVendor]
        $InputObject
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

    
    Set-AtwsData -Entity $InputObject }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}