param(
    [Parameter(Position=0, Mandatory=1)]
    [string]$buildFile,
    [Parameter(Position=1, Mandatory=0)]
    [string]$taskName,
    [Parameter(Position=2, Mandatory=0)]
    [System.Collections.Hashtable]$properties = @{},
    [Parameter(Position=3, Mandatory=0)]
    [switch]$docs = $false
)

$taskList = @($taskName)
$nologo = $true

$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.path) 
remove-module unfold -ErrorAction SilentlyContinue

# First try local unfold
$import = join-path $scriptPath ..\unfold.psm1

import-module $import -ArgumentList $properties

invoke-psake $buildFile $taskList "4.0" $docs @{} $properties {
    Initialize-Configuration
} $nologo 

Remove-Sessions
remove-module unfold
