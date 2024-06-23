function global:WD-Get-SystemInfo ([string] $workdir)
{
  $workdir = $workdir + "\system"
  WD-Set-Directory -path $workdir
  
  $file="systeminfo.log"
  Write-Host "Dump systeminfo to $file ... " -NoNewline
  systeminfo > $workdir\$file
  Write-Host "ok" -ForegroundColor Green
  
  Get-WmiObject Win32_ComputerSystem
  $domain = (Get-WMIObject Win32_ComputerSystem).PartOfDomain
  if($domain)
  {
    Write-Output "joined to Domain."
} else {
    Write-Output "not joined to Domain(WORKGROUP)."
  }
  
  $file="gci_env.csv"
  Write-Host "Dump environment values to $file ... " -NoNewline
  gci env: | Select-Object Name, Value | Export-Csv -path $workdir\$file
  Write-Host "ok" -ForegroundColor Green

  WD-Get-Registry -workdir $workdir
    
  $file="Get-Disk.csv"
  Write-Host "Dump Disk Information to $file ... " -NoNewline
  Get-Disk `
    | Select-Object Number, FriendlyName, BusType, OperationalStatus, PartitionStyle, Size, PhysicalSectorSize, `
                    IsBoot, IsClustered, IsOffline, IsReadOnly, IsSystem, NumberOfPartitions `
    | Export-Csv -path $workdir\$file
  Write-Host "ok" -ForegroundColor Green
  
  $file="Get-PhysicalDisk.csv"
  Write-Host "Dump Physical Disk Information to $file ... " -NoNewline
  Get-PhysicalDisk | Export-Csv -path $workdir\$file
  Write-Host "ok" -ForegroundColor Green

  return
}


function WD-Get-Registry ([string] $workdir)
{
  $reg_path_hash = @{
    HKCR             = 'HKEY_CLASSES_ROOT';
    HKCU             = 'HKEY_CURRENT_USER';
    HKLM_BCD00000000 = 'HKEY_LOCAL_MACHINE\BCD00000000';
    HKLM_HARDWARE    = 'HKEY_LOCAL_MACHINE\HARDWARE';
    HKLM_SAM         = 'HKEY_LOCAL_MACHINE\SAM';
 #   HKLM_SECURITY    = 'HKEY_LOCAL_MACHINE\SECURITY';
    HKLM_SOFTWARE    = 'HKEY_LOCAL_MACHINE\SOFTWARE';
    HKLM_SYSTEM      = 'HKEY_LOCAL_MACHINE\SYSTEM';
    HKU              = 'HKEY_USERS';
    HKCC             = 'HKEY_CURRENT_CONFIG'
  }

  Write-Host "Dump registry infomation."

  $reg_path_hash.GetEnumerator() | sort Name |
  ForEach-Object{
    $file="registry_" + $_.Name + ".log"
    Write-Host " " $_.Value "to $file ... " -NoNewline
    reg query $_.Value /s > $workdir\$file
    Write-Host "ok" -ForegroundColor Green
  }

  Write-Host " Success to dump registry infomation."  -ForegroundColor Green

  return
}