function moveToOtherScreen() {
    Send-AU3Key -Key "{SHIFTDOWN}{LWINDOWN}{LEFT}"
    Send-AU3Key -Key "{LWINUP}"
    Start-Sleep 1;
    Send-AU3Key -Key "{ESC}";
    Send-AU3Key -Key "{SHIFTUP}"
}

function snapToSideOfScreen($rightOrLeft) {
    $otherSide = "LEFT";
    if ($rightOrLeft -eq "LEFT") {
        $otherSide = "RIGHT"
    }
    
    Send-AU3Key -Key "{LWINDOWN}{$otherSide}"
    Send-AU3Key -Key "{LWINUP}";
    Start-Sleep 1;
    Send-AU3Key -Key "{ESC}";
}

function snapToTopFourthOfScreen($rightOrLeft) {
    Send-AU3Key -Key "{LWINDOWN}{$rightOrLeft}";
    Start-Sleep 1;
    Send-AU3Key -Key "{UP}";
    Send-AU3Key -Key "{LWINUP}";
    Start-Sleep 1;
    Send-AU3Key -Key "{ESC}";
}

function snapToBottomFourthOfScreen($rightOrLeft) {
    Send-AU3Key -Key "{LWINDOWN}{$rightOrLeft}";
    Start-Sleep 1;
    Send-AU3Key -Key "{DOWN}";
    Send-AU3Key -Key "{LWINUP}";
    Start-Sleep 1;
    Send-AU3Key -Key "{ESC}";
}

function openCodeAndMaximize() {
    code .;
    Start-Sleep 1;
    Send-AU3Key -Key "{LWINDOWN}{UP}";
    Send-AU3Key -Key "{LWINUP}";
}

function moveToRightDesktop() {
    Send-AU3Key -Key "{LWINDOWN}{CTRLDOWN}{RIGHT}";
    Send-AU3Key -Key "{LWINUP}{CTRLUP}"
    Start-Sleep 1;
}

function moveToLeftDesktop() {
    Send-AU3Key -Key "{LWINDOWN}{CTRLDOWN}{LEFT}";
    Send-AU3Key -Key "{LWINUP}{CTRLUP}"
}

Export-ModuleMember -Variable * -Function * -Alias *