﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Remove-AtwsServiceCallTaskResource
{
  <#
      .SYNOPSIS
      This function deletes a ServiceCallTaskResource through the Autotask Web Services API.
      .DESCRIPTION
      This function deletes a ServiceCallTaskResource through the Autotask Web Services API.
      .INPUTS
      [Autotask.ServiceCallTaskResource[]]. This function takes objects as input. Pipeline is supported.
      .OUTPUTS
      Nothing. This fuction just deletes the Autotask.ServiceCallTaskResource that was passed to the function.
      .EXAMPLE
      Remove-AtwsServiceCallTaskResource  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Remove-AtwsServiceCallTaskResource
      .NOTES
      NAME: Remove-AtwsServiceCallTaskResource
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
        [Autotask.ServiceCallTaskResource]
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
  
    Remove-AtwsData -Entity $InputObject
 }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}