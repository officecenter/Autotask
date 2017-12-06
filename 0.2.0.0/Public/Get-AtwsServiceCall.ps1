﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Get-AtwsServiceCall
{
  <#
      .SYNOPSIS
      This function get one or more ServiceCall through the Autotask Web Services API.
      .DESCRIPTION
      This function creates a query based on any parameters you give and returns any resulting 
objects from the Autotask Web Services Api. By default the function returns any objects with properties 
that are Equal (-eq) to the value of the parameter. To give you more flexibility you can modify the operator
by using -NotEquals [ParameterName[]], -LessThan [ParameterName[]] and so on. 
Use Get-help Get-AtwsServiceCall for all possible operators.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autotask.ServiceCall[]]. This function outputs the Autotask.ServiceCall that was returned by the API.
      .EXAMPLE
      Get-AtwsServiceCall  -Parameter1 [Parameter1 value] -Parameter2 [Parameter2 Value] -GreaterThan Parameter2
Returns all objects where a property by name of "Parameter1" is equal to [Parameter1 value] and where a property
by name of "Parameter2" is greater than [Parameter2 Value].
      For parameters, use Get-Help Get-AtwsServiceCall
      .NOTES
      NAME: Get-AtwsServiceCall
  #>
	  [CmdLetBinding(DefaultParameterSetName='Filter')]
    Param
    (
                [Parameter(
          Mandatory = $true,
          ValueFromRemainingArguments = $true,
          ParameterSetName = 'Filter')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $Filter ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $id
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $AccountID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $StartDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $EndDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Description
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int16]
         $Complete
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $CreatorResourceID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $CreateDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $LastModifiedDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $Duration
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('New','Complete')]

        [String]
         $Status
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $CanceledByResource
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $CanceledDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $CancelationNoticeHours
 ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','StartDateTime','EndDateTime','Description','Complete','CreatorResourceID','CreateDateTime','LastModifiedDateTime','Duration','CanceledByResource','CanceledDateTime','CancelationNoticeHours')]
        [String[]]
        $NotEquals ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','StartDateTime','EndDateTime','Description','Complete','CreatorResourceID','CreateDateTime','LastModifiedDateTime','Duration','CanceledByResource','CanceledDateTime','CancelationNoticeHours')]
        [String[]]
        $GreaterThan ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','StartDateTime','EndDateTime','Description','Complete','CreatorResourceID','CreateDateTime','LastModifiedDateTime','Duration','CanceledByResource','CanceledDateTime','CancelationNoticeHours')]
        [String[]]
        $GreaterThanOrEqual ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','StartDateTime','EndDateTime','Description','Complete','CreatorResourceID','CreateDateTime','LastModifiedDateTime','Duration','CanceledByResource','CanceledDateTime','CancelationNoticeHours')]
        [String[]]
        $LessThan ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','StartDateTime','EndDateTime','Description','Complete','CreatorResourceID','CreateDateTime','LastModifiedDateTime','Duration','CanceledByResource','CanceledDateTime','CancelationNoticeHours')]
        [String[]]
        $LessThanOrEquals ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Description')]
        [String[]]
        $Like ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Description')]
        [String[]]
        $NotLike ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Description')]
        [String[]]
        $BeginsWith ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Description')]
        [String[]]
        $EndsWith ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Description')]
        [String[]]
        $Contains
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

    If (-not($Filter))
    {
        $Fields = $Atws.GetFieldInfo('ServiceCall')
        
        Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
        {
            $Field = $Fields | Where-Object {$_.Name -eq $Parameter.Key}
            If ($Field)
            { 
                If ($Field.IsPickList)
                {
                  $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value}
                  $Value = $PickListValue.Value
                }
                Else
                {
                  $Value = $Parameter.Value
                }
                $Filter += $Parameter.Key
                If ($Parameter.Key -in $NotEquals)
                { $Filter += '-ne'}
                ElseIf ($Parameter.Key -in $GreaterThan)
                { $Filter += '-gt'}
                ElseIf ($Parameter.Key -in $GreaterThanOrEqual)
                { $Filter += '-ge'}
                ElseIf ($Parameter.Key -in $LessThan)
                { $Filter += '-lt'}
                ElseIf ($Parameter.Key -in $LessThanOrEquals)
                { $Filter += '-le'}
                ElseIf ($Parameter.Key -in $Like)
                { $Filter += '-like'}
                ElseIf ($Parameter.Key -in $NotLike)
                { $Filter += '-notlike'}
                ElseIf ($Parameter.Key -in $BeginsWith)
                { $Filter += '-beginswith'}
                ElseIf ($Parameter.Key -in $EndsWith)
                { $Filter += '-endswith'}
                ElseIf ($Parameter.Key -in $Contains)
                { $Filter += '-contains'}
                Else
                { $Filter += '-eq'}
                $Filter += $Value
            }
        }
        
    } #'NotEquals','GreaterThan','GreaterThanOrEqual','LessThan','LessThanOrEquals','Like','NotLike','BeginsWith','EndsWith

    Get-AtwsData -Entity ServiceCall -Filter $Filter }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}