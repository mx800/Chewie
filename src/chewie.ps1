[CmdletBinding(DefaultParameterSetName='default')]
param(
  [Parameter(Position=0,Mandatory=$false,HelpMessage="You must specify which task to execute.")]
  [ValidateSet('install','update', 'uninstall', 'outdated', 'init', 'help', '?')]
  [string] $task = "install",
  [Parameter(Position=1, Mandatory=$false)]
  [Parameter(ParameterSetName='install')]
  [Parameter(ParameterSetName='update')]
  [Parameter(ParameterSetName='uninstall')]
  [Parameter(ParameterSetName='outdated')]
  [Parameter(ParameterSetName='default')]
  [string[]] $packageList = @(),
  [Parameter(Position=2,Mandatory=$false,ParameterSetName='install')]
  [string] $path,
  [Parameter(Position=3,Mandatory=$false,ParameterSetName='install')]
  [string] $source,
  [Parameter(Position=4,Mandatory=$false,ParameterSetName='install')]
  [string] $nugetFile = $null,
  [Parameter(Position=2,Mandatory=$false,ParameterSetName='update')]
  [switch] $self,
  [Parameter(Position=2,Mandatory=$false,ParameterSetName='outdated')]
  [switch] $pre,
  [Parameter(Position=4,Mandatory=$false)]
  [switch][alias("?")] $help = $false,
  [Parameter(Position=5,Mandatory=$false)]
  [switch] $nologo = $false
  )

$here = $(Split-Path -parent $script:MyInvocation.MyCommand.path)
  
$script:chewie = @{}

if ($debug) {
  $chewie.DebugPreference = "Continue"
}

Load-Configuration

if (-not $nologo) {
  Write-Output $chewie.logo
}

if ($help -or ($task -eq "?") -or ($task -eq "-?")) {
  Write-Documentation
  return
}

Import-Module (Join-Path $here chewie.psm1)

Invoke-Chewie $task $packageList $without
