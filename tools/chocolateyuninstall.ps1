# Define the paths to the Chrome and Edge bookmarks files
$chromeBookmarks = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"
$edgeBookmarks = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"

#define path to bookmarks file in temp folder
$bookmarksTemp = "C:\ProgramData\ChocoTemp\Bookmarks"

#remove bookmark file from temp folder, if it exists
if (Test-Path -Path $bookmarksTemp) {
    Write-Output "Removing $bookmarksTemp"
    Remove-Item -Path $bookmarksTemp
}
