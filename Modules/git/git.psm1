function gitDeleteAllBranchesLike($branchNamePart) {
    git branch -D ((git branch | Select-String -Pattern $branchNamePart) | foreach { $_.ToString().Trim() });
}

function gitCheckoutBranchLike($branchNamePart) {
    git checkout ((git branch | Select-String -Pattern $branchNamePart) | foreach { $_.ToString().Trim() });
}

function gitCurrentBranch() {
    git rev-parse --abbrev-ref HEAD;
}

function fetchMerge($branch) {
    git fetch -p origin;
    git merge origin/$branch;
}

function openBranchInBrowser() {
    $currentBranch = gitCurrentBranch;
    $originUrl = gitOriginUrl;

    if ($originUrl -like '*.git*') {
        $originUrl = $originUrl.Replace('.git', '');
    }

    if ($originUrl -like '*bitbucket*') {
        start chrome "$originUrl/branch/$currentBranch";
    } else {
        start chrome "$originUrl/tree/$currentBranch";
    }
}

function gitPushOrPullCurrent($pushOrPull) {
    git $pushOrPull origin (gitCurrentBranch);
}

function gitOriginUrl {
    git remote get-url origin;
}

function gitStats {
    git diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904
}

function 24gTicket {
    $baseJiraURL = 'https://24group.atlassian.net/browse';
    $currentBranch = gitCurrentBranch;
    
    # Assumes ticket name is first after branch type (feature, bugfix, etc);
    # i.e. feature/XZ796-338-jest
    $parts = $currentBranch -Split "/";
    $branchName = $parts[1];


    $ticket = $branchName -Split "-";
    $ticket = $ticket[0] + "-" + $ticket[1];

    start chrome "$baseJiraURL/$ticket";
}

Export-ModuleMember -Variable * -Function * -Alias *