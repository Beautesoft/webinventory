<%@ Page Title="Reports | Invoice Print" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="PoAppPrint.aspx.cs" Inherits="Sequoia_BE.PoAppPrint" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content_PageBody" runat="server">
    <section class="content-header">
        <h1> Stock Transfer Out Print <%--Sales Collection         --%>
           
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
                            <rsweb:ReportViewer   style="overflow-y:scroll; height:100%;" ID="rv_webBI_InvoicePrint" runat="server" Width="100%" Height="100%" ShowRefreshButton="false" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" ShowPrintButton="true" AsyncRendering="False" SizeToReportContent="True">
                            </rsweb:ReportViewer> <%--ondrillthrough="ReportViewer1_Drillthrough1"--%>
                            <%-- <div id="grid_webBI_SaleCollection" style="font-size: 12px"></div>
                            <div id="grid_webBI_SaleCollection_Summary" style="font-size: 12px"></div>--%>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
