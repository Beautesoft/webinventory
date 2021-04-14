<%@ Page Title="Department Master" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="DepartmentMaster.aspx.cs" Inherits="Sequoia_BE.DepartmentMaster" %>

<asp:Content ID="Content_NestedPage" ContentPlaceHolderID="Content_PageBody" runat="server" enctype="multipart/form-data">

    <section class="content-header">
        <h1>Department Data Entry
                <small></small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="DashBoard.aspx"><i class="fa fa-folder-o"></i>Home</a></li>
            <li><a href="#">Masters</a></li>
            <li><a href="DeptMasterList.aspx">Department List</a></li>
            <li class="active">Add</li>
        </ol>
    </section>
    <section class="content">
        <!-- SELECT2 EXAMPLE -->
        <div class="box box-default">
            <!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group required">
                            <label class="control-label">Department Code</label>
                                <input type="number" class="txtDeptCodeDeptMaster form-control" runat="server" id="txtDeptCode_DeptMaster" maxlength="2"  placeholder="Enter Code"><%--disabled="disabled"--%>
                        </div>
                        <div class="form-group required">
                            <label class="control-label">Description</label>
                            <input type="text" class="form-control" runat="server" id="txtDeptDesc_DeptMaster" maxlength="255" placeholder="Enter Descripion">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Validity Period</label>
                             <select class="form-control select2" style="width: 100%;" clientidmode="Static" runat="server" id="ddl_ValidityPeriodDeptMaster">
                                    <option value="0">Select</option>
                                    <option value="1">1 year</option>
                                    <option value="2">2 year</option>
                                    <option value="3">3 year</option>
                                    <option value="4">Unlimited</option>
                            </select>
                        </div>
                        <div class="form-group required">
                            <label class="control-label">FE Sequence No</label>
                            <input type="number" class="form-control" runat="server" id="txtSeqNo_DeptMaster" maxlength="255"  value="0">
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkAllowCashSales_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp Allow Cash Sales 
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkActive_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp Department is currently active
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkFirstTrial_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is first trial
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkRetail_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is retail product
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkSaolon_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is salon product
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkService_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is service
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkVoucher_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is voucher
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkPrepaid_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is prepaid
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" runat="server" id="chkCompound_DeptMaster">
                                    &nbsp&nbsp&nbsp&nbsp&nbsp This is compound
                                </label>
                            </div>
                        </div>
                        <!-- /.form-group -->
                    </div>
                    <!-- /.col -->
                    <div class="col-md-6">
                       <div class="form-group">
                            <label class="control-label">Picture</label>
                        </div>
                        <div class="form-group">
                            <input id="fileupload" type="file" />
                            </div>
                        <div class="form-group">
                           
                            
                            <hr />
                            <%--<b>Live Preview</b>--%>
                            <%--<br />
                            <br />--%>
                            <div id="dvPreview">
                            </div>
                            <label id='lblImageName'></label>
                            <%--<button id='removeImg'>Remove Image</button>--%>
                        </div>
                    </div>
                </div>

                <!-- /.box-body -->
            </div>
            <div class="box-footer">
                <button id="btnSubmit_AddDeptMaster" type="button" runat="server" class="btn btn-primary" data-loading-text="<i class='fa fa-spinner fa-spin '></i> Add">Add</button>
            </div>
        </div>


        <!-- /.box -->
    </section>
    <%--</form>--%>
</asp:Content>
