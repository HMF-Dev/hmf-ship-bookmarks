try {
    # Define the Azure Blob Storage URL
    $azureBlobUrl = "https://sennecadeployments.blob.core.windows.net/bookmarks/hmf-ship-clerk.json"

    #create $env:ProgramData\Temp if it doesn't exist
    if (!(Test-Path -Path "C:\ProgramData\ChocoTemp")) {
        Write-Output "Creating C:\ProgramData\ChocoTemp"
        New-Item -Path "C:\ProgramData\ChocoTemp" -ItemType Directory
    }

    # Use Invoke-WebRequest to download the JSON file from Azure Blob Storage to a temp location
    Invoke-WebRequest -Uri $azureBlobUrl -OutFile "C:\ProgramData\ChocoTemp\Bookmarks"

} 
catch {
    Write-Output "Error downloading bookmarks file from Azure Blob Storage"
    Write-Output $_.Exception.Message
}

#prompt the user if they also want to copy the bookmarks to the local user's Chrome and Edge settings folders, format the response as a string, and convert it to uppercase
#if user doesn't respond in 10 seconds, skip the copy
$copyBookmarks = Read-Host -Prompt "Copy bookmarks to Chrome and Edge settings folders? (Y/N)" -TimeoutSec 10
$copyBookmarks = $copyBookmarks.ToString().ToUpper()

if ($copyBookmarks -eq "Y") {
    try {
        # Define the paths to the Chrome and Edge settings folders in the current user's profile appdata folder, test the paths, and create the folders if they don't exist  
        $chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
        $edgePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default"
    
        if (!(Test-Path -Path $chromePath)) {
            Write-Output "Creating $chromePath"
            New-Item -Path $chromePath -ItemType Directory
        }
        if (!(Test-Path -Path $edgePath)) {
            Write-Output "Creating $edgePath"
            New-Item -Path $edgePath -ItemType Directory
        }
    }
    catch {
        Write-Output "Error finding or creating Chrome and Edge settings folders"
        Write-Output $_.Exception.Message
    }
    
    # Now copy the downloaded JSON file to the Chrome and Edge settings folders
    try {
        Copy-Item -Path "C:\ProgramData\ChocoTemp\Bookmarks" -Destination $chromePath
        Copy-Item -Path "C:\ProgramData\ChocoTemp\Bookmarks" -Destination $edgePath
    }
    catch {
        Write-Output "Error copying bookmarks file to Chrome and Edge settings folders"
        Write-Output $_.Exception.Message
    }
}   