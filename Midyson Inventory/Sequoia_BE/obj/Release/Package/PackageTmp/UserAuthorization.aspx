<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="UserAuthorization.aspx.cs" Inherits="Sequoia_BE.UserAuthorization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content_PageBody" runat="server">
     <section class="content-header">
        <h1>User Authorization
       
                <small></small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="DashBoard.aspx"><i class="fa fa-folder-o"></i>Home</a></li>           
            <li class="active">User Authorization</li>
        </ol>
    </section>
    <section class="content">
        <!-- SELECT2 EXAMPLE -->
        <div class="box box-default">
            <div class="row">
                <div class="col-md-6">
                    <div class="box-header">
                        <h3 class="box-title">List of Forms</h3>
                    </div>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>User</label>                           
                             <asp:DropDownList class="form-control" ID="ddlUser" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlUser_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                    </div>
                    <!-- /.col -->
                    <div class="col-md-6">

                        <!-- /.form-group -->
                    </div>
                    <!-- /.col -->
                </div>
                <table id="UserAuthorizationHTML" clientidmode="Static"  runat="server" class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>                           
                            <th>Code</th>
                            <th>Name</th>
                            <th style="text-align:center">Authorization </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- /.box -->

    </section>
</asp:Content>
