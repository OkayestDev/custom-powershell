# https://www.autoitscript.com/site/autoit/downloads/
function profileLocation() {
    cd "C:\Documents\Powershell"
}

function desktop() {
    $user = $env:UserName
    cd "C:\Users\$user\Desktop"
}

function getProcessByPort($portNumber) {
    Get-Process -Id (Get-NetTCPConnection -LocalPort $portNumber).OwningProcess
}

function killProcessById($id) {
    taskkill -F -PID $id;
}

function to-720($inputFile) {
    ffmpeg -i $inputfile -vf "scale=1280x720" "out.mp4"
}

function loadCustom($customFilename) {
    $basePath = "C:\Users\khoob\Documents\Powershell\Modules";
    $modulePath = "$basePath/$customFilename";
    Import-Module $modulePath;
}

function toExtension($fromExtension, $toExtension) {
    Get-ChildItem -Recurse *.$fromExtension | Rename-Item -NewName { $_.Name.Replace(".$fromExtension", ".$toExtension") }
}

function sarcastic($text) {
    $sarcasticText = '';
    $index = 0;
    $text = $text.toCharArray();
    foreach ($letter in $text) {
        if ($index % 2 -eq 1) {
            $sarcasticText += "$letter".ToUpper();
        }
        else {
            $sarcasticText += "$letter".ToLower();
        }

        if ($letter -match '^[a-zA-Z]') {
            $index++;
        }
    }

    Set-Clipboard $sarcasticText;
    Write-Output $sarcasticText;
}

# Must be in code to work as expected
function jestDebug($test) {
    # Send f5 to start debugger in code
    Send-AU3Key -Key "{F5}";
    clear;
    node --inspect=0.0.0.0:9228 ./node_modules/jest/bin/jest.js --runInBand --forceExit $test
}

function nodeDebug() {
    Send-AU3Key -Key "{F5}";
    clear;
    node --inspect-brk=0.0.0.0:9228 $args
}

function babelJestDebug($test) {
    # Send f5 to start debugger in code
    clear;
    Send-AU3Key -Key "{F5}";
    ./node_modules/.bin/babel-node --inspect=0.0.0.0:9228 ./node_modules/jest/bin/jest.js --runInBand --forceExit $test
}

function remove($item) {
    Remove-Item -Force -Recurse -Path $item
}

function gitSarcastic($commitMessage) {
    $sarcasticMessage = sarcastic($commitMessage);
    git commit -m $sarcasticMessage;
    echo $sarcasticMessage;
}

function dockerSh($imageId) {
    docker run -it --entrypoint /bin/bash $imageId;
}

loadCustom("git");
loadCustom("window-movement");
loadCustom("util-calls");
loadCustom("file");

Set-Alias -Name gitc -Value gitPushOrPullCurrent;
Set-Alias -Name git-stats -Value gitStats;
Set-Alias -Name delete-branches-like -Value gitDeleteAllBranchesLike;
Set-Alias -Name git-checkout-like -Value gitCheckoutBranchLike;
Set-Alias -Name profile-location -Value profileLocation;
Set-Alias -Name open-branch -Value openBranchInBrowser;
Set-Alias -Name get-process-by-port -Value getProcessByPort
Set-Alias -Name kill-process-by-id -Value killProcessById
Set-Alias -Name fetch-merge -Value fetchMerge

# set location to desktop
$currentLocation = pwd;
if ($currentLocation -match 'System32') {
    desktop;
}

$secretPath = "C:\Windows\System32\WindowsPowerShell\v1.0\secret.psm1";

if (Test-Path $secretPath) {
    Import-Module $secretPath;
}