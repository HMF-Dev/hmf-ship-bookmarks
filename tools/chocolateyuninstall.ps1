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

#prompt user if they would also like to remove all bookmarks from edge/chrome, set 10 sec timeout, convert response to uppercase
$removeBookmarks = Read-Host -Prompt "Remove all bookmarks from Chrome and Edge? (Y/N)" -TimeoutSec 10
$removeBookmarks = $removeBookmarks.ToString().ToUpper()

if ($removeBookmarks -eq "Y") {
    try {
        #remove bookmarks file from Chrome and Edge settings folders, if it exists
        if (Test-Path -Path $chromeBookmarks) {
            Write-Output "Removing $chromeBookmarks"
            Remove-Item -Path $chromeBookmarks
        }
        if (Test-Path -Path $edgeBookmarks) {
            Write-Output "Removing $edgeBookmarks"
            Remove-Item -Path $edgeBookmarks
        }
    }
    catch {
        Write-Output "Error removing bookmarks file from Chrome and Edge settings folders"
        Write-Output $_.Exception.Message
    }
}
