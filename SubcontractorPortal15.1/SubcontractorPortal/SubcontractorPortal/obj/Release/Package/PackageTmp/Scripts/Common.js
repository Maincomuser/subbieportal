function HideWin() {
    document.getElementById('CrossPanel').style.visibility = "hidden";    
}

function ShowWin() {
    if (document.getElementById('CrossPanel')) {
        document.getElementById('CrossPanel').style.visibility = "visible";
        setTimeout("HideWin()", 3000);
    }    
}

function ShowWin2() {
    if (document.getElementById('CrossPanel')) {
        document.getElementById('CrossPanel').style.visibility = "visible";
        setTimeout("HideWin()", 60000);
    }
}

function UpdateAudit(){
    if (document.getElementById('AuditFrame')) {
        document.getElementById('AuditFrame').src = "";
        document.getElementById('AuditFrame').src = "WorkOrderAudit.aspx";
        
    }

}

