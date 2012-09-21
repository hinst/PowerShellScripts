function Copy-File {
    param([string]$from, [string]$to)
	trap
	{
	  Write-Error "While opening source file"
	  Write-Host "File: '$from':"
	  Write-Error "Error: $_"
	  Break
	}
	$ffile = [io.file]::OpenRead($from)
	trap 
	{
		Write-Error "While opening destination file:"
		Write-Error "  '$to':"
		Write-Error "$_"
		Break
	}
	$tofile = [io.file]::OpenWrite($to)
	trap
	{
		Write-Error "While copying files:"
		Write-Error "  '$from' to '$to':"
		Write-Error "$_"
		Break
	}
    Write-Progress -Activity "Copying file" -status "$from -> $to" -PercentComplete 0
    [byte[]]$buff = new-object byte[] 1048576
    [int]$total = [int]$count = 0
    do {
        $count = $ffile.Read($buff, 0, $buff.Length)
        $tofile.Write($buff, 0, $count)
        $total += $count
        if ($total % 1mb -eq 0) {
            Write-Progress -Activity "Copying file" -status "$from -> $to" `
               -PercentComplete ([int]($total/$ffile.Length* 100))
        }
    } while ($count -gt 0)
    $ffile.Close()
    $tofile.Close()
}