﻿#Requires -Version 4.0
#Version 1.6.2.17
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function Set-AtwsActionType
{


<#
.SYNOPSIS
This function sets parameters on the ActionType specified by the -InputObject parameter or pipeline through the use of the Autotask Web Services API. Any property of the ActionType that is not marked as READ ONLY by Autotask can be speficied with a parameter. You can specify multiple paramters.
.DESCRIPTION
This function one or more objects of type [Autotask.ActionType] as input. You can pipe the objects to the function or pass them using the -InputObject parameter. You specify the property you want to set and the value you want to set it to using parameters. The function modifies all objects and updates the online data through the Autotask Web Services API. The function supports all properties of an [Autotask.ActionType] that can be updated through the Web Services API. The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values.

Entities that have fields that refer to the base entity of this CmdLet:


.INPUTS
[Autotask.ActionType[]]. This function takes one or more objects as input. Pipeline is supported.
.OUTPUTS
Nothing or [Autotask.ActionType]. This function optionally returns the updated objects if you use the -PassThru parameter.
.EXAMPLE
Set-AtwsActionType -InputObject $ActionType [-ParameterName] [Parameter value]
Passes one or more [Autotask.ActionType] object(s) as a variable to the function and sets the property by name 'ParameterName' on ALL the objects before they are passed to the Autotask Web Service API and updated.
 .EXAMPLE
$ActionType | Set-AtwsActionType -ParameterName <Parameter value>
Same as the first example, but now the objects are passed to the funtion through the pipeline, not passed as a parameter. The end result is identical.
 .EXAMPLE
Get-AtwsActionType -Id 0 | Set-AtwsActionType -ParameterName <Parameter value>
Gets the instance with Id 0 directly from the Web Services API, modifies a parameter and updates Autotask. This approach works with all valid parameters for the Get function.
 .EXAMPLE
Get-AtwsActionType -Id 0,4,8 | Set-AtwsActionType -ParameterName <Parameter value>
Gets multiple instances by Id, modifies them all and updates Autotask.
 .EXAMPLE
$result = Get-AtwsActionType -Id 0,4,8 | Set-AtwsActionType -ParameterName <Parameter value> -PassThru
Gets multiple instances by Id, modifies them all, updates Autotask and returns the updated objects.

.LINK
New-AtwsActionType
 .LINK
Remove-AtwsActionType
 .LINK
Get-AtwsActionType

#>

  [CmdLetBinding(SupportsShouldProcess = $true, DefaultParameterSetName='InputObject', ConfirmImpact='Low')]
  Param
  (
# An object that will be modified by any parameters and updated in Autotask
    [Parameter(
      ParametersetName = 'Input_Object',
      ValueFromPipeline = $true
    )]
    [ValidateNotNullOrEmpty()]
    [Autotask.ActionType[]]
    $InputObject,

# The object.ids of objects that should be modified by any parameters and updated in Autotask
    [Parameter(
      ParametersetName = 'By_Id'
    )]
    [ValidateNotNullOrEmpty()]
    [long[]]
    $Id,

# Return any updated objects through the pipeline
    [Parameter(
      ParametersetName = 'Input_Object'
    )]
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [switch]
    $PassThru,

# Name
    [Parameter(
      ParametersetName = 'Input_Object'
    )]
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [Parameter(
      ParametersetName = 'By_Id'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(0,32)]
    [string]
    $Name,

# View
    [Parameter(
      ParametersetName = 'Input_Object'
    )]
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [Parameter(
      ParametersetName = 'By_Id'
    )]
    [ValidateNotNullOrEmpty()]
    [string]
    $View,

# Active
    [Parameter(
      ParametersetName = 'Input_Object'
    )]
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [Parameter(
      ParametersetName = 'By_Id'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[boolean]]
    $Active
  )
 
    begin { 
        $entityName = 'ActionType'
    
        # Enable modern -Debug behavior
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {
            $DebugPreference = 'Continue'
        }
    
        Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
           
        # Collect fresh copies of InputObject if passed any IDs
        # Has to collect in batches, or we are going to get the 
        # dreaded 'too nested SQL' error
        If ($Id.count -gt 0) { 
            $InputObject = @()
            for ($i = 0; $i -lt $Id.count; $i += 200) {
                $j = $i + 199
                if ($j -ge $Id.count) {
                    $j = $Id.count - 1
                } 
            
                # Create a filter with the current batch
                $Filter = 'Id -eq {0}' -F ($Id[$i .. $j] -join ' -or Id -eq ')
            
                $InputObject += Get-AtwsData -Entity $entityName -Filter $Filter
            }

            # Remove the ID parameter so we do not try to set it on every object
            $null = $PSBoundParameters.Remove('id')
        }
    }

    process {

        $caption = $MyInvocation.MyCommand.Name
        $verboseDescription = '{0}: About to modify {1} {2}(s). This action cannot be undone.' -F $caption, $InputObject.Count, $entityName
        $verboseWarning = '{0}: About to modify {1} {2}(s). This action cannot be undone. Do you want to continue?' -F $caption, $InputObject.Count, $entityName

        if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) { 
            
            # Process parameters and update objects with their values
            $processObject = $InputObject | Update-AtwsObjectsWithParameters -BoundParameters $PSBoundParameters -EntityName $EntityName
            
            $ModifiedObjects = Set-AtwsData -Entity $processObject
        
        }
    
    }

    end {
        Write-Debug ('{0}: End of function, returning {1} {2}(s)' -F $MyInvocation.MyCommand.Name, $ModifiedObjects.count, $entityName)
        if ($PassThru.IsPresent) { 
            Return $ModifiedObjects
        }
    }

}
