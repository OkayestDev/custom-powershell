function getScriptLocation() {
    return Split-Path -Parent $PSCommandPath;
}

function csvToJson($absoluteFilepath) {
    $scriptLocation = getScriptLocation;
    $json = node "$scriptLocation/../utils/csv-to-json/csv-parser.js" $absoluteFilepath;
    echo $json;
}

function editUtil($folderToOpen) {
    $scriptLocation = getScriptLocation;
    code "$scriptLocation/../utils/$folderToOpen"
}

Set-Alias -Name csv-to-json -Value csvToJson
Set-Alias -Name edit-util -Value editUtil

Export-ModuleMember -Variable * -Function * -Alias *