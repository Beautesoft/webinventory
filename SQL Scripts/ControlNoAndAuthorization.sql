alter table control_no
add Site_Codeid_id bigint
GO
alter table control_no
add created_at datetime2
GO
alter table control_no
add updated_at datetime2
GO
delete from control_no  where control_description='Goods Receive Note'
GO
insert into control_no 
(control_no	,control_prefix	,control_description	,CONTROLDATE	,Site_Code	,Mac_Code	,Site_Codeid_id	,created_at	,updated_at	,Include_SiteCode	,Include_MachineCode)
select '110001','WGRN','Goods Receive Note','2021.01.25',ItemSite_Code,null,ItemSite_ID,null,null,1,1 from Item_SiteList
GO
delete from control_no  where control_description='Transfer To Other Store'
GO
insert into control_no 
(control_no	,control_prefix	,control_description	,CONTROLDATE	,Site_Code	,Mac_Code	,Site_Codeid_id	,created_at	,updated_at	,Include_SiteCode	,Include_MachineCode)
select '110001','WGTO','Transfer To Other Store','2021.01.25',ItemSite_Code,null,ItemSite_ID,null,null,1,1 from Item_SiteList
GO
delete from control_no  where control_description='Transfer From Other Store'
GO
insert into control_no 
(control_no	,control_prefix	,control_description	,CONTROLDATE	,Site_Code	,Mac_Code	,Site_Codeid_id	,created_at	,updated_at	,Include_SiteCode	,Include_MachineCode)
select '110001','WGTI','Transfer From Other Store','2021.01.25',ItemSite_Code,null,ItemSite_ID,null,null,1,1 from Item_SiteList
GO
delete from control_no  where control_description='Goods Return Note'
GO
insert into control_no 
(control_no	,control_prefix	,control_description	,CONTROLDATE	,Site_Code	,Mac_Code	,Site_Codeid_id	,created_at	,updated_at	,Include_SiteCode	,Include_MachineCode)
select '110001','WRTN','Goods Return Note','2021.01.25',ItemSite_Code,null,ItemSite_ID,null,null,1,1 from Item_SiteList
GO
delete from control_no  where control_description='Adjustment Stock'
GO
insert into control_no 
(control_no	,control_prefix	,control_description	,CONTROLDATE	,Site_Code	,Mac_Code	,Site_Codeid_id	,created_at	,updated_at	,Include_SiteCode	,Include_MachineCode)
select '110001','WADJ','Adjustment Stock','2021.01.25',ItemSite_Code,null,ItemSite_ID,null,null,1,1 from Item_SiteList
GO
delete from control_no  where control_description='PO'
GO
insert into control_no 
(control_no	,control_prefix	,control_description	,CONTROLDATE	,Site_Code	,Mac_Code	,Site_Codeid_id	,created_at	,updated_at	,Include_SiteCode	,Include_MachineCode)
select '110001','WPO','PO','2021.01.25',ItemSite_Code,null,ItemSite_ID,null,null,1,1 from Item_SiteList
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InventoryFormMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InventoryFormMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[PageID] [nvarchar](255) NOT NULL,
	[URL] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](255) NOT NULL,
	[Seq] [int] NOT NULL,
	[InActive] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InventoryFormAuth]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InventoryFormAuth](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[User] [nvarchar](255) NOT NULL,
	[ReportCode] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

GO

SET IDENTITY_INSERT [dbo].[InventoryFormMaster] ON 
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (1, N'F10001', N'Goods Receive Note List', N'', N'GRNList_aspx', N'GRNList.aspx', N'liability.png', 1, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (2, N'F10002', N'Goods Transfer Out List', N'', N'GRNOutList_aspx', N'GRNOutList.aspx', N'liability.png', 2, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (3, N'F10003', N'Goods Transfer In List', N'', N'GRNInList_aspx', N'GRNInList.aspx', N'liability.png', 3, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (4, N'F10004', N'Goods Return List', N'', N'GRNReturnList_aspx', N'GRNReturnList.aspx', N'liability.png', 4, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (5, N'F10005', N'Stock Adjustment List', N'', N'StockAdjList_aspx', N'StockAdjList.aspx', N'liability.png', 5, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (6, N'F10006', N'Purchase Order List', N'', N'POList_aspx', N'POList.aspx', N'liability.png', 6, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (7, N'F10007', N'Approved PO List', N'', N'POApprovedList_aspx', N'POApprovedList.aspx', N'liability.png', 7, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (8, N'F10008', N'Purchase Order Approval', N'', N'POWithGRNList_aspx', N'POWithGRNList.aspx', N'liability.png', 8, N'N')
GO
INSERT [dbo].[InventoryFormMaster] ([ID], [Code], [Name], [Description], [PageID], [URL], [Image], [Seq], [InActive]) VALUES (9, N'F10009', N'Stock Balance', N'', N'webBI_StockBalance_aspx', N'webBI_StockBalance.aspx', N'liability.png', 9, N'N')
GO
SET IDENTITY_INSERT [dbo].[InventoryFormMaster] OFF