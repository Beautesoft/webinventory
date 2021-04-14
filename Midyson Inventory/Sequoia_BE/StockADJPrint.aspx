<%@ Page Title="Reports | Adjustment Stock Print" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="StockADJPrint.aspx.cs" Inherits="Sequoia_BE.StockADJPrint" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content_PageBody" runat="server">
    <section class="content-header">
        <h1> Adjustment Stock Print
           
        </h1>
        <ol class="breadcrumb">
            <li><a href="DashBoard.aspx"><i class="fa fa-folder"></i>Home</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary box-solid">
                    <div class="row">
                        <div class="col-md-12">
                            <rsweb:ReportViewer   style="overflow-y:scroll; height:100%;" ID="rv_webBI_StkAdjPrint" runat="server" Width="100%" Height="100%" ShowRefreshButton="false" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" ShowPrintButton="true" AsyncRendering="False" SizeToReportContent="True">
                            </rsweb:ReportViewer> <%--ondrillthrough="ReportViewer1_Drillthrough1"--%>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
