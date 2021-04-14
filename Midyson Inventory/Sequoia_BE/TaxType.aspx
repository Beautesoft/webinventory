<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TaxType.aspx.cs" Inherits="Sequoia_BE.TaxType" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content_PageBody" runat="server">
    <section class="content-header">
        <h1>Tax Type       
            <small></small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-folder-o"></i>Home</a></li>
            <li><a href="#">Tax Type</a></li>
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

                                <asp:Panel runat="server" ID="panelTaxTypeCreationHeader">
                                    <div class="panlheader">
                                       <table width="100%">
                                            <tr style="height: 35px">
                                                <td class="tableheaderleft">Tax Type Creation
                                                <asp:Label runat="server" ID="Label6" />
                                                </td>
                                                <td class="tableheaderright">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Img/plus3.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>

                                <asp:Panel runat="server" ID="panelTaxTypeCreation" CssClass="collapsepanelbody">

                                    <div></div>

                                    <div class="col-md-6">
                                        <br />
                                        <div class="form-group">
                                            <label class="control-label">Item Code</label>
                                            <input type="text" maxlength="100" id="txt_itemCode" class="form-control" runat="server" placeholder="Enter Site Code" />
                                        </div>
                                        <div class="form-group required">
                                            <label class="control-label">Tax Code</label>
                                            <input type="text" maxlength="255" id="txt_TaxCode" class="form-control" runat="server" placeholder="Enter Code" />
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label">Tax Description</label>
                                            <input type="text" maxlength="100" id="txt_TaxDesc" class="form-control" runat="server" placeholder="Enter Desc" />
                                        </div>

                                         <div class="form-group">
                                            <label class="control-label">Tax %</label>
                                            <input type="text" maxlength="100" id="txt_TaxPercent" class="form-control" runat="server" placeholder="Enter Tax %" />
                                        </div>
                                         
                                         
                                         <div class="row">
                                            <div class="col-md-6" style="margin-top: 2%">
                                             <div class="form-group">
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" runat="server" id="chk_ActiveTaxType" checked="checked">
                                                        &nbsp&nbsp&nbsp&nbsp&nbsp Active
                                                    </label>
                                                    </div>
                                                 </div>
                                            </div>
                                           <div class="col-md-6">
                           </div>


                    </div>

                                        <br />
                                         <div class="box-footer">
                                            <button id="btn_AddTaxType" data-loading-text="<i class='fa fa-spinner fa-spin '></i> Add" onserverclick="Operation_Click" type="button" style="text-align: center" runat="server" class="btn btn-primary center-block">Add</button>
                                        </div>

                                        <!-- /.form-group -->
                                    </div>


                                </asp:Panel>
                                <ajaxToolkit:CollapsiblePanelExtender runat="server" ID="CollapsiblePanelTaxTypeCreation" TargetControlID="panelTaxTypeCreation" CollapseControlID="panelTaxTypeCreationHeader" ExpandControlID="panelTaxTypeCreationHeader"
                                    Collapsed="true"  BehaviorID="collapse"
                                    ExpandedText="" CollapsedText="" TextLabelID="textLabel" ImageControlID="Image1" ExpandedImage="~/Img/minus2.png" CollapsedImage="~/Img/plus3.png"></ajaxToolkit:CollapsiblePanelExtender>

                            </div>

                        </div>

                        <br />

                        <div class="row">

                            <div class="col-md-12">

                                <asp:Panel runat="server" ID="panelTaxTypeListHeader">
                                    <div class="panlheader">
                                        <table width="100%">
                                            <tr style="height: 35px">
                                                <td class="tableheaderleft">Tax Type List
                                                <asp:Label runat="server" ID="Label5" />
                                                </td>
                                                <td class="tableheaderright">
                                                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Img/plus3.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>

                                <asp:Panel runat="server" ID="panelTaxTypeList">

                                    <div class="box-header with-border">
                                        <h3 class="box-title">List of Tax Type</h3>
                                    </div>
                                    <table width="100%" id="tbl_TaxTypeList" class="table table-bordered table-striped datatable" runat="server">
                                        <thead>
                                            <tr>
                                                <th>Item Code</th>
                                                <th>Tax Code</th>
                                                <th>Tax Description</th>
                                                <th>Tax %</th>                                                
                                                <th>Active</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                    <br />


                                    <!-- /.tab-content -->


                                </asp:Panel>

                                <ajaxToolkit:CollapsiblePanelExtender runat="server" ID="CollapsiblePanelTaxTypeList" TargetControlID="panelTaxTypeList" CollapseControlID="panelTaxTypeListHeader" ExpandControlID="panelTaxTypeListHeader"
                                    Collapsed="true" CollapsedSize="0"
                                    ExpandedText="" CollapsedText="" TextLabelID="textLabel" ImageControlID="Image2" ExpandedImage="~/Img/minus2.png" CollapsedImage="~/Img/plus3.png"></ajaxToolkit:CollapsiblePanelExtender>
                            
                            </div>

                        </div>

 
                    </div>

                </div>


            </ContentTemplate>

        </asp:UpdatePanel>

    </section>
</asp:Content>
