<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TopPage.aspx.cs" Inherits="SubcontractorPortal.TopPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en-US">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

<title>Maincom - Subcontractor Portal</title>

<link rel="stylesheet" href="/Styles/modal.css" type="text/css" media="screen" />
<link rel="stylesheet" href="styles/jquery.megamenu.css" type="text/css" media="screen" />
<link rel="stylesheet" href="styles/example.css" type="text/css" media="screen" />

<script type="text/javascript" src="Scripts/common.js"></script>
<script type="text/javascript"  src="Scripts/trace.js"></script>
<script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>

<script type="text/javascript" src="Scripts/jquery.megamenu.js"></script>

<script type="text/javascript">
    jQuery(function () {
        var SelfLocation = window.location.href.split('?');
        switch (SelfLocation[1]) {
            case "justify_right":
                jQuery(".megamenu").megamenu({ 'justify': 'right' });
                break;
            case "justify_left":
            default:
                jQuery(".megamenu").megamenu();
        }
    });


    function SetPage(url) {
        ShowWin2();
        var iframeEl = document.getElementById('MainFrame');
        if (iframeEl) {
            iframeEl.src = url;
        }

    }

    function CheckValue(option) {
        var obj = document.getElementById('JobCode');

        if (obj) {
            // click
            if (option == 1) {
                if (obj.value == 'Work Order ID') { obj.value = ''; }
            }
            //blur
            if (option == 2) {
                if (obj.value == null || obj.value == '') { obj.value = 'Work Order ID'; }
            }
        }
    }

</script>

    <style type="text/css">
        .centerdiv
        {

            text-align:center;
            
        }
        .top
        {
            width:100%;
            height:35px;
            background-color:#4E637F;
            position: fixed;
            z-index:1;
            top:0px;
            left:0px;
        }
        .mid
        {

            text-align:center;
            vertical-align:middle;
        }
        .point
        {
            cursor:pointer;
        }
        .left
        {
            text-align:left;
            text-decoration:none;
            cursor:pointer;
        }
    </style>
    <script type="text/javascript">
        function country() {
            var AU = document.getElementById("AU");
            if (AU) {
                if (AU.innerHTML == 'AU') {
                    AU.innerHTML = 'NZ';
                    // change country here
                } else {
                    AU.innerHTML = 'AU';
                    // change country here
                }
            }
        }

        function Logoff() {
            window.location.replace('/logout.aspx');
        }
        function SearchWO() {
            var WOID = document.getElementById('JobCode');
            if (WOID) {
                SetPage('/WOrders/SearchWorkOrders.aspx?WOID=' + WOID.value);
            }

        }

        function validateNumber(event) {
            var key = window.event ? event.keyCode : event.which;

            if (event.keyCode == 8 || event.keyCode == 46
             || event.keyCode == 37 || event.keyCode == 39) {
                return true;
            }
            else if (key < 48 || key > 57) {
                return false;
            }
            else return true;
        };


        $(document).ready(function () {
            $('[id^=JobCode]').keypress(validateNumber);
        });

    </script>
</head>
<body onload="setIframeHeight('MainFrame');">

<form id="form1" runat="server">
<div class="top">    
<div id="Page">
<!--MegaMenu Starts-->
    <ul class="megamenu">
    <!--
      <li>
        <a href="javascript:SetPage('/Administration/Licenses.aspx');" title="Manage your licenses" id="AU">Licenses</a>
      </li>
    -->
        <!--
        <li>
		<a href="#" class="megamenu_drop">Company Details</a>
       </li>
        -->
        <!--		
      <li>
        <a href="#" class="megamenu_drop">Help</a>
            <div style="width: 500px;">   
              <table border="0" cellpadding="3" cellspacing="3" width="100%">
                <tr>
              
                  <th class="left"><h3>Job Generals</h3></th>
                  <th class="left"><h3>Quotes</h3></th>              
                </tr>
                <tr>
                  <td class="left" valign="top">
                  
                      <ul id="list-content-1">
                          <li class="hide2" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();">Navigation</li>
                          <li>Create New Job</li>
                          <li>Update Job Details</li>
                          <li>Make an Appointment</li>
                          <li>Send Quote</li>
                      </ul>
                  

                  </td>
                  <td class="left" valign="top">
                      <ul id="list-content-2">
                          <li>Create Quote</li>
                          <li>Copy Quote</li>
                          <li>Check Quote</li>
                          <li>Send Quote</li>
                          <li>Cancel Quote</li>
                          <li>Send Multiple Quotes</li>

                      </ul>

                  </td>            
                </tr>
              </table>
            </div>
      </li>
	  -->
      <li>
        <a href="#" class="megamenu_drop">Documents</a>
            <div style="width: 500px;">   
              <table border="0" cellpadding="3" cellspacing="3" width="100%">
                <tr>
              
                  <th class="left"><h3>Maincom</h3></th>
                  <th class="left"><h3>Work Related</h3></th>              
                </tr>
                <tr>
                  <td class="left" valign="top">
                  
                      <ul id="list-content-3">
                          <li><a href="/MaincomDocuments/Maincom_Vision_Mission.pdf" target="_blank">Maincom Vision Mission</a></li>
                          <li><a href="/MaincomDocuments/Maincom_Values.pdf" target="_blank">Maincom Values</a></li>
                      </ul>
                  

                  </td>
                  <td class="left" valign="top">
                      <ul id="list-content-4">
                          <li><a href="/MaincomDocuments/Work-Order-Required-Documents-Checklist.xlsx" target="_blank">Work Order - Required Documents Checklist</a></li>
                          <li><a href="/MaincomDocuments/Field_Assessment_Evaluation.docx" target="_blank">Field Assessment Evaluation</a></li>
                          <li><a href="/MaincomDocuments/Onsite_offline_inspection.docx" target="_blank">Onsite Offline Inspection</a></li>
                          <li><a href="/MaincomDocuments/Code_of_Conduct_Policy.docx" target="_blank">Code of Conduct Policy</a></li>
						  <li><a href="/MaincomDocuments/SWMS-Checklist.doc" target="_blank">Review of Safe Work Method Statements</a></li>
                          <li><a href="/MaincomDocuments/Electrical_compliance_requirements.docx" target="_blank">Electrical Compliance Requirements</a></li>
                          <li><a href="/MaincomDocuments/Ladder_Safety.docx" target="_blank">Ladder Safety</a></li>                          
                          <li><a href="/MaincomDocuments/PLUMBING_COMPLIANCE_CERTIFICATES.docx" target="_blank">Plumbing Compliance Certificates</a></li>                         					  

                      </ul>

                  </td>            
                </tr>
              </table>
            </div>
      </li>

      <li>
        <a href="javascript:void(0)">Make Safe / Reports WO's</a>
        <div style="width:320px;">
              <table border="0" cellpadding="0" cellspacing="3">
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=300');"><img src="Images/newJob.png" width="38" height="38" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=300');">New Make Safe / Report WO's</td> 
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=350');"><img src="Images/work.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=350');"> Make Safe / Report in Progress</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=370');"><img src="Images/hourglass.png" width="26" height="26" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=370');"> Request To Complete WO</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>

                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=400');"><img src="Images/job_done.png" width="24" height="24" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=400');"> Make Safe / Report Completed</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=500');"><img src="Images/dollar_sign.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=500');"> Make Safe / Report Invoiced</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=425');"><img src="Images/dispute.png" width="30" height="30" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=425');"> Make Safe / Report In Dispute</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>

                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=600');"><img src="Images/cancelled.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx?statusID=600');"> Make Safe / Report Cancelled</td>
                </tr>

                <tr>
                    <td colspan="2"><hr /></td>
                </tr>

                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx');"><img src="Images/find.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/MakeSafe/workorderlist.aspx');"> Search Work Orders</td>
                </tr>

              </table>
            <br />

        </div>

      </li>


      <li>
        <a href="javascript:void(0)">Work Orders</a>
        <div style="width:250px;">
              <table border="0" cellpadding="0" cellspacing="3">
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=300');"><img src="Images/newJob.png" width="38" height="38" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=300');">New Work Orders</td> 
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=350');"><img src="Images/work.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=350');"> Work Orders in Progress</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                
                <%if (IsTradecom){ %>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=370');"><img src="Images/hourglass.png" width="26" height="26" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=370');">WO's Pending Approval</td>
                </tr>
                <%}else{ %>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=370');"><img src="Images/hourglass.png" width="26" height="26" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=370');"> Request To Complete WO</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>

                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=400');"><img src="Images/job_done.png" width="24" height="24" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=400');"> Work Orders Completed</td>
                </tr>

                <%} %>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=500');"><img src="Images/dollar_sign.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=500');"> Work Orders Invoiced</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>
                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=425');"><img src="Images/dispute.png" width="30" height="30" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=425');"> Work Orders In Dispute</td>
                </tr>
                <tr>
                    <td colspan="2"><hr /></td>
                </tr>

                <tr>
                    <td onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=600');"><img src="Images/cancelled.png" width="28" height="28" align="absMiddle"/></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/WOrders/workorderlist.aspx?statusID=600');"> Work Orders Cancelled</td>
                </tr>

                <!--
                <tr>
                    <td></td><td align="left" class="jobNav" onclick="jQuery(this).trigger('mouseleave'); event.stopPropagation();SetPage('/temp/select.aspx');">Old Stuff</td>
                </tr>
                  -->
              </table>
            <br />

        </div>

      </li>

      <li>
          <input type="text" id="JobCode" Width="120px" class="megamenu_searchfield" value="Work Order ID" onblur="CheckValue(2);" onclick="CheckValue(1);" />

            
                            <input type="button" class="sbutton"  value="Find Work Order" onclick="SearchWO();" />
          
      </li>

        <li>
            <img src="Images/resize.png" width="28" height="28" title="resize screen" style="cursor:pointer; padding-top:3px; margin-left:10px;" onclick="GetHeight(); setIframeHeight('MainFrame');"/>
        </li>

      <li>
        <img src="Images/exit.png" width="28" height="28" class="logout" title="Logout from the system" onclick="Logoff();" />
      </li>



    </ul>
<!--MegaMenu Ends-->
</div>
</div>

    <br /><br />    
    <asp:Panel ID="CrossPanel" runat="server" class="stickynoteTop">
        <div align="left">&nbsp; <img src="/images/loading.gif" alt="" align="Absmiddle" />&nbsp;<font size=2>&nbsp;Loading ...</font></div>
    </asp:Panel>    

<div class="centerdiv">
    <iframe src="blank.html" id="MainFrame"  scrolling="no" frameborder="0" style="width:1200px;"></iframe>

</div>

</form>
</body>
</html>