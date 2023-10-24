try {
    # Define the Azure Blob Storage URL
    Write-Output "Getting blob URL"
    $azureBlobUrl = "https://sennecadeployments.blob.core.windows.net/bookmarks/hmf-ship-clerk.json"

    #create $env:ProgramData\Temp if it doesn't exist
    Write-Output "Checking for C:\ProgramData\ChocoTemp"
    if (!(Test-Path -Path "C:\ProgramData\ChocoTemp")) {
        Write-Output "Creating C:\ProgramData\ChocoTemp"
        New-Item -Path "C:\ProgramData\ChocoTemp" -ItemType Directory
    }

    Write-Output "ChocoTemp folder exists, downloading bookmarks file"

    # Use Invoke-WebRequest to download the JSON file from Azure Blob Storage to a temp location
    Invoke-WebRequest -Uri $azureBlobUrl -OutFile "C:\ProgramData\ChocoTemp\Bookmarks"

    # check if the bookmarks file exists in the temp folder, and if it does, write success message, if it does not, throw error to catch block
    if (Test-Path -Path "C:\ProgramData\ChocoTemp\Bookmarks") {
        Write-Output "Bookmarks file downloaded successfully"
    }
    else {
        Write-Output "Error downloading bookmarks file from Azure Blob Storage"
        Throw
    }

} 
catch {
    Write-Output "Error downloading bookmarks file from Azure Blob Storage"
    Write-Output $_.Exception.Message
}

