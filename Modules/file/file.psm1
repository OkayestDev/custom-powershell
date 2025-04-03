function openTest($file) {
    $baseDir = Get-Location;
    $result = Get-ChildItem -Path $baseDir -Recurse -Filter "*test*"  | where { 
        $_.FullName -match $file;
    }

    Write-Output $result.FullName;

    code $result.FullName;
}

function openFile($file) {
    $baseDir = Get-Location;
    $result = Get-ChildItem -Path $baseDir -Recurse | where { 
        $_.FullName -match $file;
    }

    Write-Output $result.FullName;

    code $result.FullName;
}

function makeAndOpen($path) {
    New-Item $path;
    code $path;
}

Set-Alias -Name open-test -Value openTest