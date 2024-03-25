try {
    # Define the Azure Blob Storage URL
    Write-Output "Getting blob URLs"
    $jsonBlobUrl = "https://sennecadeployments.blob.core.windows.net/bookmarks/ship_bookmarks"
    $htmlBlobUrl = "https://sennecadeployments.blob.core.windows.net/bookmarks/ship_bookmarks.html"

    #create $env:ProgramData\Temp if it doesn't exist
    Write-Output "Checking for C:\ProgramData\ChocoTemp"
    if (!(Test-Path -Path "C:\ProgramData\ChocoTemp")) {
        Write-Output "Creating C:\ProgramData\ChocoTemp"
        New-Item -Path "C:\ProgramData\ChocoTemp" -ItemType Directory
    }

    Write-Output "ChocoTemp folder exists, downloading bookmarks file"

    # Use Invoke-WebRequest to download files to the temp folder
    Invoke-WebRequest -Uri $jsonBlobUrl -OutFile "C:\ProgramData\ChocoTemp\Bookmarks"
    Invoke-WebRequest -Uri $htmlBlobUrl -OutFile "C:\ProgramData\ChocoTemp\bookmarks.html"

    # check if the bookmarks file exist in the temp folder, and if it does, write success message, if it does not, throw error to catch block
    if (Test-Path -Path "C:\ProgramData\ChocoTemp\Bookmarks") {
        Write-Output "Bookmarks JSON file downloaded successfully"
    }
    else {
        Write-Output "Error downloading bookmarks file from Azure Blob Storage"
        Throw
    }

    # check if the bookmarks file exist in the temp folder, and if it does, write success message, if it does not, warn user
    if (Test-Path -Path "C:\ProgramData\ChocoTemp\Bookmarks.html") {
        Write-Output "Bookmarks HTML file downloaded successfully"
    }
    else {
       Write-Warning "Error downloading bookmarks file from Azure Blob Storage" 
    }
} 
catch {
    Write-Output "Error downloading bookmarks file from Azure Blob Storage"
    Write-Output $_.Exception.Message
}

