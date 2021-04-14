<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ConfigInterface_PaymentType.aspx.cs" Inherits="Sequoia_BE.ConfigInterface_PaymentType" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Content_PageBody" runat="server">
     <section class="content-header">
        <h1>Payment Type
            <small></small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="DashBoard.aspx"><i class="fa fa-folder-o"></i>Home</a></li>
            <li><a href="#">Masters</a></li>
            <%--<li><a href="#">Sales</a></li>--%>
            <li><a href="#">Payment Type</a></li>
            <li class="active">Operation</li>
        </ol>
    </section>
    <section class="content">
        <!-- SELECT2 EXAMPLE -->

        <asp:UpdatePanel ID="updatepanelsite" runat="server">

            <ContentTemplate>

                <div class="box">

                    <div class="box-body">

                        <div class="row">

                            <div class="col-md-12">

                                <asp:Panel runat="server" ID="panelPaymentTypeHeader">
                                    <div class="panlheader">
                                       <table width="100%">
                                            <tr style="height: 35px">
                                                <td class="tableheaderleft">Payment Type Creation
                                                <asp:Label runat="server" ID="Label6" />
                                                </td>
                                                <td class="tableheaderright">
                                                    <asp:Image ID="Image7" runat="server" ImageUrl="~/Img/plus3.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>

                                <asp:Panel runat="server" ID="panelPaymentType" CssClass="collapsepanelbody">

                                    <div></div>

                                    <div class="col-md-6">
                                        <br />
                                        <div class="form-group required">
                                            <label class="control-label">Payment Code</label>
                                            <input type="text" maxlength="255" id="txt_PayCode" class="form-control" runat="server" placeholder="Enter Code" />
                                        </div>
                                        <!-- /.form-group -->
                                        <div class="form-group required">
                                            <label class="control-label">Payment Desc</label>
                                            <input type="text" maxlength="255" id="txt_PayDesc" class="form-control" runat="server" placeholder="Enter Description" />
                                        </div>
                                        <div class="form-group required">
                                            <label>Pay Group</label>
                                            <select class="form-control select2" style="width: 100%;border-radius:10px" id="ddlPayGroup" clientidmode="Static" runat="server">
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Account Code</label>
                                            <input type="text" maxlength="50" runat="server" class="form-control" id="txt_AccountCode" placeholder="Enter Account Code" />
                                        </div>    

                                        <!-- /.form-group -->
                                    </div>

                                    <!-- /.col -->
                                    <div class="col-md-6">

                                        <br />
                                        <div class="form-group">
                                            <label class="control-label">Sequence</label>
                                            <input type="text" maxlength="100" runat="server" class="form-control" id="txt_Sequence" placeholder="Enter Sequence" />
                                        </div>
                                        <!-- /.form-group -->
                                         <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" runat="server" id="chkCreditCardActive" />
                                                    &nbsp;&nbsp;&nbsp;Credit Card Charges
                                                    
                                                </label>
                                                <input type="number" maxlength="100" runat="server" class="form-control" id="txt_CreditCharges" placeholder="Enter Credit Card Charges" style="width: 250px;display: inline;"/> <span> (%)</span>

                                            </div>
                                        </div>
                                         <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" runat="server" id="chkOnlinePaymentActive" />
                                                    &nbsp;&nbsp;&nbsp;Online Payment Charge

                                                </label>
                                                 <input type="number" maxlength="100" runat="server" class="form-control" id="txt_OnlinePayCharges" placeholder="Enter Online Payment Charges" style="width: 250px;display: inline;"/> <span> (%)</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" runat="server" id="chkGstActive" />
                                                    &nbsp;&nbsp;&nbsp;GST Active
                                                </label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" runat="server" id="chkActive" />
                                                     &nbsp;&nbsp;&nbsp; Active
                                                </label>
                                            </div>
                                        </div>
                                        <!-- /.form-group -->
                                    </div>


                                    <div class="pull-left">
                                        <button id="btn_AddPaymentType" data-loading-text="<i class='fa fa-spinner fa-spin '></i> Add" type="button" onserverclick="Operation_Click" runat="server" class="btn btn-primary">Add</button>
                                    </div>

                                </asp:Panel>

                                <ajaxToolkit:CollapsiblePanelExtender runat="server" ID="CollapsiblePanelPaymentType" TargetControlID="panelPaymentType" CollapseControlID="panelPaymentTypeHeader" ExpandControlID="panelPaymentTypeHeader"
                                    Collapsed="true" 
                                    ExpandedText="" CollapsedText="" TextLabelID="textLabel" ImageControlID="Image7" ExpandedImage="~/Img/minus2.png" CollapsedImage="~/Img/plus3.png"></ajaxToolkit:CollapsiblePanelExtender>



                            </div>

                        </div>

                        <br />

                        <div class="row">

                            <div class="col-md-12">

                                <asp:Panel runat="server" ID="panelPaymentTypeListHeader">
                                    <div class="panlheader">
                                        <table width="100%">
                                            <tr style="height: 35px">
                                                <td class="tableheaderleft">Payment Type List
                                                <asp:Label runat="server" ID="Label5" />
                                                </td>
                                                <td class="tableheaderright">
                                                    <asp:Image ID="Image6" runat="server" ImageUrl="~/Img/plus3.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>

                                <asp:Panel runat="server" ID="panelPaymentTypeList">

                                    <div class="box-header with-border">
                                        <h3 class="box-title">List of Payment Type</h3>
                                    </div>
                                    <table width="100%" id="tblPaymentTypeList" class="table table-bordered table-striped datatable" runat="server">
                                        <thead>
                                            <tr>
                                                <th>Pay Code</th>
                                                <th>Payment Description</th>
                                                <th>Pay Group</th>
                                                <th>Sequence</th>
                                                <th>Active</th>
                                                <%--<th>GST Active</th>--%>
                                               <%-- <th style="text-align: center;display:none">Action</th>--%>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                    <br />


                                    <!-- /.tab-content -->


                                </asp:Panel>

                                <ajaxToolkit:CollapsiblePanelExtender runat="server" ID="CollapsiblePanelPaymentTypeList" TargetControlID="panelPaymentTypeList" CollapseControlID="panelPaymentTypeListHeader" ExpandControlID="panelPaymentTypeListHeader"
                                    Collapsed="true"  BehaviorID="collapse"
                                    ExpandedText="" CollapsedText="" TextLabelID="textLabel" ImageControlID="Image6" ExpandedImage="~/Img/minus2.png" CollapsedImage="~/Img/plus3.png"></ajaxToolkit:CollapsiblePanelExtender>
                            
                            </div>

                        </div>

                        <br />

                        <br />                  
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

    </section>

</asp:Content>
