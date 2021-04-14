IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POV]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POV](
[POV_ID] [int] IDENTITY(1,1) NOT NULL,
[POV_NO] [nvarchar](20) NULL,
[ItemSite_Code] [nvarchar](10) NULL,
[SUPP_Code] [nvarchar](10) NULL,
[POV_REF] [nvarchar](20) NULL,
[POV_User] [nvarchar](10) NULL,
[POV_DATE] [smalldatetime] NULL,
[POV_STATUS] [nvarchar](50) NULL,
[POV_TTQTY] [float] NULL,
[POV_TTFOC] [float] NULL,
[POV_TTDISC] [float] NULL,
[POV_TTAMT] [float] NULL,
[POV_ATTN] [nvarchar](30) NULL,
[POV_REMK1] [nvarchar](50) NULL,
[POV_REMK2] [nvarchar](50) NULL,
[POV_BNAME] [nvarchar](40) NULL,
[POV_BADDR1] [nvarchar](30) NULL,
[POV_BADDR2] [nvarchar](30) NULL,
[POV_BADDR3] [nvarchar](30) NULL,
[POV_BPOSTCODE] [nvarchar](8) NULL,
[POV_BSTATE] [nvarchar](15) NULL,
[POV_BCITY] [nvarchar](10) NULL,
[POV_BCOUNTRY] [nvarchar](10) NULL,
[POV_DADDR1] [nvarchar](30) NULL,
[POV_DADDR2] [nvarchar](30) NULL,
[POV_DADDR3] [nvarchar](30) NULL,
[POV_DPOSTCODE] [nvarchar](8) NULL,
[POV_DSTATE] [nvarchar](15) NULL,
[POV_DCITY] [nvarchar](15) NULL,
[POV_DCOUNTRY] [nvarchar](20) NULL,
[POV_CANCELQTY] [float] NULL,
[POV_RECSTATUS] [nvarchar](10) NULL,
[POV_RECEXPECT] [smalldatetime] NULL,
[POV_RECTTL] [float] NULL,
[Sync_GUID] [uniqueidentifier] NOT NULL,
[Sync_ClientIndex] [int] NULL,
[Sync_LstUpd] [datetime] NULL,
[Sync_ClientIndexString] [nvarchar](max) NULL,
[POV_TIME] [smalldatetime] NULL,
[POVAPP_NO] [nvarchar](40) NULL,
[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[POV] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV' AND COLUMN_NAME = 'PO_TIME')
BEGIN
ALTER TABLE [dbo].[POV] ADD  DEFAULT (getdate()) FOR [POV_TIME]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POV_DETAIL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POV_DETAIL](
[POV_ID] [int] IDENTITY(1,1) NOT NULL,
[ITEMSITE_CODE] [nvarchar](10) NULL,
[STATUS] [nvarchar](10) NULL,
[POVD_ITEMCODE] [nvarchar](20) NULL,
[POVD_ITEMDESC] [nvarchar](max) NULL,
[POVD_ITEMPRICE] [float] NULL,
[POVD_QTY] [int] NULL,
[POVD_FOCQTY] [int] NULL,
[POVD_TTLQTY] [int] NULL,
[POVD_PRICE] [float] NULL,
[POVD_DISCPER] [float] NULL,
[POVD_DISCAMT] [float] NULL,
[POVD_AMT] [float] NULL,
[POVD_RECQTY] [int] NULL,
[POVD_CANCELQTY] [int] NULL,
[POVD_OUTQTY] [int] NULL,
[POVD_DATE] [smalldatetime] NULL,
[POVD_TIME] [smalldatetime] NULL,
[Sync_GUID] [uniqueidentifier] NOT NULL,
[Sync_ClientIndex] [int] NULL,
[Sync_LstUpd] [datetime] NULL,
[Sync_ClientIndexString] [nvarchar](max) NULL,
[BrandCode] [nvarchar](15) NULL,
[BrandName] [nvarchar](30) NULL,
[LineNumber] [int] NOT NULL,
[POV_No] [nvarchar](20) NULL,
[PostStatus] [bit] NULL,
[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'BrandCode')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [BrandCode]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'BrandName')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [BrandName]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'LineNumber')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ((0)) FOR [LineNumber]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'POV_No')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [POV_No]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'PostStatus')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ((0)) FOR [PostStatus]
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POV_Approval]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POV_Approval](
	[POVAPP_ID] [int] IDENTITY(1,1) NOT NULL,
	[POV_No] [nvarchar](200) NULL,
	[GRN_No] [nvarchar](200) NULL,
	[ITEMSITE_CODE] [nvarchar](10) NULL,
	[STATUS] [nvarchar](10) NULL,
	[POVAPP_ITEMCODE] [nvarchar](20) NULL,
	[POVAPP_ITEMDESC] [nvarchar](max) NULL,
	[POVAPP_ITEMPRICE] [float] NULL,
	[POVAPP_QTY] [int] NULL,
	[POVAPP_TTLQTY] [int] NULL,
	[POVAPP_AMT] [float] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL,
	[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[POV_Approval]' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[POV_Approval] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedPOVList')
BEGIN
DROP VIEW [approvedPOVList]
END
GO
CREATE VIEW [dbo].[approvedPOVList]
AS
SELECT        TOP (100) PERCENT dbo.Stk_Movdoc_Hdr.DOC_NO AS GRNNo, dbo.Stk_Movdoc_Hdr.PO_ID, 
dbo.POV.POV_NO AS poNumber, dbo.POV.ItemSite_Code AS siteCode, 
dbo.POV.SUPP_Code AS supplierCode,dbo.POV.POV_REMK1 AS poRemark, dbo.POV.POV_DATE AS poDate, dbo.POV.POV_TIME AS poTime ,
(CASE WHEN isnull(Stk_Movdoc_Hdr.PO_NO, '') = '' THEN POV.POV_STATUS ELSE 'Approved' END)AS poStatus, 
dbo.POV.POV_TTQTY AS poTotalQty, ISNULL(dbo.Stk_Movdoc_Hdr.DOC_QTY, 0) AS APPQTY, dbo.POV.POV_BPOSTCODE AS postCode, dbo.POV.POV_ATTN AS supplier
FROM            dbo.POV
LEFT OUTER JOIN dbo.Stk_Movdoc_Hdr ON dbo.POV.POV_NO = dbo.Stk_Movdoc_Hdr.PO_NO
WHERE        (dbo.POV.POV_STATUS <> '')
ORDER BY DOC_DATE DESC
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'POVDetailsList')
BEGIN
DROP VIEW [POVDetailsList]
END
GO
CREATE VIEW [dbo].[POVDetailsList]
AS
SELECT POV_detail.POV_ID as poId,POV_detail.POV_No as poNo,POV_detail.LineNumber,POV_detail.POVD_ITEMCODE,POV_detail.POVD_ITEMDESC,
round(POV_detail.POVD_ITEMPRICE,2) as POD_ITEMPRICE,
POV_detail.POVD_QTY,round((POV_detail.POVD_ITEMPRICE * POV_detail.POVD_QTY),2) as POD_PRICE,
item_UOM.UOM_Desc as docUom,item_UOM.UOM_Desc as DOCUOMDesc,stock.item_Brand as itmBrand,item_BRAND.itm_desc as brandname,stock.Item_Range as itmRange,
item_range.itm_desc as itmRangeDesc from   dbo.POV_detail
LEFT OUTER JOIN dbo.stock  ON dbo.POV_detail.POVD_ITEMCODE = dbo.stock.item_code
LEFT OUTER JOIN dbo.item_UOM  ON dbo.item_UOM.UOM_Desc = dbo.POV_detail.BrandCode
LEFT OUTER JOIN dbo.item_BRAND  ON dbo.item_BRAND.itm_Code = dbo.stock.item_Brand
LEFT OUTER JOIN dbo.item_range  ON dbo.item_range.itm_Code = dbo.stock.Item_Range

GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedOutletPOVList')
BEGIN
DROP VIEW [approvedOutletPOVList]
END
GO
CREATE VIEW [dbo].[approvedOutletPOVList]
as
select POV.poV_ID as id,POV.poV_no,POV.ItemSite_Code AS siteCode,POV.SUPP_Code AS supplierCode,POV.POV_REMK1 AS poRemark, POV.POV_DATE AS poDate,POV.POV_TIME AS poTime,'Approved' as poStatus,
POV.POV_TTQTY AS poTotalQty,item_supply.SUPPLYDESC,sum(POV_Approval.POVAPP_QTY) as APPQTY
from POV
inner join item_supply on dbo.POV.SUPP_Code = dbo.item_supply.SPLY_CODE
inner join POV_Approval on dbo.POV.POV_NO = dbo.POV_Approval.POV_NO
group by POV.poV_ID ,POV.poV_no,POV.ItemSite_Code,POV.SUPP_Code ,POV.POV_REMK1 , POV.POV_DATE ,POV.POV_TIME ,POV.POV_TTQTY ,item_supply.SUPPLYDESC

GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'approvedOutletPOVDetailList')
BEGIN
DROP VIEW [approvedOutletPOVDetailList]
END
GO
CREATE VIEW [dbo].[approvedOutletPOVDetailList]
as
select POV.POV_ID as id,POV_Approval.POV_NO,POV_detail.LineNumber,POV_detail.POVD_ITEMCODE,POV_detail.POVD_ITEMDESC,POV_detail.BrandName,
--PO_detail.POD_ITEMPRICE,
POV_Approval.POVAPP_ITEMPRICE as POD_ITEMPRICE,
POV_detail.POVD_DISCPER,
POV_detail.POVD_DISCAMT,POV_detail.POVD_QTY,POV_Approval.POVAPP_QTY
from POV
inner join  POV_detail on POV.POV_NO=POV_detail.POV_No
inner join item_supply on dbo.POV.SUPP_Code = dbo.item_supply.SPLY_CODE
inner join POV_Approval on dbo.POV.POV_NO = dbo.POV_Approval.POV_NO and POV_detail.POVD_ITEMCODE=POV_Approval.POVAPP_ITEMCODE
--order by PO_Approval.PO_NO,PO_detail.LineNumber

GO

IF EXISTS(SELECT * FROM sys.views WHERE NAME LIKE 'POVPrintList')
BEGIN
DROP VIEW [POVPrintList]
END
GO
CREATE VIEW [dbo].[POVPrintList]
AS
select poV.POV_NO,poV.SUPP_Code,Item_Supply.SUPPLYDESC,convert(varchar,POV.poV_date,103) as po_date,POV.contactPerson,poV.terms,
POV_DETAIL.POVD_QTY,stock.Item_UOM,Stock.item_code,Stock.Item_Name,
round(POV_DETAIL.POVD_PRICE,2) as POD_PRICE,
round((POV_DETAIL.POVD_QTY * POV_DETAIL.POVD_PRICE),2) as TOTAL,POV.ItemSite_Code
from poV 
inner join POV_DETAIL on poV.POV_NO=POV_DETAIL.POV_No
inner join stock on stock.item_code=POV_DETAIL.POVD_ITEMCODE
inner join Item_Supply on poV.SUPP_Code=Item_Supply.SPLY_CODE

Go



select *from  POV_DETAIL
Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[POVPrintList]
AS
select poV.POV_NO,poV.SUPP_Code,Item_Supply.SUPPLYDESC,convert(varchar,POV.poV_date,103) as po_date,POV.contactPerson,poV.terms,
POV_DETAIL.POVD_QTY,stock.Item_UOM,Stock.item_code,Stock.Item_Name,
round(POV_DETAIL.POVD_PRICE,2) as POD_PRICE,
round((POV_DETAIL.POVD_QTY * POV_DETAIL.POVD_PRICE),2) as TOTAL,POV.ItemSite_Code
from poV 
inner join POV_DETAIL on poV.POV_NO=POV_DETAIL.POV_No
inner join stock on stock.item_code=POV_DETAIL.POVD_ITEMCODE
inner join Item_Supply on poV.SUPP_Code=Item_Supply.SPLY_CODE



alter VIEW [dbo].[POPrintList]
AS
select po.PO_NO,po.SUPP_Code,Item_Supply.SUPPLYDESC,convert(varchar,PO.po_date,103) as po_date,PO.contactPerson,po.terms,
PO_DETAIL.POD_QTY,stock.Item_UOM,Stock.item_code,Stock.Item_Name,
round(PO_DETAIL.POD_PRICE,2) as POD_PRICE,
round((PO_DETAIL.POD_QTY * PO_DETAIL.POD_PRICE),2) as TOTAL,po.ItemSite_Code
from po 
inner join PO_DETAIL on po.PO_NO=PO_DETAIL.PO_No
inner join stock on stock.item_code=PO_DETAIL.POD_ITEMCODE
inner join Item_Supply on po.SUPP_Code=Item_Supply.SPLY_CODE`

select * from POVDetailsList
alter VIEW [dbo].[POVDetailsList]
AS
SELECT POV_detail.POV_ID ,POV_detail.POV_No as poNo,POV_detail.LineNumber,POV_detail.POVD_ITEMCODE,POV_detail.POVD_ITEMDESC,
round(POV_detail.POVD_ITEMPRICE,2) as POVD_ITEMPRICE,
POV_detail.POVD_QTY,round((POV_detail.POVD_ITEMPRICE * POV_detail.POVD_QTY),2) as POD_PRICE,
item_UOM.UOM_Desc as docUom,item_UOM.UOM_Desc as DOCUOMDesc,stock.item_Brand as itmBrand,item_BRAND.itm_desc as brandname,stock.Item_Range as itmRange,
item_range.itm_desc as itmRangeDesc from   dbo.POV_detail
LEFT OUTER JOIN dbo.stock  ON dbo.POV_detail.POVD_ITEMCODE = dbo.stock.item_code
LEFT OUTER JOIN dbo.item_UOM  ON dbo.item_UOM.UOM_Desc = dbo.POV_detail.BrandCode
LEFT OUTER JOIN dbo.item_BRAND  ON dbo.item_BRAND.itm_Code = dbo.stock.item_Brand
LEFT OUTER JOIN dbo.item_range  ON dbo.item_range.itm_Code = dbo.stock.Item_Range


Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[approvedPOVList]
AS
SELECT        TOP (100) PERCENT dbo.Stk_Movdoc_Hdr.DOC_NO AS GRNNo, dbo.Stk_Movdoc_Hdr.PO_ID, 
dbo.POV.POV_NO AS poNumber, dbo.POV.ItemSite_Code AS siteCode, 
dbo.POV.SUPP_Code AS supplierCode,dbo.POV.POV_REMK1 AS poRemark, dbo.POV.POV_DATE AS poDate, dbo.POV.POV_TIME AS poTime ,
(CASE WHEN isnull(Stk_Movdoc_Hdr.PO_NO, '') = '' THEN POV.POV_STATUS ELSE 'Approved' END)AS poStatus, 
dbo.POV.POV_TTQTY AS poTotalQty, ISNULL(dbo.Stk_Movdoc_Hdr.DOC_QTY, 0) AS APPQTY, dbo.POV.POV_BPOSTCODE AS postCode, dbo.POV.POV_ATTN AS supplier
FROM            dbo.POV
LEFT OUTER JOIN dbo.Stk_Movdoc_Hdr ON dbo.POV.POV_NO = dbo.Stk_Movdoc_Hdr.PO_NO
WHERE        (dbo.POV.POV_STATUS <> '')
ORDER BY DOC_DATE DESC


Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alter VIEW [dbo].[approvedOutletPOVDetailList]
as
select POV.POV_ID ,POV_Approval.POV_NO,POV_detail.LineNumber,POV_detail.POVD_ITEMCODE,POV_detail.POVD_ITEMDESC,POV_detail.BrandName,
--PO_detail.POD_ITEMPRICE,
POV_Approval.POVAPP_ITEMPRICE as POD_ITEMPRICE,
POV_detail.POVD_DISCPER,
POV_detail.POVD_DISCAMT,POV_detail.POVD_QTY,POV_Approval.POVAPP_QTY
from POV
inner join  POV_detail on POV.POV_NO=POV_detail.POV_No
inner join item_supply on dbo.POV.SUPP_Code = dbo.item_supply.SPLY_CODE
inner join POV_Approval on dbo.POV.POV_NO = dbo.POV_Approval.POV_NO and POV_detail.POVD_ITEMCODE=POV_Approval.POVAPP_ITEMCODE
--order by PO_Approval.PO_NO,PO_detail.LineNumber

select * from POV
delete from POV_detail where pov_id=1
select * from POV_detail 
select * from control_no
--update POV_detail set POV_No='WPOAWHQ110002' where POV_No is null


ALTER TABLE [dbo].[POV] ADD  DEFAULT (newid()) FOR [Sync_GUID]
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT (newid()) FOR [Sync_GUID]

ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [BrandCode]
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [BrandName]
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ((0)) FOR [LineNumber]
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [POV_No]
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ((0)) FOR [PostStatus]

insert into POV_detail (ITEMSITE_CODE,STATUS,POVD_ITEMCODE,POVD_ITEMDESC,POVD_ITEMPRICE,POVD_QTY,POVD_FOCQTY,POVD_TTLQTY,POVD_PRICE,POVD_DISCPER,POVD_DISCAMT,
POVD_AMT,POVD_RECQTY,POVD_CANCELQTY,POVD_OUTQTY,POVD_DATE,POVD_TIME,
BrandCode,BrandName,LineNumber,POV_No,PostStatus)values
('AWHQ','Open','13100007','Tired Legs Gel',10,10,0,10,10,10,0,10,10,0,10,'2021/03/29','05:45','','',1,'WPOAWHQ110001','')



select * from [approvedOutletPOVList]
CREATE VIEW [dbo].[approvedOutletPOVList]
as
select POV.poV_ID as id,POV.poV_no,POV.ItemSite_Code AS siteCode,POV.SUPP_Code AS supplierCode,POV.POV_REMK1 AS poRemark, POV.POV_DATE AS poDate,POV.POV_TIME AS poTime,'Approved' as poStatus,
POV.POV_TTQTY AS poTotalQty,item_supply.SUPPLYDESC,sum(POV_Approval.POVAPP_QTY) as APPQTY
from POV
inner join item_supply on dbo.POV.SUPP_Code = dbo.item_supply.SPLY_CODE
inner join POV_Approval on dbo.POV.POV_NO = dbo.POV_Approval.POV_NO
group by POV.poV_ID ,POV.poV_no,POV.ItemSite_Code,POV.SUPP_Code ,POV.POV_REMK1 , POV.POV_DATE ,POV.POV_TIME ,POV.POV_TTQTY ,item_supply.SUPPLYDESC



select * from [approvedPOVList]
ALTER VIEW [dbo].[approvedPOVList]
AS
SELECT        TOP (100) PERCENT dbo.Stk_Movdoc_Hdr.DOC_NO AS GRNNo, dbo.Stk_Movdoc_Hdr.PO_ID, 
dbo.POV.POV_NO AS poNumber, dbo.POV.ItemSite_Code AS siteCode, 
dbo.POV.SUPP_Code AS supplierCode,dbo.POV.POV_REMK1 AS poRemark, dbo.POV.POV_DATE AS poDate, dbo.POV.POV_TIME AS poTime ,
(CASE WHEN isnull(Stk_Movdoc_Hdr.PO_NO, '') = '' THEN POV.POV_STATUS ELSE 'Approved' END)AS poStatus, 
dbo.POV.POV_TTQTY AS poTotalQty, ISNULL(dbo.Stk_Movdoc_Hdr.DOC_QTY, 0) AS APPQTY, dbo.POV.POV_BPOSTCODE AS postCode, dbo.POV.POV_ATTN AS supplier
FROM            dbo.POV
INNER JOIN dbo.Stk_Movdoc_Hdr ON dbo.POV.POV_NO = dbo.Stk_Movdoc_Hdr.PO_NO
WHERE        (dbo.POV.POV_STATUS <> '')
ORDER BY DOC_DATE DESC


POV - Table
POV_DETAIL  - Table
POV_Approval - Table
approvedPOVList - View
POVDetailsList - View
approvedOutletPOVList - View
approvedOutletPOVDetailList - View
POVPrintList - View

alter table POV
add contactPerson nvarchar(200)
GO

alter table POV
add terms nvarchar(200)


select * from po

approvedGRNlists
PODetailsLists
approvedOutletPOLists
approvedOutletPODetailListS

POVendorApprovedListMaster


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


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POV]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POV](
[POV_ID] [int] IDENTITY(1,1) NOT NULL,
[POV_NO] [nvarchar](20) NULL,
[ItemSite_Code] [nvarchar](10) NULL,
[SUPP_Code] [nvarchar](10) NULL,
[POV_REF] [nvarchar](20) NULL,
[POV_User] [nvarchar](10) NULL,
[POV_DATE] [smalldatetime] NULL,
[POV_STATUS] [nvarchar](50) NULL,
[POV_TTQTY] [float] NULL,
[POV_TTFOC] [float] NULL,
[POV_TTDISC] [float] NULL,
[POV_TTAMT] [float] NULL,
[POV_ATTN] [nvarchar](30) NULL,
[POV_REMK1] [nvarchar](50) NULL,
[POV_REMK2] [nvarchar](50) NULL,
[POV_BNAME] [nvarchar](40) NULL,
[POV_BADDR1] [nvarchar](30) NULL,
[POV_BADDR2] [nvarchar](30) NULL,
[POV_BADDR3] [nvarchar](30) NULL,
[POV_BPOSTCODE] [nvarchar](8) NULL,
[POV_BSTATE] [nvarchar](15) NULL,
[POV_BCITY] [nvarchar](10) NULL,
[POV_BCOUNTRY] [nvarchar](10) NULL,
[POV_DADDR1] [nvarchar](30) NULL,
[POV_DADDR2] [nvarchar](30) NULL,
[POV_DADDR3] [nvarchar](30) NULL,
[POV_DPOSTCODE] [nvarchar](8) NULL,
[POV_DSTATE] [nvarchar](15) NULL,
[POV_DCITY] [nvarchar](15) NULL,
[POV_DCOUNTRY] [nvarchar](20) NULL,
[POV_CANCELQTY] [float] NULL,
[POV_RECSTATUS] [nvarchar](10) NULL,
[POV_RECEXPECT] [smalldatetime] NULL,
[POV_RECTTL] [float] NULL,
[Sync_GUID] [uniqueidentifier] NOT NULL,
[Sync_ClientIndex] [int] NULL,
[Sync_LstUpd] [datetime] NULL,
[Sync_ClientIndexString] [nvarchar](max) NULL,
[POV_TIME] [smalldatetime] NULL,
[POVAPP_NO] [nvarchar](40) NULL,
[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[POV] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV' AND COLUMN_NAME = 'PO_TIME')
BEGIN
ALTER TABLE [dbo].[POV] ADD  DEFAULT (getdate()) FOR [POV_TIME]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POV_DETAIL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POV_DETAIL](
[POV_ID] [int] IDENTITY(1,1) NOT NULL,
[ITEMSITE_CODE] [nvarchar](10) NULL,
[STATUS] [nvarchar](10) NULL,
[POVD_ITEMCODE] [nvarchar](20) NULL,
[POVD_ITEMDESC] [nvarchar](max) NULL,
[POVD_ITEMPRICE] [float] NULL,
[POVD_QTY] [int] NULL,
[POVD_FOCQTY] [int] NULL,
[POVD_TTLQTY] [int] NULL,
[POVD_PRICE] [float] NULL,
[POVD_DISCPER] [float] NULL,
[POVD_DISCAMT] [float] NULL,
[POVD_AMT] [float] NULL,
[POVD_RECQTY] [int] NULL,
[POVD_CANCELQTY] [int] NULL,
[POVD_OUTQTY] [int] NULL,
[POVD_DATE] [smalldatetime] NULL,
[POVD_TIME] [smalldatetime] NULL,
[Sync_GUID] [uniqueidentifier] NOT NULL,
[Sync_ClientIndex] [int] NULL,
[Sync_LstUpd] [datetime] NULL,
[Sync_ClientIndexString] [nvarchar](max) NULL,
[BrandCode] [nvarchar](15) NULL,
[BrandName] [nvarchar](30) NULL,
[LineNumber] [int] NOT NULL,
[POVApp_No] [nvarchar](20) NULL,
[PostStatus] [bit] NULL,
[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'BrandCode')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [BrandCode]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'BrandName')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [BrandName]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'LineNumber')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ((0)) FOR [LineNumber]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'POV_No')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ('') FOR [POV_No]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'POV_DETAIL' AND COLUMN_NAME = 'PostStatus')
BEGIN
ALTER TABLE [dbo].[POV_DETAIL] ADD  DEFAULT ((0)) FOR [PostStatus]
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POV_Approval]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POV_Approval](
	[POVAPP_ID] [int] IDENTITY(1,1) NOT NULL,
	[POV_No] [nvarchar](200) NULL,
	[GRN_No] [nvarchar](200) NULL,
	[ITEMSITE_CODE] [nvarchar](10) NULL,
	[STATUS] [nvarchar](10) NULL,
	[POVAPP_ITEMCODE] [nvarchar](20) NULL,
	[POVAPP_ITEMDESC] [nvarchar](max) NULL,
	[POVAPP_ITEMPRICE] [float] NULL,
	[POVAPP_QTY] [int] NULL,
	[POVAPP_TTLQTY] [int] NULL,
	[POVAPP_AMT] [float] NULL,
	[Sync_GUID] [uniqueidentifier] NOT NULL,
	[Sync_ClientIndex] [int] NULL,
	[Sync_LstUpd] [datetime] NULL,
	[Sync_ClientIndexString] [nvarchar](max) NULL,
	[Sync_Key] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = '[POV_Approval]' AND COLUMN_NAME = 'Sync_GUID')
BEGIN
ALTER TABLE [dbo].[PO_Approval] ADD  DEFAULT (newid()) FOR [Sync_GUID]
END