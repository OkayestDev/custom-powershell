# https://www.autoitscript.com/site/autoit/downloads/
function profileLocation() {
    cd "C:\Windows\System32\WindowsPowerShell\v1.0"
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

function loadCustom($customFilename) {
    $basePath = "C:\Windows\System32\WindowsPowerShell\v1.0\customs";
    $modulePath = "$basePath/$customFilename";
    Import-Module $modulePath;
}

function to-extension($fromExtension, $toExtension) {
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
function jest-debug($test) {
    # Send f5 to start debugger in code
    Send-AU3Key -Key "{F5}";
    clear;
    node --inspect=0.0.0.0:9228 ./node_modules/jest/bin/jest.js --runInBand --forceExit $test
}

function node-debug() {
    Send-AU3Key -Key "{F5}";
    clear;
    node --inspect-brk=0.0.0.0:9228 $args
}

function babel-jest-debug($test) {
    # Send f5 to start debugger in code
    clear;
    Send-AU3Key -Key "{F5}";
    ./node_modules/.bin/babel-node --inspect=0.0.0.0:9228 ./node_modules/jest/bin/jest.js --runInBand --forceExit $test
}

function remove($item) {
    Remove-Item -Force -Recurse -Path $item
}

loadCustom("git.psm1");
loadCustom("window-movement.psm1");
loadCustom("util-calls.psm1");
loadCustom("file.psm1");

Set-Alias -Name code-debug-migration -Value codeDebugMigration;
Set-Alias -Name dipmysql -Value dipmysqlConnect;
Set-Alias -Name pweb -Value phpWebConnect;
Set-Alias -Name php-workspace -Value phpWorkspace;
Set-Alias -Name node-workspace -Value nodeWorkspace;
Set-Alias -Name git-current -Value gitPushOrPullCurrent;
Set-Alias -Name git-stats -Value gitStats;
Set-Alias -Name delete-branches-like -Value gitDeleteAllBranchesLike;
Set-Alias -Name git-checkout-like -Value gitCheckoutBranchLike;
Set-Alias -Name full-workspace -Value setupFullWorkspace;
Set-Alias -Name profile-location -Value profileLocation;
Set-Alias -Name open-branch -Value openBranchInBrowser;
Set-Alias -Name get-process-by-port -Value getProcessByPort
Set-Alias -Name kill-process-by-id -Value killProcessById
Set-Alias -Name homee-dump -Value homeeDump
Set-Alias -Name fetch-merge -Value fetchMerge
Set-Alias -Name 24g-ticket -Value 24gTicket

# set location to desktop
$currentLocation = pwd;
if ($currentLocation -match 'System32') {
    desktop;
}

$secretPath = "C:\Windows\System32\WindowsPowerShell\v1.0\secret.psm1";

if (Test-Path $secretPath) {
    Import-Module $secretPath;
}