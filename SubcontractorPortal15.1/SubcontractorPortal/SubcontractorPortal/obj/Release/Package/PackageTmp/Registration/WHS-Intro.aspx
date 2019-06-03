<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WHS-Intro.aspx.cs" Inherits="SubcontractorPortal.Registration.WHS_Intro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .LMFont
        {
            font-size:16px;
            color:#000000;
            cursor:pointer;
            font-family:Verdana;
        }
        .LMFontTop
        {
            font-size:18px;
            color:#000000;
            cursor:pointer;
            font-family:Verdana;
        }
        .boxed {

            font-size:16px;
            color:#000000;
            cursor:pointer;
            font-family:Verdana;
            border:2px solid #000000;
            padding:5px 5px 5px 5px;   
            
        }

        .btnFloat {float: left;}
        .btnFloatRight {float: right;}
        .btnFloat2 {float: left; margin-left:10px;}
        .spanRight {text-align:right;}

    #PopupWindow{      
        z-index: 999;
        background-color: #B0CCF2;
        text-align: center;
        position: absolute;
        position: fixed;
        left:350px;
        width: 50%;        
        border-left:2px #4F93E3 solid;
        border-right:2px #4F93E3 solid;
        border-bottom:2px #4F93E3 solid;
        display:none;
    }

    .bFont
    {
        font-size: 1.1em;
        font-weight: 500;
        color:#000000;    
        padding:2px 2px 2px 2px;
        font-family:Verdana;
    }

    .List {
    width: 100%;
    height: 400px;
    overflow: scroll;
}

    </style>
        
</head>
<body style="background-color:#009FCE;">

    
    <form id="form1" runat="server">

        <asp:HiddenField ID="CorrectiveActions" runat="server" ClientIDMode="Static" />
        





        <table style="width:1000px; background-color:white" align="center">
            <tr>
                <td>
                    <table align="center">
                        <tr>
                
                            <td class="LMFontTop" colspan="3" >
                                <img src="../Images/Maincom_Group_Logo.jpg" width="200" height="80" />
                    
                        </tr>
                        <tr>
                            <td class="LMFont" colspan="3">&nbsp;</td>
                        </tr>

                        <tr>                
                            <td class="LMFontTop" colspan="3">                    
                                The following pages are now entering the WHS Maincom Induction process.</td>
                        </tr>

                        <tr>
                            <td class="LMFont" colspan="3">&nbsp;</td>
                        </tr>

                    </table>

                </td>
            </tr>
            <tr>
                <td class="LMFont" >
                    <ul>                        
                        <li style="padding-top:10px;">You will be required to answer all the questions by selecting the appropriate Yes or No to continue.</li>
                        <li style="padding-top:10px;">Please note that depending on your answer, the induction may cease as your answer does not comply.</li>
                        <li style="padding-top:10px;">All your answers will need to be justified.</li>
                    </ul>
                        
                </td>
            </tr>
            <tr>
                <td class="LMFont" >
                    <table align="center">
                        <tr>
                            <td class="LMFont">&nbsp;</td>
                        </tr>

                        <tr>
                            <td align="center">
                                <dx:ASPxButton ID="NextBtn" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Continue Induction" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="True" ClientIDMode="Static" EnableClientSideAPI="True"></dx:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="LMFont">&nbsp;</td>
                        </tr>

                    </table>

                </td>
            </tr>
            
        </table>



    </form>
</body>
</html>
