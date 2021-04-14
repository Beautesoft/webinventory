﻿<%@ Page Title="Goods Transfer Out" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GRNOutList.aspx.cs" Inherits="Sequoia_BE.GRNOutList" %>

<asp:Content ID="Content_NestedPage" ContentPlaceHolderID="Content_PageBody" runat="server">
    <section class="content-header">
        <h1>Goods Transfer Out List      
            <small></small>
        </h1>
        <%--<ol class="breadcrumb">
            <li><a href="DashBoard.aspx"><i class="fa fa-folder-o"></i>Home</a></li>
            <li><a href="#">Masters</a></li>
            <li><a href="GRNOutList.aspx">Goods Transfer Out</a></li>
        </ol>--%>
    </section>
    <section class="content">
        <!-- SELECT2 EXAMPLE -->
        <div class="box box-default">
           
            <div class="box-body">
            <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row" style="margin-bottom:10px">                            
                            <div class="col-lg-12">
                                <div class="btnFillter_GRNOutListMaster" data-toggle="buttons">
                                    <label class="btn btn-default active">
                                        <input type="radio" name="status" value="" checked="checked">
                                        All
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio" name="status" value="Open">
                                        Open
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio" name="status" value="Posted">
                                        Posted
                                    </label>                                   
                                </div>
                            </div>
                        </div>
                    </div>                            
                <table id="GRNOutMasterPage"  style="font-size: 13px;"  class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th style="width: 20%">Doc Number</th>
                            <th style="width: 10%">Doc Date</th>
                            <th style="width: 10%">Ref Num1</th>
                            <th style="width: 30%">Ref Num2</th>
                            <th style="width: 10%">Total Amount</th>
                            <th style="width: 20%">Status</th>
                            <th>Print</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                </div>
                <div class="fabIcon"><a style="color: white" href="GRNOut.aspx">+ </a></div>
                <!-- /.box-body -->
            </div>
        <!-- /.box -->

    </section>
</asp:Content>
