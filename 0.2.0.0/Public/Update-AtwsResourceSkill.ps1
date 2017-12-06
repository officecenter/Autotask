﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Update-AtwsResourceSkill
{
  <#
      .SYNOPSIS
      This function updates a ResourceSkill through the Autotask Web Services API.
      .DESCRIPTION
      This function updates a ResourceSkill through the Autotask Web Services API.
      .INPUTS
      [Autotask.ResourceSkill[]]. This function takes objects as input. Pipeline is supported.
      .OUTPUTS
      [Autototask.ResourceSkill[]]. This function returns the updated Autotask.ResourceSkill that was returned by the API.
      .EXAMPLE
      Update-AtwsResourceSkill  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Update-AtwsResourceSkill
      .NOTES
      NAME: Update-AtwsResourceSkill
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
        [Autotask.ResourceSkill]
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