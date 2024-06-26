Set-ExecutionPolicy RemoteSigned

[string] $current_dir = @(Split-Path $MyInvocation.MyCommand.path)

# Include files
Import-Module ($current_dir + '\scripts\common.ps1')
Import-Module ($current_dir + '\scripts\network.ps1')
Import-Module ($current_dir + '\scripts\system.ps1')


####
$workdir_root = $current_dir + "\Output"
WD-Set-Directory -path $workdir_root

# System
WD-Get-SystemInfo -workdir $workdir_root

# Network
WD-Get-Network -workdir $workdir_root
WD-Get-Network-Teaming -workdir $workdir_root

exit 0