<%@ Page Title="Stock Balance " Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="webBI_StockBalance.aspx.cs" Inherits="Sequoia_BE.webBI_StockBalance" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content_PageBody" runat="server">
    <section class="content-header">
        <h1>Stock Balance                    
        </h1>
        <ol class="breadcrumb">
            <li><a href="DashBoard.aspx"><i class="fa fa-folder"></i>Home</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-10">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Dept</label>                          
                             <select class="form-control select2" clientidmode="Static" id="ddlDept_webBI_StockBalance" runat="server" data-placeholder="Select Dept" multiple="true" style="width: 100%;">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Brand</label>                            
                             <select class="form-control select2" clientidmode="Static" id="ddlBrand_webBI_StockBalance" runat="server" data-placeholder="Select Brand" multiple="true" style="width: 100%;">
                            </select>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Range</label>                           
                             <select class="form-control select2" clientidmode="Static" id="ddlRange_webBI_StockBalance" runat="server" data-placeholder="Select Range" multiple="true" style="width: 100%;">
                            </select>
                        </div>
                    </div>


                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Site</label>                           
                             <select class="form-control select2" clientidmode="Static" id="ddlSite_webBI_StockBalance" runat="server" data-placeholder="Select Site" multiple="true" style="width: 100%;">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Item</label>
                            <select class="form-control select2" style="width: 100%;" id="ddlFItem_webBI_StockBalance" data-placeholder="Select Item" multiple="true" clientidmode="Static" runat="server">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4" style="display:none">
                        <div class="form-group">
                            <label>To Item</label>
                            <select class="form-control select2" style="width: 100%;" id="ddlTItem_webBI_StockBalance" data-placeholder="Select Site" multiple="true" clientidmode="Static" runat="server">
                            </select>
                        </div>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-4">
                        <div class="form-group required">
                            <label class="control-label">As On Date</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="text" runat="server" class="form-control pull-right" id="dtAsOnDate_webBI_StockBalance">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <input type="checkbox" runat="server" id="chkShowZeroQtyItems_webBI_StockBalance">Show 0 Qty Items                               
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <input type="checkbox" runat="server" id="chkShowInActive_webBI_StockBalance">Show Inactive Items           
                        </div>
                    </div>
                </div>


            </div>

            <div class="col-md-2">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group" style="text-align: center;margin-top: 10%;">
                            <button id="btnOperation" style="background-color: #8b7306" type="button" onserverclick="Operation_Click" runat="server" class="btn btn-primary2">Load Report</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary box-solid">
                    <div class="row">
                        <div class="col-md-12">
                            <%--<div id="grid_webBI_StockBalance" style="font-size: 10px"></div>--%>
                            <rsweb:ReportViewer  style="overflow-y:scroll; height:100%;" ID="rv_webBI_StockBalance" runat="server" Width="100%" Height="100%" ShowRefreshButton="false" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" ShowPrintButton="true" AsyncRendering="False" SizeToReportContent="True">
                            </rsweb:ReportViewer>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
