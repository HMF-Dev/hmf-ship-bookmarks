# Define the paths to the Chrome and Edge bookmarks files
$chromeBookmarks = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"
$edgeBookmarks = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"

#define path to bookmarks file in temp folder
$jsonPath = "C:\ProgramData\ChocoTemp\Bookmarks"
$htmlPath = "C:\ProgramData\ChocoTemp\bookmarks.html"

#remove bookmark file from temp folder, if it exists
if (Test-Path -Path $jsonPath) {
    Write-Output "Removing $jsonPath"
    Remove-Item -Path $jsonPath
}

if (Test-Path -Path $htmlPath) {
    Write-Output "Removing $htmlPath"
    Remove-Item -Path $htmlPath
}
