Set-ExecutionPolicy RemoteSigned

# Include files
. '.\scripts\common.ps1'
. '.\scripts\network.ps1'
. '.\scripts\system.ps1'

# Set output directory
[string] $current_dir = @(Split-Path $MyInvocation.MyCommand.path)
$workdir_root = $current_dir + "\Output"
Set-Directory -path $workdir_root

## Dump
# System
Get-SystemInfo -workdir $workdir_root

# Network
Get-Network-Info -workdir $workdir_root
Get-Network-Teaming -workdir $workdir_root

exit 0
