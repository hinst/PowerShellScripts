. .\Copy-File.ps1

function Deploy-FileTemp {
	param([string]$source_file_path, [string]$destination_file_path)
	$source_file_exists = Test-Path $source_file_path
	$destination_file_exists = Test-Path $destination_file_path
	if ($source_file_exists)
	{
		$temp_file_path = [System.IO.Path]::GetTempFileName()
		Write-Host "Copying '$source_file_name' to '$temp_file_path'"
		Copy-File $source_file_path $temp_file_path
		if ($destination_file_exists)
		{
			Write-Host "Removing '$destination_file_path'"
			Remove-Item $destination_file_path
		}
		Write-Host "Copying '$temp_file_path' to '$destination_file_path'"
		Copy-File $temp_file_path $destination_file_path
	}
	else
	{
		Write-Error "Source file '$source_file_path' does not exist"
	}
}