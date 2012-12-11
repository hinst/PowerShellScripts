﻿$scriptLocation = Split-Path $MyInvocation.MyCommand.Path
$requireThis = $scriptLocation + "\Copy-File.ps1"
. $requireThis

function Deploy-FileTemp 
{
	param([string]$source_file_path, [string]$destination_file_path)
	if (Test-Path $source_file_path)
	{
		$temp_file_path = [System.IO.Path]::GetTempFileName()
		Write-Host "Copying '$source_file_path' to '$temp_file_path'"
		Copy-File $source_file_path $temp_file_path
		if (Test-Path $destination_file_path)
		{
			Write-Host "Removing destination file '$destination_file_path'..."
			trap
			{
				Write-Error "Can not remove destination file:"
				Write-Host "File: '$destination_file_path"
				Write-Host "Error: '$_'"
				Continue
			}
			Remove-Item $destination_file_path -ea stop
		}
		if (Test-Path $destination_file_path)
		{
			Write-Error "Can not copy file: destination file exists"
			Write-Host "File: '$destination_file_path"
			Break
		}
		else
		{
			Write-Host "Copying '$temp_file_path' to '$destination_file_path'"
			trap 
			{
				Write-Error "While copying file:"
				Write-Host "Files: '$source_file_path' to '$destination_file_path'"
				Write-Host "Error: '$_'"
				Continue
			}
			Copy-File $temp_file_path $destination_file_path
			Remove-Item $temp_file_path -ea stop
		}
	}
	else
	{
		Write-Error "Source file '$source_file_path' does not exist"
	}
}

function Deploy-File 
{
	param([string]$source_file_path, [string]$destination_file_path)
	if (Test-Path $source_file_path)
	{
		if (Test-Path $destination_file_path)
		{
			Write-Host "Removing destination file '$destination_file_path'..."
			trap
			{
				Write-Error "Can not remove destination file:"
				Write-Host "File: '$destination_file_path"
				Write-Host "Error: '$_'"
				Continue
			}
			Remove-Item $destination_file_path -ea stop
		}
		if (Test-Path $destination_file_path)
		{
			Write-Error "Can not copy file: destination file exists"
			Write-Host "File: '$destination_file_path"
			Break
		}
		else
		{
			Write-Host "Copying '$source_file_path' to '$destination_file_path'"
			trap 
			{
				Write-Error "While copying file:"
				Write-Host "Files: '$source_file_path' to '$destination_file_path'"
				Write-Host "Error: '$_'"
				Continue
			}
			Copy-File $source_file_path $destination_file_path
		}
	}
	else
	{
		Write-Error "Source file '$source_file_path' does not exist"
	}
}