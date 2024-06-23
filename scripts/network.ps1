function WD-Get-Network ([string] $workdir)
{
  $workdir = $workdir + "\network"
  WD-Set-Directory -path $workdir

  ipconfig > $workdir\ipconfig.log
  ipconfig /all > $workdir\ipconfig_all.log

  Get-NetAdapter `
    | Select-Object Name, ifIndex, ifDesc, MacAddress, Status, LinkSpeed `
    | Export-Csv $workdir\NetAdapter.csv -encoding Default
  Get-NetAdapterBinding `
    | Select-Object Name, ifIndex, DisplayName, ComponentID, Enabled `
    | Export-Csv $workdir\NetAdapterBinding.csv -encoding Default
  Get-NetIPAddress `
    | Export-Csv $workdir\NetIPAddress.csv -encoding Default
  Get-NetAdapterAdvancedProperty `
    | Select-Object Name, DisplayName, DisplayValue `
    | Export-Csv $workdir\Get-NetAdapterAdvancedProperty.csv -encoding Default
  Get-NetIPConfiguration -All > $workdir\Get-NetIPConfiguration.log
  Get-NetIPInterface `
    | Export-Csv $workdir\Get-NetIPInterface.csv -encoding Default
 
  return
}

function WD-Get-Network-Teaming ([string] $workdir)
{
  $workdir = $workdir + "\network_team"
  WD-Set-Directory -path $workdir

  if ( (Get-NetLbfoTeam).Length -gt 0 )
  {
    Get-NetLbfoTeam
  }
  else
  {
    WD-Set-File -path $workdir\No_TeamingDevices
    Write-Host "[INFO] Teaming Network Devices are none." -ForegroundColor Cyan
  }

  return
}