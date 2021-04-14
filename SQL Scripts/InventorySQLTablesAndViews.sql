--1.appointment_remarks - table missing in loopback not use for Inventory
--2.BusinessHrs - not use for Inventory - Loopback error table missing
--3.CommTypes - not use for Inventory - Loopback error "Invalid column name 'Comm_Type_ID'
--4.dept_SiteList - not use for inventory - loopback error     "message": "Invalid object name 'dbo.dept_SiteList'.",
--5. ItemComponents - not use for invenntoey - loopback error     "message": "Invalid column name 'id'.",
--6.Item_Rating - not use for invenory -table missing 
--7.itemUsageList - not use for inventory - Loopback error     "message": "Invalid object name 'dbo.itemUsageList'.",
--8.PayGroups - api name - not use for inventory - Loopback error - invalid column name 
--9.rangelist - not use for inventory -  loopback error     "message": "Invalid object name 'dbo.rangelist'.",
--10.SkinAnalyses(Api Name)- Not use for Inventory - loopback error     "message": "Invalid column name 'Sync_GUID'.",Sync_LstUpd,Sync_ClientIndex,
--12. stockdetails - not use for inventory - loopback error     "message": "Invalid object name 'dbo.stockdetails'.",
--13.suggestion - not use for inventory - loopback error     "message": "Invalid object name 'dbo.suggestion'.",
--14.Tasktype - not use for inventory - loopback error     "message": "Invalid object name 'dbo.Tasktype'.",
--15.Treatmentfaces - not use for Invenoty - Loopback error is     "message": "Invalid column name 'Sync_GUID'.",Sync_LstUpd,Sync_ClientIndex,
--16.VoucherRecords(Api name )- not use for inventory - loopback error is     "message": "Invalid column name 'Sync_GUID'.",
alter table control_no
add Include_SiteCode bit
GO
alter table control_no
add Include_MachineCode bit
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'Stk_Movdoc_Hdr' AND COLUMN_NAME = 'PO_NO')
BEGIN
alter table Stk_Movdoc_Hdr add PO_NO nvarchar(80)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PO](
	[PO_ID] [int] IDENTITY(1,1) NOT NULL,
	[PO_NO] [nvarchar](20) NULL,
	[ItemSite_Code] [nvarchar](10) NULL,
	[SUPP_Code] [nvarchar](10) NULL,
	[PO_REF] [nvarchar](20) NULL,
	[PO_User] [nvarchar](10) NULL,
	[PO_DATE] [smalldatetime] NULL,
	[PO_STATUS] [nvarchar](50) NULL,
	[PO_TTQTY] [float] NULL,
	[PO_TTFOC] [float] NULL,
	[PO_TTDISC] [float] NULL,
	[PO_TTAMT] [float] NULL,
	[PO_ATTN] [nvarchar](30) NULL,
	[PO_REMK1] [nvarchar](50) NULL,
	[PO_REMK2] [nvarchar](50) NULL,
	[PO_BNAME] [nvarchar](40) NULL,
	[PO_BADDR1] [nvarchar](30) NULL,
	[PO_BADDR2] [nvarchar](30) NULL,
	[PO_BADDR3] [nvarchar](30) NULL,
	[PO_BPOSTCODE] [nvarchar](8) NULL,
	[PO_BSTATE] [nvarchar](15) NULL,
	[PO_BCITY] [nvarchar](10) NULL,
	[PO_BCOUNTRY] [nvarchar](10) NULL,
	[PO_DADDR1] [nvarchar](30) NULL,
	[PO_DADDR2] [nvarchar](30) NULL,
	[PO_DADDR3] [nvarchar](30) NULL,
	[PO_DPOSTCODE] [nvarchar](8) NULL,
	[PO_DSTATE] [nvarchar](15) NULL,
	[PO_DCITY] [nvarchar](15) NULL,
	[PO_DCOUNTRY] [nvarchar](20) NULL,
	[PO_CANCELQTY] [float] NULL,
	[PO_RECSTATUS] [nvarchar](10) NULL,
	[PO_RECEXPECT] [smalldatetime] NULL,
	[PO_RECTTL] [float] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL,
	[PO_TIME] [smalldatetime] NULL,
	[REQ_NO] [nvarchar](40) NULL,
	[contactPerson] [nvarchar](200) NULL,
	[terms] [nvarchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[PO]' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[PO] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[PO]' AND COLUMN_NAME = 'PO_TIME')
BEGIN
ALTER TABLE [dbo].[PO] ADD  DEFAULT (getdate()) FOR [PO_TIME]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[PO]' AND COLUMN_NAME = 'REQ_NO')
BEGIN
ALTER TABLE [dbo].[PO] ADD  [REQ_NO] [nvarchar](40) NULL
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[PO]' AND COLUMN_NAME = 'contactPerson')
BEGIN
ALTER TABLE [dbo].[PO] ADD  [contactPerson] [nvarchar](200) NULL
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[PO]' AND COLUMN_NAME = 'terms')
BEGIN
ALTER TABLE [dbo].[PO] ADD  [terms] [nvarchar](200) NULL
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PO_Approval]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PO_Approval](
	[POAPP_ID] [int] IDENTITY(1,1) NOT NULL,
	[PO_No] [nvarchar](200) NULL,
	[GRN_No] [nvarchar](200) NULL,
	[ITEMSITE_CODE] [nvarchar](10) NULL,
	[STATUS] [nvarchar](10) NULL,
	[POAPP_ITEMCODE] [nvarchar](20) NULL,
	[POAPP_ITEMDESC] [nvarchar](max) NULL,
	[POAPP_ITEMPRICE] [float] NULL,
	[POAPP_QTY] [int] NULL,
	[POAPP_TTLQTY] [int] NULL,
	[POAPP_AMT] [float] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL,
	[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[PO_Approval]' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[PO_Approval] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REQ]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[REQ](
	[REQ_ID] [int] IDENTITY(1,1) NOT NULL,
	[REQ_NO] [nvarchar](200) NULL,
	[ItemSite_Code] [nvarchar](10) NULL,
	[SUPP_Code] [nvarchar](100) NULL,
	[REQ_REF] [nvarchar](200) NULL,
	[REQ_User] [nvarchar](100) NULL,
	[REQ_DATE] [smalldatetime] NULL,
	[REQ_STATUS] [nvarchar](40) NULL,
	[REQ_TTQTY] [float] NULL,
	[REQ_TTFOC] [float] NULL,
	[REQ_TTDISC] [float] NULL,
	[REQ_TTAMT] [float] NULL,
	[REQ_ATTN] [nvarchar](300) NULL,
	[REQ_REMK1] [nvarchar](500) NULL,
	[REQ_REMK2] [nvarchar](500) NULL,
	[REQ_BNAME] [nvarchar](400) NULL,
	[REQ_BADDR1] [nvarchar](300) NULL,
	[REQ_BADDR2] [nvarchar](300) NULL,
	[REQ_BADDR3] [nvarchar](300) NULL,
	[REQ_BPOSTCODE] [nvarchar](8) NULL,
	[REQ_BSTATE] [nvarchar](15) NULL,
	[REQ_BCITY] [nvarchar](100) NULL,
	[REQ_BCOUNTRY] [nvarchar](100) NULL,
	[REQ_DADDR1] [nvarchar](300) NULL,
	[REQ_DADDR2] [nvarchar](300) NULL,
	[REQ_DADDR3] [nvarchar](300) NULL,
	[REQ_DPOSTCODE] [nvarchar](8) NULL,
	[REQ_DSTATE] [nvarchar](15) NULL,
	[REQ_DCITY] [nvarchar](15) NULL,
	[REQ_DCOUNTRY] [nvarchar](200) NULL,
	[REQ_CANCELQTY] [float] NULL,
	[REQ_RECSTATUS] [nvarchar](10) NULL,
	[REQ_RECEXPECT] [smalldatetime] NULL,
	[REQ_RECTTL] [float] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL,
	[REQ_TIME] [smalldatetime] NULL,
	[supplierName] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ]' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[REQ] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ]' AND COLUMN_NAME = '[REQ_TIME]')
BEGIN
ALTER TABLE [dbo].[REQ] ADD  DEFAULT (newid()) FOR [REQ_TIME]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REQ_DETAIL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[REQ_DETAIL](
	[REQ_ID] [int] IDENTITY(1,1) NOT NULL,
	[ITEMSITE_CODE] [nvarchar](10) NULL,
	[STATUS] [nvarchar](10) NULL,
	[REQD_ITEMCODE] [nvarchar](20) NULL,
	[REQD_ITEMDESC] [nvarchar](max) NULL,
	[REQD_ITEMPRICE] [float] NULL,
	[REQD_QTY] [int] NULL,
	[REQ_APPQTY] [float] NULL,
	[REQD_FOCQTY] [int] NULL,
	[REQD_TTLQTY] [int] NULL,
	[REQD_PRICE] [float] NULL,
	[REQD_DISCPER] [float] NULL,
	[REQD_DISCAMT] [float] NULL,
	[REQD_AMT] [float] NULL,
	[REQD_RECQTY] [int] NULL,
	[REQD_CANCELQTY] [int] NULL,
	[REQD_OUTQTY] [int] NULL,
	[REQD_DATE] [smalldatetime] NULL,
	[REQD_TIME] [smalldatetime] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL,
	[BrandCode] [nvarchar](15) NULL,
	[BrandName] [nvarchar](30) NULL,
	[LineNumber] [int] NOT NULL,
	[REQ_No] [nvarchar](20) NULL,
	[PostStatus] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ_DETAIL]' AND COLUMN_NAME = '[Sync_GUID]')
BEGIN
ALTER TABLE [dbo].[REQ_DETAIL] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ_DETAIL]' AND COLUMN_NAME = '[BrandCode]')
BEGIN
ALTER TABLE [dbo].[REQ_DETAIL] ADD  DEFAULT ('') FOR [BrandCode]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ_DETAIL]' AND COLUMN_NAME = '[BrandName]')
BEGIN
ALTER TABLE [dbo].[REQ_DETAIL] ADD  DEFAULT ('') FOR [BrandName]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ_DETAIL]' AND COLUMN_NAME = '[LineNumber]')
BEGIN
ALTER TABLE [dbo].[REQ_DETAIL] ADD  DEFAULT ((0)) FOR [LineNumber]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ_DETAIL]' AND COLUMN_NAME = '[REQ_No]')
BEGIN
ALTER TABLE [dbo].[REQ_DETAIL] ADD  DEFAULT ('') FOR [REQ_No]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[REQ_DETAIL]' AND COLUMN_NAME = '[PostStatus]')
BEGIN
ALTER TABLE [dbo].[REQ_DETAIL] ADD  DEFAULT ((0)) FOR [PostStatus]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DO](
[DO_ID] [int] IDENTITY(1,1) NOT NULL,
[DO_NO] [nvarchar](20) NULL,
[ItemSite_Code] [nvarchar](10) NULL,
[SUPP_Code] [nvarchar](10) NULL,
[DO_REF] [nvarchar](20) NULL,
[DO_User] [nvarchar](10) NULL,
[DO_DATE] [smalldatetime] NULL,
[DO_STATUS] [nvarchar](50) NULL,
[DO_TTQTY] [float] NULL,
[DO_TTFOC] [float] NULL,
[DO_TTDISC] [float] NULL,
[DO_TTAMT] [float] NULL,
[DO_ATTN] [nvarchar](30) NULL,
[DO_REMK1] [nvarchar](50) NULL,
[DO_REMK2] [nvarchar](50) NULL,
[DO_BNAME] [nvarchar](40) NULL,
[DO_BADDR1] [nvarchar](30) NULL,
[DO_BADDR2] [nvarchar](30) NULL,
[DO_BADDR3] [nvarchar](30) NULL,
[DO_BPOSTCODE] [nvarchar](8) NULL,
[DO_BSTATE] [nvarchar](15) NULL,
[DO_BCITY] [nvarchar](10) NULL,
[DO_BCOUNTRY] [nvarchar](10) NULL,
[DO_DADDR1] [nvarchar](30) NULL,
[DO_DADDR2] [nvarchar](30) NULL,
[DO_DADDR3] [nvarchar](30) NULL,
[DO_DPOSTCODE] [nvarchar](8) NULL,
[DO_DSTATE] [nvarchar](15) NULL,
[DO_DCITY] [nvarchar](15) NULL,
[DO_DCOUNTRY] [nvarchar](20) NULL,
[DO_CANCELQTY] [float] NULL,
[DO_RECSTATUS] [nvarchar](10) NULL,
[DO_RECEXPECT] [smalldatetime] NULL,
[DO_RECTTL] [float] NULL,
[Sync_GUID] [uniqueidentifier] NOT NULL,
[Sync_ClientIndex] [int] NULL,
[Sync_LstUpd] [datetime] NULL,
[Sync_ClientIndexString] [nvarchar](max) NULL,
[DO_TIME] [smalldatetime] NULL,
[PO_NO] [nvarchar](40) NULL,
[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[DO] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO' AND COLUMN_NAME = 'DO_TIME')
BEGIN
ALTER TABLE [dbo].[DO] ADD  DEFAULT (getdate()) FOR [DO_TIME]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DO_DETAIL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DO_DETAIL](
[DO_ID] [int] IDENTITY(1,1) NOT NULL,
[ITEMSITE_CODE] [nvarchar](10) NULL,
[STATUS] [nvarchar](10) NULL,
[DOD_ITEMCODE] [nvarchar](20) NULL,
[DOD_ITEMDESC] [nvarchar](max) NULL,
[DOD_ITEMPRICE] [float] NULL,
[DOD_QTY] [int] NULL,
[DOD_FOCQTY] [int] NULL,
[DOD_TTLQTY] [int] NULL,
[DOD_PRICE] [float] NULL,
[DOD_DISCPER] [float] NULL,
[DOD_DISCAMT] [float] NULL,
[DOD_AMT] [float] NULL,
[DOD_RECQTY] [int] NULL,
[DOD_CANCELQTY] [int] NULL,
[DOD_OUTQTY] [int] NULL,
[DOD_DATE] [smalldatetime] NULL,
[DOD_TIME] [smalldatetime] NULL,
[Sync_GUID] [uniqueidentifier] NOT NULL,
[Sync_ClientIndex] [int] NULL,
[Sync_LstUpd] [datetime] NULL,
[Sync_ClientIndexString] [nvarchar](max) NULL,
[BrandCode] [nvarchar](15) NULL,
[BrandName] [nvarchar](30) NULL,
[LineNumber] [int] NOT NULL,
[DO_No] [nvarchar](20) NULL,
[PostStatus] [bit] NULL,
[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO_DETAIL' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[DO_DETAIL] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO_DETAIL' AND COLUMN_NAME = 'BrandCode')
BEGIN
ALTER TABLE [dbo].[DO_DETAIL] ADD  DEFAULT ('') FOR [BrandCode]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO_DETAIL' AND COLUMN_NAME = 'BrandName')
BEGIN
ALTER TABLE [dbo].[DO_DETAIL] ADD  DEFAULT ('') FOR [BrandName]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO_DETAIL' AND COLUMN_NAME = 'LineNumber')
BEGIN
ALTER TABLE [dbo].[DO_DETAIL] ADD  DEFAULT ((0)) FOR [LineNumber]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO_DETAIL' AND COLUMN_NAME = 'DO_No')
BEGIN
ALTER TABLE [dbo].[DO_DETAIL] ADD  DEFAULT ('') FOR [DO_No]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'DO_DETAIL' AND COLUMN_NAME = 'PostStatus')
BEGIN
ALTER TABLE [dbo].[DO_DETAIL] ADD  DEFAULT ((0)) FOR [PostStatus]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'PO_detail' AND COLUMN_NAME = 'LineNumber')
BEGIN
alter table [PO_detail] add LineNumber int
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'PO_detail' AND COLUMN_NAME = 'PO_ID')
BEGIN
alter table [PO_detail] add PO_ID int
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'PO_detail' AND COLUMN_NAME = 'PO_No')
BEGIN
alter table [PO_detail] add PO_No nvarchar(40)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'PO_detail' AND COLUMN_NAME = 'PostStatus')
BEGIN
alter table [PO_detail] add PostStatus bit
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'PO_detail' AND COLUMN_NAME = 'BrandName')
BEGIN
alter table [PO_detail] add BrandName nvarchar(200)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'PO_detail' AND COLUMN_NAME = 'BrandCode')
BEGIN
alter table [PO_detail] add BrandCode nvarchar(200)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'req' AND COLUMN_NAME = 'supplierName')
BEGIN
alter table req add supplierName nvarchar(100)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_supply' AND COLUMN_NAME = 'numberOfTotalPOs')
BEGIN
alter table item_supply add numberOfTotalPOs int
END
Go
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_supply' AND COLUMN_NAME = 'numberOfOpenPOs')
BEGIN
alter table item_supply add numberOfOpenPOs int
END
Go
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_supply' AND COLUMN_NAME = 'accountNumber')
BEGIN
alter table item_supply add accountNumber nvarchar(100)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'notificationSetting')
BEGIN
alter table employee add notificationSetting bit
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'Attendance')
BEGIN
alter table employee add Attendance bit
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'Treat_Exp_Day_Limit')
BEGIN
alter table employee add Treat_Exp_Day_Limit int
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'FCMToken')
BEGIN
alter table employee add FCMToken nvarchar(max)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'skillset')
BEGIN
alter table employee add skillset nvarchar(80)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'employeeAppType')
BEGIN
alter table employee add employeeAppType nvarchar(80)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'Leave_taken')
BEGIN
alter table employee add Leave_taken int
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'employee' AND COLUMN_NAME = 'Leave_bal')
BEGIN
alter table employee add Leave_bal int
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_sitelist' AND COLUMN_NAME = 'Ratings')
BEGIN
alter table item_sitelist add Ratings nvarchar(80)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_sitelist' AND COLUMN_NAME = 'pic_Path')
BEGIN
alter table item_sitelist add pic_Path nvarchar(max)
END
Go
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_sitelist' AND COLUMN_NAME = 'QRCode')
BEGIN
alter table item_sitelist add QRCode nvarchar(80)
END
Go
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'item_sitelist' AND COLUMN_NAME = 'siteDbConnectionUrl')
BEGIN
alter table item_sitelist add siteDbConnectionUrl nvarchar(200)
END
GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','GRN','Goods Receive Note','2008.05.07','SEQ',null)
--GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','TFS','Transfer To Other Store','2008.05.07','SEQ',null)
--GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','RGRN','Goods Return Note','2008.05.07','SEQ',null)
--GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','AJS','Adjustment Stock','2008.05.07','SEQ',null)
--GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','POR','PO REQUISITE','2008.05.07','SEQ',null)
--GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','PO','PO','2008.05.07','SEQ',null)
--GO
--insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)values('110001','POIV','Outlet PO Invoice','2008.05.07','SEQ',null)

--Go
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stk_MovDoc_Dtl' AND COLUMN_NAME = 'DOCUOMDesc')
BEGIN
alter table stk_MovDoc_Dtl add DOCUOMDesc nvarchar(100)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stk_MovDoc_Dtl' AND COLUMN_NAME = 'itmBrandDesc')
BEGIN
alter table stk_MovDoc_Dtl add itmBrandDesc nvarchar(100)
END
Go
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stk_MovDoc_Dtl' AND COLUMN_NAME = 'itmRangeDesc')
BEGIN
alter table stk_MovDoc_Dtl add itmRangeDesc nvarchar(100)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'printUom')
BEGIN
alter table stock add printUom nvarchar(1000)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'MOQQty')
BEGIN
alter table stock add MOQQty float
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'printDesc')
BEGIN
alter table stock add printDesc nvarchar(max)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'printLineNo')
BEGIN
alter table stock add printLineNo int
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'isTnc')
BEGIN
alter table stock add isTnc bit
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'T1_Tax_Code')
BEGIN
alter table stock add T1_Tax_Code nvarchar(40)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'T2_Tax_Code')
BEGIN
alter table stock add T2_Tax_Code nvarchar(40)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'IS_ALLOW_FOC')
BEGIN
alter table stock add IS_ALLOW_FOC bit
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Vilidity_From_Date')
BEGIN
alter table stock add Vilidity_From_Date datetime
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Vilidity_To_date')
BEGIN
alter table stock add Vilidity_To_date datetime
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Vilidity_From_Time')
BEGIN
alter table stock add Vilidity_From_Time datetime
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Vilidity_To_Time')
BEGIN
alter table stock add Vilidity_To_Time datetime
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Prepaid_Disc_Type')
BEGIN
alter table stock add Prepaid_Disc_Type nvarchar(40)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Prepaid_Disc_Percent')
BEGIN
alter table stock add Prepaid_Disc_Percent float
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Srv_Duration')
BEGIN
alter table stock add Srv_Duration float
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'Voucher_Template_Name')
BEGIN
alter table stock add Voucher_Template_Name nvarchar(100)
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'IS_HAVE_TAX')
BEGIN
alter table stock add IS_HAVE_TAX bit
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'stock' AND COLUMN_NAME = 'AutoProportion')
BEGIN
alter table stock add AutoProportion bit
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblStockBalanceDay]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblStockBalanceDay](
[id] [int] IDENTITY(1,1) NOT NULL,
[SA_DATE] [datetime] NULL,
[ITEM_CODE] [nvarchar](40) NULL,
[UOM] [nvarchar](40) NULL,
[ItemSite_Code] [nvarchar](40) NULL,
[ONHAND_QTY] [float] NULL,
[Time] [datetime] NULL
) ON [PRIMARY]
END
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedDOGRNList')
BEGIN
DROP VIEW [approvedDOGRNList]
END
GO
CREATE VIEW [dbo].[approvedDOGRNList]
AS
SELECT        TOP (100) PERCENT dbo.Stk_Movdoc_Hdr.DOC_NO AS GRNNo, dbo.Stk_Movdoc_Hdr.PO_ID, 
dbo.DO.DO_NO AS doNumber, dbo.DO.ItemSite_Code AS siteCode, 
dbo.DO.SUPP_Code AS supplierCode,dbo.DO.DO_REMK1 AS doRemark, dbo.DO.DO_DATE AS doDate, dbo.DO.DO_TIME AS doTime ,
(CASE WHEN isnull(Stk_Movdoc_Hdr.PO_NO, '') = '' THEN DO.DO_STATUS ELSE 'Delivered' END)AS doStatus, 
dbo.DO.DO_TTQTY AS doTotalQty, ISNULL(dbo.Stk_Movdoc_Hdr.DOC_QTY, 0) AS APPQTY, dbo.DO.DO_BPOSTCODE AS postCode, dbo.DO.DO_ATTN AS supplier
FROM            dbo.DO 
LEFT OUTER JOIN dbo.Stk_Movdoc_Hdr ON dbo.DO.DO_NO = dbo.Stk_Movdoc_Hdr.PO_NO
WHERE        (dbo.DO.DO_STATUS='Approved')
ORDER BY DOC_DATE DESC
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedDOList')
BEGIN
DROP VIEW [approvedDOList]
END
GO
CREATE VIEW [dbo].[approvedDOList]
AS
SELECT        TOP (100) PERCENT dbo.DO.DO_NO AS POno, dbo.REQ.REQ_ID, dbo.REQ.REQ_NO AS poNumber, dbo.REQ.ItemSite_Code AS siteCode, dbo.REQ.SUPP_Code AS supplierCode, dbo.REQ.REQ_REMK1 AS poRemark, 
                         dbo.REQ.REQ_DATE AS poDate, dbo.REQ.REQ_TIME AS poTime, (CASE WHEN isnull(DO.PO_NO, '') = '' THEN REQ.REQ_status ELSE DO.DO_STATUS END) AS poStatus, dbo.REQ.REQ_TTQTY AS poTotalQty, 
                         ISNULL(dbo.DO.DO_TTQTY, 0) AS APPQTY, dbo.REQ.REQ_BPOSTCODE AS postCode, dbo.REQ.REQ_ATTN AS supplier
FROM            dbo.REQ LEFT OUTER JOIN
                         dbo.DO ON dbo.REQ.REQ_NO = dbo.DO.PO_NO
WHERE        (dbo.REQ.REQ_STATUS <> '')
ORDER BY poDate DESC
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedGRNList')
BEGIN
DROP VIEW [approvedGRNList]
END
GO
CREATE VIEW [dbo].[approvedGRNList]
AS
SELECT        TOP (100) PERCENT dbo.Stk_Movdoc_Hdr.DOC_NO AS GRNNo, dbo.Stk_Movdoc_Hdr.PO_ID, 
dbo.PO.PO_NO AS poNumber, dbo.PO.ItemSite_Code AS siteCode, 
dbo.PO.SUPP_Code AS supplierCode,dbo.PO.PO_REMK1 AS poRemark, dbo.PO.PO_DATE AS poDate, dbo.PO.PO_TIME AS poTime ,
(CASE WHEN isnull(Stk_Movdoc_Hdr.PO_NO, '') = '' THEN PO.PO_STATUS ELSE 'Approved' END)AS poStatus, 
dbo.PO.PO_TTQTY AS poTotalQty, ISNULL(dbo.Stk_Movdoc_Hdr.DOC_QTY, 0) AS APPQTY, dbo.PO.PO_BPOSTCODE AS postCode, dbo.PO.PO_ATTN AS supplier
FROM            dbo.PO 
LEFT OUTER JOIN dbo.Stk_Movdoc_Hdr ON dbo.PO.PO_NO = dbo.Stk_Movdoc_Hdr.PO_NO
WHERE        (dbo.PO.PO_STATUS <> '')
ORDER BY DOC_DATE DESC
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedOutletPODetailList')
BEGIN
DROP VIEW [approvedOutletPODetailList]
END
GO
CREATE VIEW [dbo].[approvedOutletPODetailList]
as
select PO.PO_ID as id,PO_Approval.PO_NO,PO_detail.LineNumber,PO_detail.POD_ITEMCODE,PO_detail.POD_ITEMDESC,PO_detail.BrandName,
--PO_detail.POD_ITEMPRICE,
PO_Approval.POAPP_ITEMPRICE as POD_ITEMPRICE,
PO_detail.POD_DISCPER,
PO_detail.POD_DISCAMT,PO_detail.POD_QTY,PO_Approval.POAPP_QTY
from PO
inner join  PO_detail on PO.PO_NO=PO_detail.PO_No
inner join item_supply on dbo.PO.SUPP_Code = dbo.item_supply.SPLY_CODE
inner join PO_Approval on dbo.PO.PO_NO = dbo.PO_Approval.PO_NO and PO_detail.POD_ITEMCODE=PO_Approval.POAPP_ITEMCODE
--order by PO_Approval.PO_NO,PO_detail.LineNumber

GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedOutletPOList')
BEGIN
DROP VIEW [approvedOutletPOList]
END
GO
CREATE VIEW [dbo].[approvedOutletPOList]
as
select PO.po_ID as id,PO.po_no,PO.ItemSite_Code AS siteCode,PO.SUPP_Code AS supplierCode,PO.PO_REMK1 AS poRemark, PO.PO_DATE AS poDate,PO.PO_TIME AS poTime,'Approved' as poStatus,
PO.PO_TTQTY AS poTotalQty,item_supply.SUPPLYDESC,sum(PO_Approval.POAPP_QTY) as APPQTY
from PO
inner join item_supply on dbo.PO.SUPP_Code = dbo.item_supply.SPLY_CODE
inner join PO_Approval on dbo.PO.PO_NO = dbo.PO_Approval.PO_NO
group by PO.po_ID ,PO.po_no,PO.ItemSite_Code,PO.SUPP_Code ,PO.PO_REMK1 , PO.PO_DATE ,PO.PO_TIME ,PO.PO_TTQTY ,item_supply.SUPPLYDESC

GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedPOList')
BEGIN
DROP VIEW [approvedPOList]
END
GO
CREATE VIEW [dbo].[approvedPOList]
AS
SELECT        TOP (100) PERCENT dbo.PO.PO_NO AS POno, dbo.REQ.REQ_ID, dbo.REQ.REQ_NO AS poNumber, dbo.REQ.ItemSite_Code AS siteCode, dbo.REQ.SUPP_Code AS supplierCode, dbo.REQ.REQ_REMK1 AS poRemark, 
                         dbo.REQ.REQ_DATE AS poDate, dbo.REQ.REQ_TIME AS poTime, (CASE WHEN isnull(PO.PO_NO, '') = '' THEN REQ.REQ_status ELSE PO.PO_STATUS END) AS poStatus, dbo.REQ.REQ_TTQTY AS poTotalQty, 
                         ISNULL(dbo.PO.PO_TTQTY, 0) AS APPQTY, dbo.REQ.REQ_BPOSTCODE AS postCode, dbo.REQ.REQ_ATTN AS supplier
FROM            dbo.REQ LEFT OUTER JOIN
                         dbo.PO ON dbo.REQ.REQ_NO = dbo.PO.REQ_NO
WHERE        (dbo.REQ.REQ_STATUS <> '')
ORDER BY poDate DESC
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'DODetailsList')
BEGIN
DROP VIEW [DODetailsList]
END
GO
CREATE VIEW [dbo].[DODetailsList]
AS
SELECT DO_detail.DO_ID as poId,DO_detail.DO_No as doNo,DO_detail.LineNumber,DO_detail.DOD_ITEMCODE,DO_detail.DOD_ITEMDESC,DO_detail.DOD_ITEMPRICE,
DO_detail.DOD_QTY,(DO_detail.DOD_ITEMPRICE * DO_detail.DOD_QTY) as DOD_PRICE,
stock.Item_UOM as docUom,item_UOM.UOM_Desc as DOCUOMDesc,stock.item_Brand as itmBrand,item_BRAND.itm_desc as brandname,stock.Item_Range as itmRange,
item_range.itm_desc as itmRangeDesc from   dbo.DO_detail
LEFT OUTER JOIN dbo.stock  ON dbo.DO_detail.DOD_ITEMCODE = dbo.stock.item_code
LEFT OUTER JOIN dbo.item_UOM  ON dbo.item_UOM.UOM_Code = dbo.stock.Item_UOM
LEFT OUTER JOIN dbo.item_BRAND  ON dbo.item_BRAND.itm_Code = dbo.stock.item_Brand
LEFT OUTER JOIN dbo.item_range  ON dbo.item_range.itm_Code = dbo.stock.Item_Range
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'POAppPrintList')
BEGIN
DROP VIEW [POAppPrintList]
END
GO
CREATE VIEW [dbo].[POAppPrintList]
AS
select '' as id,stk_movDoc_hdr.PO_NO,stk_movDoc_hdr.DOC_NO as GRN_NO,convert(varchar,stk_movDoc_hdr.DOC_DATE,103) as DOC_DATE,DOC_REF1,stk_movDoc_hdr.SUPPLY_NO,Item_Supply.SUPPLYDESC,
stk_movDoc_hdr.DOC_ATTN,stk_movDoc_hdr.DOC_REMK1,stk_movDoc_dtl.DOC_LINENO,stk_movDoc_dtl.ITEMCODE,stk_movDoc_dtl.ITEMDESC,stk_movDoc_dtl.DOC_QTY,stk_movDoc_dtl.itmBrandDesc,
item_sitelist.ItemSite_Desc as ToSite,sitelist.ItemSite_Desc as FromSite,stk_movDoc_hdr.STORE_NO
from stk_movDoc_hdr
inner join stk_movDoc_dtl on stk_movDoc_hdr.DOC_NO=stk_movDoc_dtl.DOC_NO
inner join Item_Supply on stk_movDoc_hdr.SUPPLY_NO=Item_Supply.SPLY_CODE
inner join item_sitelist on item_sitelist.itemSite_code=stk_movDoc_hdr.STORE_NO
inner join item_sitelist sitelist on sitelist.itemSite_code like '%HQ%'
where isnull(stk_movDoc_hdr.po_no,'' )<>''
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'PODetailsList')
BEGIN
DROP VIEW [PODetailsList]
END
GO
CREATE VIEW [dbo].[PODetailsList]
AS
SELECT PO_detail.PO_ID as poId,PO_detail.PO_No as poNo,PO_detail.LineNumber,PO_detail.POD_ITEMCODE,PO_detail.POD_ITEMDESC,
round(PO_detail.POD_ITEMPRICE,2) as POD_ITEMPRICE,
PO_detail.POD_QTY,round((PO_detail.POD_ITEMPRICE * PO_detail.POD_QTY),2) as POD_PRICE,
item_UOM.UOM_Desc as docUom,item_UOM.UOM_Desc as DOCUOMDesc,stock.item_Brand as itmBrand,item_BRAND.itm_desc as brandname,stock.Item_Range as itmRange,
item_range.itm_desc as itmRangeDesc from   dbo.PO_detail
LEFT OUTER JOIN dbo.stock  ON dbo.PO_detail.POD_ITEMCODE = dbo.stock.item_code
LEFT OUTER JOIN dbo.item_UOM  ON dbo.item_UOM.UOM_Desc = dbo.PO_detail.BrandCode
LEFT OUTER JOIN dbo.item_BRAND  ON dbo.item_BRAND.itm_Code = dbo.stock.item_Brand
LEFT OUTER JOIN dbo.item_range  ON dbo.item_range.itm_Code = dbo.stock.Item_Range
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'POPrintList')
BEGIN
DROP VIEW [POPrintList]
END
GO
CREATE VIEW [dbo].[POPrintList]
AS
select po.PO_NO,po.SUPP_Code,Item_Supply.SUPPLYDESC,convert(varchar,PO.po_date,103) as po_date,PO.contactPerson,po.terms,
PO_DETAIL.POD_QTY,stock.Item_UOM,Stock.item_code,Stock.Item_Name,
round(PO_DETAIL.POD_PRICE,2) as POD_PRICE,
round((PO_DETAIL.POD_QTY * PO_DETAIL.POD_PRICE),2) as TOTAL,PO.ItemSite_Code
from po 
inner join PO_DETAIL on po.PO_NO=PO_DETAIL.PO_No
inner join stock on stock.item_code=PO_DETAIL.POD_ITEMCODE
inner join Item_Supply on po.SUPP_Code=Item_Supply.SPLY_CODE
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME LIKE 'USP_STOCK_BALANCE')
BEGIN
DROP PROCEDURE [USP_STOCK_BALANCE]
END
GO
CREATE PROCEDURE [dbo].[USP_STOCK_BALANCE]	
@ITEM_DIV NVARCHAR(40)	,
@Item_Code NVARCHAR(40)	,
@item_Brand NVARCHAR(40),
@Item_Range NVARCHAR(40),
@date NVARCHAR(40)		
AS

DECLARE @COUNT INT
SET @COUNT=(select COUNT(*) from tblStockBalanceDay where convert(varchar,SA_DATE,103)=convert(varchar,@date,103))
IF @COUNT=0
BEGIN
SELECT * INTO #A1
FROM (
		
		--SELECT B.Item_no, item_link.link_code as [Item Code],B.Item_Name as Item_Desc,
		--C.itm_desc AS BRAND,D.itm_desc AS RANGE,E.UOM_Desc AS UOM,
		--ItemSite_Code,A.ONHAND_QTY as Amount 
		--FROM tblStockBalanceDay A
		--INNER JOIN	Stock		B	ON A.ITEM_CODE=B.item_code
		--inner join item_link on item_link.ITEM_CODE = B.item_code + '0000' 
		--LEFT JOIN	Item_Brand	C	ON B.item_Brand=C.itm_code
		--LEFT JOIN	Item_Range	D	ON B.Item_Range=D.itm_code 
		--LEFT JOIN	Item_UOM    E	ON A.UOM=E.UOM_Code
		--where B.item_isactive = 1 and item_link.Itm_IsActive = 1 AND
		--A.SA_DATE=(SELECT MAX(SA_DATE) FROM tblStockBalanceDay WHERE convert(varchar,SA_DATE,103)<convert(varchar,@date,103)) AND B.Item_Div = @ITEM_DIV AND B.Item_Code LIKE @Item_Code AND B.item_Brand LIKE @item_Brand AND B.Item_Range LIKE @Item_Range

		SELECT '' as Item_no,Stock.ITEM_CODE as [Item Code],Stock.ITEM_NAME as Item_Desc,Item_Brand.itm_desc AS BRAND,
		Item_Range.itm_desc AS RANGE,Item_UOM.UOM_Desc AS UOM,
		ITEM_SITELIST.ItemSite_Code ,isnull(tblStockBalanceDay.ONHAND_QTY,0) as Amount  FROM Stock
		LEFT JOIN	Item_Brand	ON Stock.item_Brand=Item_Brand.itm_code 
		LEFT JOIN	Item_Range	ON Stock.Item_Range=Item_Range.itm_code 
		LEFT JOIN	Item_UOM    ON Stock.Item_UOM=Item_UOM.UOM_Code
		LEFT JOIN	ITEM_SITELIST  ON ITEM_SITELIST.ItemSite_Isactive=1
		LEFT JOIN	tblStockBalanceDay  ON tblStockBalanceDay.ITEM_CODE=Stock.item_code and 
		tblStockBalanceDay.ItemSite_Code=ITEM_SITELIST.ItemSite_Code and 
		tblStockBalanceDay.SA_DATE=(SELECT MAX(SA_DATE) FROM tblStockBalanceDay WHERE convert(varchar,SA_DATE,103)<convert(varchar,@date,103))
		where Stock.item_isactive = 1 and Stock.Item_Div = @ITEM_DIV AND Stock.Item_Code LIKE @Item_Code AND 
		Stock.item_Brand LIKE @item_Brand AND Stock.Item_Range LIKE @Item_Range

		
) as s
PIVOT
(
    SUM(Amount)
    FOR ItemSite_Code IN (AWHQ,AW01, AW02, AW03, AW04, AW05,AW06, AW07, AW08, AW09, AW10,AW11)
)AS pvt

SELECT Item_no,[Item Code],Item_Desc,BRAND,RANGE,UOM,
	ISNULL(AWHQ,0) as AWHQ, ISNULL(AW01,0) as AW01, ISNULL(AW02,0) as AW02, ISNULL(AW03,0) as AW03, ISNULL(AW04,0) as AW04, ISNULL(AW05,0) as AW05, 
	ISNULL(AW06,0) as AW06, ISNULL(AW07,0) as AW07, ISNULL(AW08,0) as AW08,ISNULL(AW09,0) as AW09,ISNULL(AW10,0) as AW10,ISNULL(AW11,0) as AW11,
	ISNULL(AWHQ,0) + ISNULL(AW01,0) + ISNULL(AW02,0) + ISNULL(AW03,0) + ISNULL(AW04,0) + ISNULL(AW05,0) + ISNULL(AW06,0) + ISNULL(AW07,0) + ISNULL(AW08,0) +
	ISNULL(AW09,0) +ISNULL(AW10,0) +ISNULL(AW11,0) 
	AS BALANCE
	FROM  #A1 ORDER BY Item_no ASC

END
ELSE
BEGIN
SELECT * INTO #A2
FROM (
		
		--SELECT B.Item_no, item_link.link_code as [Item Code],B.Item_Name as Item_Desc,
		--C.itm_desc AS BRAND,D.itm_desc AS RANGE,E.UOM_Desc AS UOM,
		--ItemSite_Code,A.ONHAND_QTY as Amount 
		--FROM tblStockBalanceDay A
		--INNER JOIN	Stock		B	ON A.ITEM_CODE=B.item_code
		--inner join item_link on item_link.ITEM_CODE = B.item_code + '0000' 
		--LEFT JOIN	Item_Brand	C	ON B.item_Brand=C.itm_code
		--LEFT JOIN	Item_Range	D	ON B.Item_Range=D.itm_code 
		--LEFT JOIN	Item_UOM    E	ON A.UOM=E.UOM_Code
		--where B.item_isactive = 1 and item_link.Itm_IsActive = 1 AND
		--convert(varchar,A.SA_DATE,103)=convert(varchar,@date,103) AND B.Item_Div = @ITEM_DIV AND B.Item_Code LIKE @Item_Code AND B.item_Brand LIKE @item_Brand AND B.Item_Range LIKE @Item_Range

		SELECT '' as Item_no,Stock.ITEM_CODE as [Item Code],Stock.ITEM_NAME as Item_Desc,Item_Brand.itm_desc AS BRAND,
		Item_Range.itm_desc AS RANGE,Item_UOM.UOM_Desc AS UOM,
		ITEM_SITELIST.ItemSite_Code ,isnull(tblStockBalanceDay.ONHAND_QTY,0) as Amount  FROM Stock
		LEFT JOIN	Item_Brand	ON Stock.item_Brand=Item_Brand.itm_code 
		LEFT JOIN	Item_Range	ON Stock.Item_Range=Item_Range.itm_code 
		LEFT JOIN	Item_UOM    ON Stock.Item_UOM=Item_UOM.UOM_Code
		LEFT JOIN	ITEM_SITELIST  ON ITEM_SITELIST.ItemSite_Isactive=1
		LEFT JOIN	tblStockBalanceDay  ON tblStockBalanceDay.ITEM_CODE=Stock.item_code and 
		tblStockBalanceDay.ItemSite_Code=ITEM_SITELIST.ItemSite_Code and 
		convert(varchar,tblStockBalanceDay.SA_DATE,103)=convert(varchar,@date,103)
		where Stock.item_isactive = 1 and Stock.Item_Div = @ITEM_DIV AND Stock.Item_Code LIKE @Item_Code AND 
		Stock.item_Brand LIKE @item_Brand AND Stock.Item_Range LIKE @Item_Range

		
) as s
PIVOT
(
    SUM(Amount)
    FOR ItemSite_Code IN (AWHQ,AW01, AW02, AW03, AW04, AW05,AW06, AW07, AW08, AW09, AW10,AW11)
)AS pvt


	SELECT Item_no,[Item Code],Item_Desc,BRAND,RANGE,UOM,
	ISNULL(AWHQ,0) as AWHQ, ISNULL(AW01,0) as AW01, ISNULL(AW02,0) as AW02, ISNULL(AW03,0) as AW03, ISNULL(AW04,0) as AW04, ISNULL(AW05,0) as AW05, 
	ISNULL(AW06,0) as AW06, ISNULL(AW07,0) as AW07, ISNULL(AW08,0) as AW08,ISNULL(AW09,0) as AW09,ISNULL(AW10,0) as AW10,ISNULL(AW11,0) as AW11,
	ISNULL(AWHQ,0) + ISNULL(AW01,0) + ISNULL(AW02,0) + ISNULL(AW03,0) + ISNULL(AW04,0) + ISNULL(AW05,0) + ISNULL(AW06,0) + ISNULL(AW07,0) + ISNULL(AW08,0) +
	ISNULL(AW09,0) +ISNULL(AW10,0) +ISNULL(AW11,0) 
	AS BALANCE
	FROM  #A2 ORDER BY Item_no ASC


END


GO

IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'stockdetails')
BEGIN
DROP VIEW [stockdetails]
END
GO
CREATE VIEW [dbo].[stockdetails]
AS
SELECT        s.item_code AS stockCode, s.Item_Name AS stockName, s.Item_Type AS Type, s.item_isactive AS isActive, iu.UOM_Code AS uom, iu.UOM_Desc AS uomDescription, s.ONHAND_QTY AS quantity, 
                         (CASE s.Item_Div WHEN 1 THEN 'Retail Product' WHEN 2 THEN 'Salon Product' WHEN 3 THEN 'Service' WHEN 4 THEN 'Voucher' WHEN 5 THEN 'Prepaid' ELSE 'invalid Division' END) AS Division, r.itm_code AS RangeCode, 
                         r.itm_desc AS Range, d.itm_code AS DeptCode, d.itm_desc AS Department, c.itm_code AS ClassCode, c.itm_desc AS Class, b.itm_code AS BrandCode, b.itm_desc AS Brand, l.LINK_CODE AS linkCode, s.Item_Price, 
                         s.MOQQty
FROM            dbo.Stock AS s LEFT OUTER JOIN
                         dbo.Item_Link AS l ON s.item_code = l.ITEM_CODE AND l.LINK_TYPE = 'L' AND l.Itm_IsActive = 1 RIGHT OUTER JOIN
                         dbo.Item_Range AS r ON s.Item_Range = r.itm_code RIGHT OUTER JOIN
                         dbo.Item_Dept AS d ON s.Item_Dept = d.itm_code RIGHT OUTER JOIN
                         dbo.item_Class AS c ON s.Item_Class = c.itm_code RIGHT OUTER JOIN
                         dbo.Item_Brand AS b ON s.item_Brand = b.itm_code LEFT OUTER JOIN
                         dbo.Item_UOM AS iu ON s.Item_UOM = iu.UOM_Code
WHERE        (r.isProduct = 1)  and (r.itm_status = 1) AND (d.itm_status = 1) AND (b.itm_status = 1) AND (c.itm_isactive = 1) and s.Item_Div in (1,2) and (s.item_isactive = 1)


GO
IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[LISTTABLE]')AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].LISTTABLE

GO 

CREATE FUNCTION [dbo].LISTTABLE ( @StringInput VARCHAR(8000), @Delimiter nvarchar(1))
RETURNS @OutputTable TABLE ( Item VARCHAR(MAX) )
AS
BEGIN

    DECLARE @String    VARCHAR(MAX)

    WHILE LEN(@StringInput) > 0
    BEGIN
        SET @String      = LEFT(@StringInput, 
                                ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput) - 1, -1),
                                LEN(@StringInput)))
        SET @StringInput = SUBSTRING(@StringInput,
                                     ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput), 0),
                                     LEN(@StringInput)) + 1, LEN(@StringInput))

        INSERT INTO @OutputTable ( Item )
        VALUES ( @String )
    END

    RETURN
END

GO
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME LIKE 'WebInventory_StockBalanceReport')
BEGIN
DROP PROCEDURE WebInventory_StockBalanceReport
END
GO
CREATE PROCEDURE [dbo].WebInventory_StockBalanceReport	
	@TDate Varchar(10),
	@Site nvarchar(255),	
	@Dept nvarchar(255),
	@Range nvarchar(255),	
	@Brand nvarchar(255),
	@FItem nvarchar(255),
	@TItem nvarchar(255),
	@ShowInactive nvarchar(1),
	@ShowZeroQty nvarchar(1)
AS
BEGIN

    Select * from (
    SELECT Stktrn_2.STORE_NO [Outlet],Stktrn_2.ITEMCODE [ItemCode],Stock.Item_Name [ItemName],
	--ITEM_UOMPRICE.ITEM_UOM [UOM],
	ITEM_BATCH.UOM [UOM],
	--ITEM_UOMPRICE.ITEM_PRICE [Cost], 
	ITEM_BATCH.BATCH_COST  [Cost],
	--Stktrn_2.TRN_BALCST [Cost],
	--Stktrn_2.TRN_BALQTY [Qty],
	ITEM_BATCH.QTY [Qty],
	DENSE_RANK () OVER(PARTITION BY Stktrn_2.STORE_NO,Stktrn_2.ITEMCODE,Stktrn_2.Item_UOM ORDER BY Stktrn_2.ID DESC) AS RankRank,
	Item_Dept.itm_desc as Dept ,Item_Brand.itm_desc as Brand,Item_Range.itm_desc as Ranges
    FROM item_Class 
	INNER JOIN Stock 
	INNER JOIN Item_StockList ON Stock.item_code = Item_StockList.Item_Code  
	INNER JOIN Item_Div ON Stock.Item_Div = Item_Div.itm_code 
	INNER JOIN Item_Dept ON Stock.Item_Dept = Item_Dept.itm_code ON item_Class.itm_code = Stock.Item_Class 
	INNER JOIN Item_Brand ON Stock.item_Brand = Item_Brand.itm_code 
	LEFT OUTER JOIN Item_Range ON Stock.Item_Range = Item_Range.itm_code 
	LEFT OUTER JOIN ITEM_BATCH ON Item_StockList.ItemSite_Code = ITEM_BATCH.SITE_CODE AND Item_StockList.Item_Code = ITEM_BATCH.ITEM_CODE 
	LEFT JOIN ITEM_UOMPRICE ON ITEM_BATCH.UOM = ITEM_UOMPRICE.ITEM_UOM AND ITEM_BATCH.ITEM_CODE = ITEM_UOMPRICE.ITEM_CODE 
	INNER JOIN Stktrn AS Stktrn_2 ON ITEM_BATCH.ITEM_CODE+ '0000' = Stktrn_2.ITEMCODE and ITEM_BATCH.SITE_CODE=Stktrn_2.STORE_NO and ITEM_BATCH.UOM=Stktrn_2.Item_UOM   
	RIGHT OUTER JOIN Item_SiteList ON Stktrn_2.STORE_NO = Item_SiteList.ItemSite_Code AND ITEM_BATCH.SITE_CODE = Item_SiteList.ItemSite_Code  
	Where ISNULL(Stktrn_2.ITEMCODE,'')<>'' 
	And  Stktrn_2.Trn_Post <=Convert(Datetime,@TDate,103) --Date
	--And ((@FItem='Select') OR Stock.item_desc >= @FItem) AND ((@TItem='Select') OR  Stock.item_desc <= @TItem) --Item
	And ((@FItem='') OR ((@FItem<>'') And Stock.item_desc In (Select Item From dbo.LISTTABLE(@FItem,',')))) --Item
	And ((@Site='') OR ((@Site<>'') And Stktrn_2.store_no In (Select Item From dbo.LISTTABLE(@Site,',')))) --Site
	And ((@Dept='') OR ((@Dept<>'') And item_dept.itm_code In (Select Item From dbo.LISTTABLE(@Dept,',')))) --Dept
	And ((@Brand='') OR ((@Brand<>'') And item_Brand.itm_code In (Select Item From dbo.LISTTABLE(@Brand,',')))) --Brand
	And ((@Range='') OR ((@Range<>'') And item_Class.itm_code In (Select Item From dbo.LISTTABLE(@Range,',')))) --Range
		
	And ((@ShowInactive='Y') OR Stock.Item_Isactive =1) 
	And Stock.Item_Div Between '1' And  '2'
	And Item_SiteList.ItemSite_Isactive = 'True'
	--And ITEM_UOMPRICE.IsActive = 'True'
	)X Where X.RankRank=1
	And ((@ShowZeroQty='Y') OR X.Qty<>0) 
	
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblStockBalanceDay]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblStockBalanceDay](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SA_DATE] [datetime] NULL,
	[ITEM_CODE] [nvarchar](40) NULL,
	[UOM] [nvarchar](40) NULL,
	[ItemSite_Code] [nvarchar](40) NULL,
	[ONHAND_QTY] [float] NULL,
	[Time] [datetime] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [dbo].[tblStockBalanceDay] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME LIKE 'postTblStockBalanceDay')
BEGIN
DROP PROCEDURE postTblStockBalanceDay
END
GO
CREATE PROCEDURE [dbo].postTblStockBalanceDay
@saDate NVARCHAR(80),
@itemCode NVARCHAR(80),
@uom NVARCHAR(80),
@itemsiteCode NVARCHAR(80),
@onhandQty int
AS 
BEGIN

	update item_batch set Qty=Qty+@onhandQty where item_CODE+'0000'=@itemCode and SITE_CODE=@itemsiteCode and UOM=@uom
	
	DECLARE @DAILYCOUNT INT
	SET @DAILYCOUNT =(SELECT COUNT(*) FROM tblStockBalanceDay WHERE CAST(SA_DATE as date) = @saDate AND ItemSite_Code=@itemsiteCode and ITEM_CODE=@itemCode )
	IF @DAILYCOUNT=0
		BEGIN
			DECLARE @PREVDAYQTY INT
			SET @PREVDAYQTY=(SELECT ISNULL(ONHAND_QTY,0) FROM tblStockBalanceDay WHERE SA_DATE=(SELECT MAX(SA_DATE) FROM tblStockBalanceDay ) AND ItemSite_Code=@itemsiteCode and ITEM_CODE=@itemCode)
			INSERT INTO tblStockBalanceDay (SA_DATE,ITEM_CODE,UOM,ItemSite_Code,ONHAND_QTY,Time) values
			( CONVERT (DATE, @saDate),@itemCode,@uom,@itemsiteCode, @PREVDAYQTY+@onhandQty,getdate())
		END 
	ELSE
		BEGIN
			UPDATE tblStockBalanceDay  SET  ONHAND_QTY = ONHAND_QTY+ @onhandQty  ,time = getdate()  
			WHERE  CAST(SA_DATE as date) = convert(date,@saDate) AND ITEM_CODE = @itemCode AND  ItemSite_Code=@itemsiteCode
		END

	SET NOCOUNT ON;
	select '1'
END

GO
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME LIKE 'ITEM_SEARCH')
BEGIN
DROP PROCEDURE ITEM_SEARCH
END
GO
CREATE PROCEDURE [dbo].ITEM_SEARCH
@Sitecode nvarchar(60)
as
SELECT s.item_code AS stockCode, s.Item_Name AS stockName, s.Item_Type AS Type, s.item_isactive AS isActive, iu.UOM_Code AS uom, iu.UOM_Desc AS uomDescription, 
--s.ONHAND_QTY AS quantity, 
IB.QTY AS quantity, 
(CASE s.Item_Div WHEN 1 THEN 'Retail Product' WHEN 2 THEN 'Salon Product' WHEN 3 THEN 'Service' WHEN 4 THEN 'Voucher' WHEN 5 THEN 'Prepaid' ELSE 'invalid Division' END) AS Division, 
r.itm_code AS RangeCode, r.itm_desc AS Range, d.itm_code AS DeptCode, d.itm_desc AS Department, c.itm_code AS ClassCode, c.itm_desc AS Class, b.itm_code AS BrandCode, 
b.itm_desc AS Brand, l.LINK_CODE AS linkCode, 
--s.Item_Price as Price, 
isnull(IB.BATCH_COST,0) as Price, 
isnull(s.MOQQty,0)  as MOQQty
--0 as MOQQty
FROM            dbo.Stock AS s 
INNER JOIN dbo.Item_Batch AS IB ON s.item_code = IB.ITEM_CODE 
LEFT OUTER JOIN dbo.Item_Link AS l ON s.item_code = l.ITEM_CODE AND l.LINK_TYPE = 'L' AND l.Itm_IsActive = 1 
RIGHT OUTER JOIN dbo.Item_Range AS r ON s.Item_Range = r.itm_code 
RIGHT OUTER JOIN dbo.Item_Dept AS d ON s.Item_Dept = d.itm_code 
RIGHT OUTER JOIN dbo.item_Class AS c ON s.Item_Class = c.itm_code 
RIGHT OUTER JOIN dbo.Item_Brand AS b ON s.item_Brand = b.itm_code 
--LEFT OUTER JOIN dbo.Item_UOM AS iu ON IB.UOM = iu.UOM_Code
LEFT OUTER JOIN dbo.Item_UOM AS iu ON s.Item_UOM = iu.UOM_Code
WHERE        (r.isProduct = 1)  and (r.itm_status = 1) AND (d.itm_status = 1) AND (b.itm_status = 1) AND (c.itm_isactive = 1) and s.Item_Div in (1,2)
and (s.item_isactive = 1)
and IB.SITE_CODE=@Sitecode and IB.UOM<>'' --and  isnull(iu.UOM_Code,'')<>''

GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'STKPrintList')
BEGIN
DROP VIEW [STKPrintList]
END
GO
CREATE VIEW [dbo].[STKPrintList]
AS
select Stk_Movdoc_Dtl.Doc_no,Stk_Movdoc_Hdr.SUPPLY_NO,Item_Supply.SUPPLYDESC,convert(varchar,Stk_Movdoc_Dtl.DOC_DATE,103) as DOC_DATE,
isnull(IS1.ItemSite_Desc,'') as FromSite,isnull(IS2.ItemSite_Desc,'') as ToSite,
Stk_Movdoc_Hdr.DOC_REF1,Stk_Movdoc_Hdr.DOC_REF2,
--Stk_Movdoc_Hdr.DOC_ATTN,
employee.emp_name as DOC_ATTN,
Stk_Movdoc_Hdr.DOC_REMK1,
Stk_Movdoc_Dtl.DOC_LINENO,Stk_Movdoc_Dtl.ITEMCODE,Stk_Movdoc_Dtl.ITEMDESC,Stk_Movdoc_Dtl.DOC_QTY,
round(Stk_Movdoc_Dtl.DOC_PRICE,2) as DOC_PRICE,
round(Stk_Movdoc_Dtl.DOC_AMT,2) as DOC_AMT,
Stk_Movdoc_Dtl.DOCUOMDesc,Stk_Movdoc_Dtl.itmBrandDesc,Stk_Movdoc_Dtl.itmRangeDesc,Stk_Movdoc_Hdr.STORE_NO
from Stk_Movdoc_Hdr 
inner join Stk_Movdoc_Dtl on Stk_Movdoc_Hdr.Doc_no=Stk_Movdoc_Dtl.Doc_no
left join Item_Supply on Stk_Movdoc_Hdr.SUPPLY_NO=Item_Supply.SPLY_CODE
left join Item_SiteList as IS1 on IS1.ItemSite_Code=Stk_Movdoc_Hdr.FSTORE_NO
left join Item_SiteList as IS2 on IS2.ItemSite_Code=Stk_Movdoc_Hdr.TSTORE_NO
left join employee on Stk_Movdoc_Hdr.STAFF_NO=employee.emp_code

GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'ITEMONQTY')
BEGIN
DROP VIEW [ITEMONQTY]
END
GO
CREATE VIEW [dbo].[ITEMONQTY]
AS
select distinct item_batch.id,item_batch.ITEM_CODE+'0000' as ITEM_CODE,item_batch.SITE_CODE,item_batch.UOM,item_batch.BATCH_COST ,
isnull(Stktrn.TRN_BALQTY,0) as TRN_BALQTY,isnull(Stktrn.TRN_BALCST,0) as TRN_BALCST
from item_batch
left join Stktrn on  Stktrn.ITEMCODE=item_batch.item_code+'0000' and Stktrn.Item_UOM=item_batch.UOM and Stktrn.STORE_NO=item_batch.SITE_CODE
and Stktrn.ID=(select max(id) from Stktrn as Stktrn1 where Stktrn1.STORE_NO=item_batch.SITE_CODE and 
Stktrn1.ITEMCODE=item_batch.ITEM_CODE+'0000' and Stktrn1.Item_UOM=item_batch.UOM )
where item_batch.ITEM_CODE<>''
