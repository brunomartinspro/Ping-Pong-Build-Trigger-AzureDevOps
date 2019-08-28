Param(
    [string]$mode,
    [string]$apiKey,
    [string]$source,
    [string]$projectName,
    [string]$sourceBranch,
    [Parameter(Mandatory = $false)]
    [string]$lastKnownFile,
    [Parameter(Mandatory = $false)]
    [int]$maxErrorCycles,
    [Parameter(Mandatory = $false)]
    [string]$infiniteCycles
)

$version = "v1.0.0"

$currentLocation = "$(get-location)"

$releaseLocation = "$currentLocation\PingPongBuildTrigger"

Write-Host("`r`n")

if((Test-Path -Path $releaseLocation) -eq $False)
{
	Write-Host("Creating directory in $currentLocation")
	New-Item -ItemType directory -Path $releaseLocation
}
else
{
	Write-Host("Using directory $releaseLocation")
}

cd $releaseLocation

if((Test-Path -Path "$releaseLocation\Ping-Pong-Build-Trigger-$version.zip") -eq $False)
{
	Write-Host("Downloading Release $version...")

	Invoke-WebRequest "https://github.com/brunomartinspro/Ping-Pong-Build-Trigger/releases/download/$version/Ping-Pong-Build-Trigger-$version.zip" -OutFile "$releaseLocation\Ping-Pong-Build-Trigger-$version.zip"
}
else
{
	Write-Host("ZIP exists. Using previous downloaded Release $version...")
}

if((Test-Path -Path "$releaseLocation\PingPongBuildTrigger.exe") -eq $False)
{
	Write-Host("Unziping Release $version...")
	Add-Type -AssemblyName System.IO.Compression.FileSystem
	function Unzip
	{
		param([string]$zipfile, [string]$outpath)

		[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
	}

	Unzip "$releaseLocation\Ping-Pong-Build-Trigger-$version.zip" "$releaseLocation"
}
else
{
	Write-Host("EXE exists. Using previous downloaded Release $version...")
}

Write-Host("Running Release $version...`r`n")

$params = ""

if ($mode) {
    $params = $params + " --mode $mode"
}

if ($source) {
    $params = $params + " --source $source"
}

if ($apiKey) {
    $params = $params + " --api-key $apiKey"
}

if ($projectName) {
    $params = $params + " --project-name $projectName"
}

if ($sourceBranch) {
    $params = $params + " --source-branch $sourceBranch"
}

if ($lastKnownFile) {
    $params = $params + " --last-known-file $lastKnownFile"
}

if ($maxErrorCycles) {
    $params = $params + " --cycles $maxErrorCycles"
}

if ($infiniteCycles) {

    if("$infiniteCycles" -eq "true" -Or  "$infiniteCycles" -eq "1")
    {
        $params = $params + " --infinite-cycles $True"
    }

}

$params.Split(" ")

$process = Start-Process -NoNewWindow -FilePath "$releaseLocation\PingPongBuildTrigger.exe" -ArgumentList "$params"
          
while (!($process))
{
  start-sleep -s 5
}

cd $currentLocation
