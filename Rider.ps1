#
# Rider.ps1
#
# Open Rider for the given Uproject (or -Sln)
#
# For this to work, set your JetBrains Toolbox to use the script name "Rider1"
# for the version of Rider you want to use by default.
#
# Conversely, override $env:RiderCommand to set an alternate default.
#

[CmdletBinding()]
param(
    [Parameter()]$Path,
    [switch]$Sln
)

# Set $env:RiderCommand to override the default value
$RiderCommand = $env:RiderCommand ? $env:RiderCommand : "Rider1"


################################################################################
##  Main
################################################################################

if ($Sln)
{
    # Require a valid $UProjectSln
    Write-Debug "Compute UProjectSln Path=[$Path]"

    $UProjectSln =& $PSScriptRoot/UProjectSln.ps1 -Path:$Path

    if (!$UProjectSln -or !$UProjectSln.Exists)
    {
        throw "Path is not a Solution: $Path"
    }

    # Start Rider for the .sln
    $RiderFile = $UProjectSln
}
else
{
    # Require a valid $UProjectFile
    Write-Debug "Compute UProjectFile Path=[$Path]"

    $UProjectFile =& $PSScriptRoot/UProjectFile.ps1 -Path:$Path

    if (!$UProjectFile -or !$UProjectFile.Exists)
    {
        throw "Path is not a UProject: $Path"
    }

    # Start Rider for the .uproject
    $RiderFile = $UProjectFile
}


# Start Rider in the requested mode

Write-Debug "EXEC: Rider [$RiderCommand] on [$($RiderFile.FullName)]"

& $RiderCommand $RiderFile.FullName
