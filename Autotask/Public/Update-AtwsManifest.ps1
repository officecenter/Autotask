<#

    .COPYRIGHT
    Copyright (c) ECIT Solutions AS. All rights reserved. Licensed under the MIT license.
    See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md  for license information.

#>
Function Update-AtwsManifest {
    <#
        .SYNOPSIS
            This function recreates the module manifest and nuspec with default settings.
        .DESCRIPTION
            This function recreates a module manifest and nuspec for the current module and has an option
            for increasing the version number to the next available based on current API version
            and module version. There is also an option for creating a manifest for a beta module.
        .INPUTS
            Nothing, only parameters.
        .OUTPUTS
            A PowerShell module manifest and nuspec file for the current module.
        .EXAMPLE
            Update-AtwsManifest
            Recreates a manifest and a nuspec file for the current module and overwrites the existing files
            with them.
        .EXAMPLE
            Update-AtwsManifest -UpdateVersion
            Recreates a manifest and a nuspec file for the current module, updates the version number in both
            and overwrites the existing files with them.
        .NOTES
            NAME: Update-AtwsFunctions
    #>
    [CmdLetBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium'
    )]
    Param(
        # Optional flag that causes the function to increase the version number a single increment.
        [switch]
        $UpdateVersion,
    
        # Optional flag that causes the function to save the manifest files with suffix "Beta".
        [switch]
        $Beta
    )
  
    begin { 
        # Enable modern -Debug behavior
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) { $DebugPreference = 'Continue' }
    
        Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
       
        if (-not($Script:Atws.integrationsValue)) {
            Throw [ApplicationException] 'Not connected to Autotask WebAPI. Re-import module with valid credentials.'
        }
    
        # Get info from current module
        $ModuleInfo = $MyInvocation.MyCommand.Module
    
        if ($Beta.IsPresent) {
            $ModuleName = '{0}Beta' -F $ModuleInfo.Name
            $GUID = 'ff62b403-3520-4b98-a12b-343bb6b79255'
      
            # Path to RootModule
            $PSMName = Join-Path $ModuleInfo.ModuleBase ('{0}.psm1' -F $ModuleInfo.Name)
            $PSMDest = Join-Path $ModuleInfo.ModuleBase ('{0}.psm1' -F $ModuleName)
      
            # Update Beta rootmodule
            $null = Copy-Item -Path $PSMName -Destination $PSMDest -Force
        }
        else {
            $ModuleName = $ModuleInfo.Name
            $GUID = 'abd8b426-797b-4702-b66d-5f871d0701dc'
        }
    
    
        # Create the parameter hashtable 
        $ManifestParams = @{ }
    
        # Get valid parameters
        $Command = Get-Command -Name New-ModuleManifest
    
        # Pre-populate with previous values
        foreach ($parameter in $Command.Parameters.GetEnumerator()) {
            $Name = $parameter.Key
            if ($ModuleInfo.$Name) {
                $ManifestParams[$Name] = $ModuleInfo.$Name
            }
        }
    
        # Read the nuspec
        $Nuspec = New-Object -TypeName XML
        $NuspecSourcePath = Join-Path $ModuleInfo.ModuleBase ('{0}.nuspec' -F $ModuleInfo.Name)
        $NuspecPath = Join-Path $ModuleInfo.ModuleBase ('{0}.nuspec' -F $ModuleName)
        $Nuspec.Load($NuspecSourcePath)
    } 
  
    process {
    
        # Overwrite parameters that need new values
        $ManifestParams['Path'] = Join-Path $ModuleInfo.ModuleBase ('{0}.psd1' -F $ModuleName)
    
        if ($UpdateVersion.IsPresent) { 
    
            # Figure out the new module version number
            [Version]$ApiVersion = '{0}.{1}' -F $Script:Atws.GetWsdlVersion($Script:Atws.IntegrationsValue), $ModuleInfo.Version.Revision
    
            if ($ApiVersion -eq $ModuleInfo.Version) {
                # It is the same API version. Increase the revision number
                $Revision = $ModuleInfo.Version.Revision
                $Revision++
            }
            else {
                # New API version. Then this is the first revision of the new API version
                $Revision = 1
            }
    
            # Save the new version number to the parameter set
            [Version]$Moduleversion = '{0}.{1}' -F $Script:Atws.GetWsdlVersion($Script:Atws.IntegrationsValue), $Revision
        }
        else {
            # Use existing version if no update has been requested
            $Moduleversion = $ModuleInfo.Version
        }
    
        # Explicitly set important parameters
        $ManifestParams['RootModule'] = '{0}.psm1' -F $ModuleName
        $ManifestParams['Moduleversion'] = $Moduleversion
    
        # Make sure the GUID matches module manifest (Beta or Release)
        $ManifestParams['GUID'] = $GUID
    
        # Information to export
        <# 
        $Functions = @()
        $Moduleinfo.ExportedFunctions.Keys | ForEach-Object { $Functions += $_ }#-replace $ModuleInfo.Prefix, '')}
        if ($Beta.IsPresent) {
        # Make sure the beta version does not clobber the release version through 
        # automatic module import
        $ManifestParams['FunctionsToExport'] = '*'
        }
        else { 
        $ManifestParams['FunctionsToExport'] = $Functions
        }
    #>
        $ManifestParams['FunctionsToExport'] = '*'
        $ManifestParams['CmdletsToExport'] = @()
        $ManifestParams['VariablesToExport'] = @()
        $ManifestParams['AliasesToExport'] = @()
    
        # Custom
        $ManifestParams['LicenseUri'] = $ModuleInfo.PrivateData.PSData.LicenseUri
        $ManifestParams['ProjectUri'] = $ModuleInfo.PrivateData.PSData.ProjectUri
        $ManifestParams['ReleaseNotes'] = $ModuleInfo.PrivateData.PSData.ReleaseNotes
        $ManifestParams['Tags'] = $ModuleInfo.PrivateData.PSData.Tags
            
        # Recreate PrivateData
        $ManifestParams['PrivateData'] = @{ }

        # There shoult not be any default prefix anymore
        if ($ManifestParams.Keys -contains 'DefaultCommandPrefix') {
            $ManifestParams.Remove('DefaultCommandPrefix')
        }
 
    
        # Update nuspec
        $Nuspec.DocumentElement.metadata.id = $ModuleName
        $Nuspec.DocumentElement.metadata.version = $ManifestParams['Moduleversion'].Tostring()
        $Nuspec.DocumentElement.metadata.description = $ManifestParams['Description']
        $Nuspec.DocumentElement.metadata.authors = $ManifestParams['Author']
        $Nuspec.DocumentElement.metadata.tags = $ManifestParams['Tags'] -join ', '
        $Nuspec.DocumentElement.metadata.releasenotes = $ManifestParams['ReleaseNotes']
    }
    end {
        $caption = $MyInvocation.MyCommand.Name
        $verboseDescription = '{0}: Overwriting existing module manifest and nuspec information file in {1}' -F $caption, $ModuleInfo.ModuleBase
        $verboseWarning = '{0}: About to overwrite existing module manifest and nuspec information file in {1}. Do you want to continue?' -F $caption, $ModuleInfo.ModuleBase
          
        if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) { 
            # Create the new manifest
            New-ModuleManifest @ManifestParams
    
            # Save the nuspec
            $Nuspec.Save($NuspecPath)
        }
    
        Write-Debug ('{0}: End of function' -F $MyInvocation.MyCommand.Name)
        
    }
}
