--select * from Control_no where control_description ='STOCK CODE' 



--select max(item_code) from stock





--update Control_no set control_no= (select max(itm_code)+1 from item_div) where control_description='DIV CODE'
--update Control_no set control_no= (select max(itm_code)+1 from item_dept) where control_description='DEPT CODE'
--update Control_no set control_no= (select max(itm_code)+1 from item_class) where control_description='CLASS CODE'
--update Control_no set control_no= (select max(itm_code)+1 from item_Brand) where control_description='BRAND CODE'




--select substring(DOC_NO,8,12) from stk_MovDoc_hdr where Mov_CODE='GRN'  and PO_ID=(select max(PO_ID) from stk_MovDoc_hdr where Mov_CODE='GRN' )


--select * from control_no where control_description='Goods Receive Note'
--update control_no set control_no='100195' where control_description='Goods Receive Note'


insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)
values
('110001','INV','Outlet PO Invoice','2008.05.07','SL01',null)


insert into control_no(control_no,control_prefix,control_description,CONTROLDATE,Site_Code,Mac_Code)
values
('081','V','Supplier Code','2008.05.07','AWHQ',null)

