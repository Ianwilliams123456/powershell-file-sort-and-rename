function Rename-PictureFiles {
    #establish the path, I used items on my desktop
    
    param (
        [string]$folderPath = (read-host "Please paste the path for the folder")
    )

    # Check if the folder exists
    if (-not (Test-Path -Path $folderPath -PathType Container)) {
        Write-Host "Directory '$folderPath' does not exist."
        return
    }

    # Get all files in the directory
    $files = Get-ChildItem -Path $folderPath

    # Initialize a counter for numbering
    $counter = 1

    # Rename each file the parameter in newName will be the "First Name" of all files
    foreach ($file in $files) {
        $newName = "retirement$counter.jpg"
        $newPath = Join-Path -Path $folderPath -ChildPath $newName

        # Check if the new name already exists, if so, increment the counter
        while (Test-Path -Path $newPath -PathType Leaf) {
            $counter++
            $newName = "retirement$counter.jpg"
            $newPath = Join-Path -Path $folderPath -ChildPath $newName
        }

        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName
        Write-Host "Renamed $($file.Name) to $newName"
        
        # Increment the counter for the next file
        $counter++
    }
}

# Usage: Rename-PictureFiles -folderPath "C:\Path\To\some name"
Rename-PictureFiles
