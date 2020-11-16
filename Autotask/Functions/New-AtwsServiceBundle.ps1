#Requires -Version 5.0
<#
    .COPYRIGHT
    Copyright (c) ECIT Solutions AS. All rights reserved. Licensed under the MIT license.
    See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md for license information.
#>
Function New-AtwsServiceBundle
{


<#
.SYNOPSIS
This function creates a new ServiceBundle through the Autotask Web Services API. All required properties are marked as required parameters to assist you on the command line.
.DESCRIPTION
The function supports all properties of an [Autotask.ServiceBundle] that can be updated through the Web Services API. The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values. Any required paramterer is marked as Mandatory in the PowerShell function to assist you on the command line.

If you need very complicated queries you can write a filter directly and pass it using the -Filter parameter. To get the ServiceBundle with Id number 0 you could write 'New-AtwsServiceBundle -Id 0' or you could write 'New-AtwsServiceBundle -Filter {Id -eq 0}.

'New-AtwsServiceBundle -Id 0,4' could be written as 'New-AtwsServiceBundle -Filter {id -eq 0 -or id -eq 4}'. For simple queries you can see that using parameters is much easier than the -Filter option. But the -Filter option supports an arbitrary sequence of most operators (-eq, -ne, -gt, -ge, -lt, -le, -and, -or, -beginswith, -endswith, -contains, -like, -notlike, -soundslike, -isnotnull, -isnull, -isthisday). As you can group them using parenthesis '()' you can write arbitrarily complex queries with -Filter. 

To create a new ServiceBundle you need the following required fields:
 -Name
 -PeriodType
 -AllocationCodeID

Entities that have fields that refer to the base entity of this CmdLet:


.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.ServiceBundle]. This function outputs the Autotask.ServiceBundle that was created by the API.
.EXAMPLE
$result = New-AtwsServiceBundle -Name [Value] -PeriodType [Value] -AllocationCodeID [Value]
Creates a new [Autotask.ServiceBundle] through the Web Services API and returns the new object.
 .EXAMPLE
$result = Get-AtwsServiceBundle -Id 124 | New-AtwsServiceBundle 
Copies [Autotask.ServiceBundle] by Id 124 to a new object through the Web Services API and returns the new object.
 .EXAMPLE
Get-AtwsServiceBundle -Id 124 | New-AtwsServiceBundle | Set-AtwsServiceBundle -ParameterName <Parameter Value>
Copies [Autotask.ServiceBundle] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsServiceBundle to modify the object.
 .EXAMPLE
$result = Get-AtwsServiceBundle -Id 124 | New-AtwsServiceBundle | Set-AtwsServiceBundle -ParameterName <Parameter Value> -Passthru
Copies [Autotask.ServiceBundle] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsServiceBundle to modify the object and returns the new object.

.LINK
Remove-AtwsServiceBundle
 .LINK
Get-AtwsServiceBundle
 .LINK
Set-AtwsServiceBundle

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
    [Autotask.ServiceBundle[]]
    $InputObject,

# allocation_code_id
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $AllocationCodeID,

# create_date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [datetime]
    $CreateDate,

# create_by_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $CreatorResourceID,

# service_bundle_description
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,200)]
    [string]
    $Description,

# Invoice Description
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,1000)]
    [string]
    $InvoiceDescription,

# active
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [boolean]
    $IsActive,

# update_date
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [datetime]
    $LastModifiedDate,

# service_bundle_name
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(0,150)]
    [string]
    $Name,

# discount_percent
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $PercentageDiscount,

# period_type
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity ServiceBundle -FieldName PeriodType -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity ServiceBundle -FieldName PeriodType -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [string]
    $PeriodType,

# Service Level Agreement Id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ArgumentCompleter({
      param($Cmd, $Param, $Word, $Ast, $FakeBound)
      Get-AtwsPicklistValue -Entity ServiceBundle -FieldName ServiceLevelAgreementID -Label
    })]
    [ValidateScript({
      $set = Get-AtwsPicklistValue -Entity ServiceBundle -FieldName ServiceLevelAgreementID -Label
      if ($_ -in $set) { return $true}
      else {
        Write-Warning ('{0} is not one of {1}' -f $_, ($set -join ', '))
        Return $false
      }
    })]
    [string]
    $ServiceLevelAgreementID,

# Unit Cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitCost,

# discount_dollars
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitDiscount,

# unit_price
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitPrice,

# update_by_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $UpdateResourceID
  )

    begin {
        $entityName = 'ServiceBundle'

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

        $processObject = [Collections.ArrayList]::new()
        $result = [Collections.ArrayList]::new()
    }

    process {

        if ($InputObject) {
            Write-Verbose -Message ('{0}: Copy Object mode: Setting ID property to zero' -F $MyInvocation.MyCommand.Name)

            $entityInfo = Get-AtwsFieldInfo -Entity $entityName -EntityInfo

            $CopyNo = 1

            foreach ($object in $InputObject) {
                # Create a new object and copy properties
                $newObject = New-Object -TypeName Autotask.$entityName

                # Copy every non readonly property
                $fieldNames = $entityInfo.WritableFields

                if ($PSBoundParameters.ContainsKey('UserDefinedFields')) {
                    $fieldNames += 'UserDefinedFields'
                }

                foreach ($field in $fieldNames) {
                    $newObject.$field = $object.$field
                }

                if ($newObject -is [Autotask.Ticket] -and $object.id -gt 0) {
                    Write-Verbose -Message ('{0}: Copy Object mode: Object is a Ticket. Title must be modified to avoid duplicate detection.' -F $MyInvocation.MyCommand.Name)
                    $title = '{0} (Copy {1})' -F $newObject.Title, $CopyNo
                    $copyNo++
                    $newObject.Title = $title
                }
                [void]$processObject.Add($newObject)
            }
        }
        else {
            Write-Debug -Message ('{0}: Creating empty [Autotask.{1}]' -F $MyInvocation.MyCommand.Name, $entityName)
            [void]$processObject.add((New-Object -TypeName Autotask.$entityName))
        }

        # Prepare shouldProcess comments
        $caption = $MyInvocation.MyCommand.Name
        $verboseDescription = '{0}: About to create {1} {2}(s). This action cannot be undone.' -F $caption, $processObject.Count, $entityName
        $verboseWarning = '{0}: About to create {1} {2}(s). This action may not be undoable. Do you want to continue?' -F $caption, $processObject.Count, $entityName

        # Lets don't and say we did!
        if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) {

            # Process parameters and update objects with their values
            $processObject = $processObject | Update-AtwsObjectsWithParameters -BoundParameters $PSBoundParameters -EntityName $EntityName

            try {
                # If using pipeline this block (process) will run once pr item in the pipeline. make sure to return them all
                $Data = Set-AtwsData -Entity $processObject -Create
                if ($Data.Count -gt 1) {
                    $result.AddRange($Data)
                }else {
                    $result.Add($Data)
                }
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
        }
    }

    end {
        Write-Debug -Message ('{0}: End of function, returning {1} {2}(s)' -F $MyInvocation.MyCommand.Name, $result.count, $entityName)
        Return [array]$result
    }

}