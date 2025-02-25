#
# UEdit.ps1
#
# Open a project in Unreal Editor
#

[CmdletBinding()]
param(
    [Parameter()]$Path
)


################################################################################
##  Main
################################################################################

# Require a valid $UProjectFile

Write-Debug "Compute UProjectFile Path=[$Path]"

$UProjectFile =& $PSScriptRoot/UProjectFile.ps1 -Path:$Path

if (!$UProjectFile -or !$UProjectFile.Exists)
{
    throw "Path is not a UProject: $Path"
}


# Start UVS -Editor on the selected UProjectFile

& $PSScriptRoot/UnrealVersionSelector.ps1 -Editor $UProjectFile.FullName
