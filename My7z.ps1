$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptFolderPath = Split-Path $ScriptPath
. "$ScriptFolderPath\Archiving-Utilities.ps1"
$My7z = 'C:\Program Files\7-Zip\7z.exe'
$DelphiProjectBackupExclusions = @("-xr!.git", "-xr!__history", "-xr!*.exe", "-xr!bugreport.txt", "-xr!*.map", "-xr!*.dcu", "-xr!*.map", "-xr!*.dll", "-xr!*.identcache", "-xr!*.mes", "-xr!*.local", "-xr!*.tvsconfig", "-xr!Compiled", "-xr!Log")
$VisualStudioProject = @("""-xr!.git""", "-xr!obj", "-xr!bin", "-xr!packages")

function Archive7z([string]$folder, [string]$options)
{
	$date = GetArchiveDate
	$parameters = @("a", "-t7z", "-m0=lzma2", "-mx=7", """$folder $date.7z""", "$folder\*") + $options
	Write-Host "Debug: now calling 7z with the following parameters: $My7z $parameters"
	& $My7z $parameters
}