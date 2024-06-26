function WD-Set-Directory ([string] $path)
{
  if ( Test-Path $path )
  {
    Remove-Item -Path $path -Recurse -Force
  }

  Write-Host "Create Directry (path = $path)"
  New-Item -Path $path -ItemType directory > $null
  return
}

function WD-Set-File ([string] $path)
{
  if ( Test-Path -Path $path )
  {
    Remove-Item -Path $path -Force
  }
  New-Item -Path $path -ItemType file > $null

  return
}