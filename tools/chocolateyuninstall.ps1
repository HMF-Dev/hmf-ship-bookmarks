# Define the paths to the Chrome and Edge bookmarks files
$chromeBookmarks = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"
$edgeBookmarks = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"

#define path to bookmarks file in temp folder
$bookmarksTemp = "C:\ProgramData\ChocoTemp\Bookmarks"

# Remove bookmarks files from the Chrome and Edge settings folders
Remove-Item -Path $chromeBookmarks -Force -ErrorAction Ignore
Remove-Item -Path $edgeBookmarks -Force -ErrorAction Ignore

#remove bookmark file from temp folder
Remove-Item -Path $bookmarksTemp -Force -ErrorAction Ignore