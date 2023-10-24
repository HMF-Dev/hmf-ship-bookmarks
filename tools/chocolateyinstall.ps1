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