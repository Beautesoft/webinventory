﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.IO;
using System.Net;
using System.Net.Http;
using Sequoia_BE.Utilities;
using System.Web.Script.Serialization;

namespace Sequoia_BE
{
    public partial class DOrderApproval : System.Web.UI.Page
    {
        #region Declaration
        private string strUserCode = "";
        private string strSiteCode = "";
        private string ControlNo = "";
        private string _PKey = "";
        private string _PKey1 = "";
        private string _PKey2 = "";
        private string recStatus = "";
        private DataTable oDT_General = new DataTable();
        private DataTable oDT_Lead = new DataTable();
        private CommonEngine oCommonEngine = new CommonEngine();
        private DataTable oDT_atStudent = new DataTable();

        public class itemDivInput
        {
            public string itmCode { get; set; }
            public string itmDesc { get; set; }
            public bool itmIsactive { get; set; }
            public string itmSeq { get; set; }
        }

        public class itemDivUpdateInput
        {
            public string itmDesc { get; set; }
            public bool itmIsactive { get; set; }
        }

        public class dosInput
        {
            public string doNo { get; set; }
            public string itemsiteCode { get; set; }
            public string suppCode { get; set; }
            public string doRef { get; set; }
            public string doUser { get; set; }
            public string doDate { get; set; }
            public string doStatus { get; set; }
            public string doTtqty { get; set; }
            public string doTtfoc { get; set; }
            public string doTtdisc { get; set; }
            public string doTtamt { get; set; }
            public string doAttn { get; set; }
            public string doRemk1 { get; set; }
            public string doRemk2 { get; set; }
            public string doBname { get; set; }
            public string doBaddr1 { get; set; }
            public string doBaddr2 { get; set; }
            public string doBaddr3 { get; set; }
            public string doBdostcode { get; set; }
            public string doBstate { get; set; }
            public string doBcity { get; set; }
            public string doBcountry { get; set; }
            public string doDaddr1 { get; set; }
            public string doDaddr2 { get; set; }
            public string doDaddr3 { get; set; }
            public string doDdostcode { get; set; }
            public string doDstate { get; set; }
            public string doDcity { get; set; }
            public string doDcountry { get; set; }
            public string doCancelqty { get; set; }
            public string doRecstatus { get; set; }
            public string doRecexpect { get; set; }
            public string doRecttl { get; set; }
            public string syncGuid { get; set; }
            public string syncClientindex { get; set; }
            public string syncLstupd { get; set; }
            public string syncClientindexstring { get; set; }
            public string doTime { get; set; }
            public string poNo { get; set; }

        }

        public class doDtls
        {
            public string doid { get; set; }
            public string linenumber { get; set; }
            public string dono { get; set; }
            public string doditemcode { get; set; }
            public string doditemdesc { get; set; }
            public string doditemprice { get; set; }
            public string dodqty { get; set; }
            public string dodprice { get; set; }
            public string docuom { get; set; }
            public string docuomdesc { get; set; }
            public string itmbrand { get; set; }
            public string brandname { get; set; }
            public string itmrange { get; set; }
            public string itmrangedesc { get; set; }
        }


        public class StkMovdocHdrsInput
        {
            public string docNo { get; set; }
            public string movCode { get; set; }
            public string movType { get; set; }
            public string storeNo { get; set; }
            public string fstoreNo { get; set; }
            public string tstoreNo { get; set; }
            public string supplyNo { get; set; }
            public string docRef1 { get; set; }
            public string docRef2 { get; set; }
            public string accCode { get; set; }
            public string staffNo { get; set; }
            public string docLines { get; set; }
            public string docDate { get; set; }
            public string postDate { get; set; }
            public string docStatus { get; set; }
            public string docTerm { get; set; }
            public string docTime { get; set; }
            public string docQty { get; set; }
            public string docFoc { get; set; }
            public string docDisc { get; set; }
            public string docAmt { get; set; }
            public string docTrnspt { get; set; }
            public string docTax { get; set; }
            public string docAttn { get; set; }
            public string docRemk1 { get; set; }
            public string docRemk2 { get; set; }
            public string docRemk3 { get; set; }
            public string docShip { get; set; }
            public string bname { get; set; }
            public string baddr1 { get; set; }
            public string baddr2 { get; set; }
            public string baddr3 { get; set; }
            public string bpostcode { get; set; }
            public string bstate { get; set; }
            public string bcity { get; set; }
            public string bcountry { get; set; }
            public string daddr1 { get; set; }
            public string daddr2 { get; set; }
            public string daddr3 { get; set; }
            public string dpostcode { get; set; }
            public string dstate { get; set; }
            public string dcity { get; set; }
            public string dcountry { get; set; }
            public string cancelQty { get; set; }
            public string recStatus { get; set; }
            public string recExpect { get; set; }
            public string recTtl { get; set; }
            public string createUser { get; set; }
            public string createDate { get; set; }
            public string phyNo { get; set; }
            public string PoNo { get; set; }
        }


        public class StkMovdocDtls
        {
            public string docId { get; set; }
            public string docNo { get; set; }
            public string movCode { get; set; }
            public string movType { get; set; }
            public string docLineno { get; set; }
            public string docDate { get; set; }
            public string grnNo { get; set; }
            public string refNo { get; set; }
            public string itemcode { get; set; }
            public string itemdesc { get; set; }
            public string itemprice { get; set; }
            public string docUomtype { get; set; }
            public string docUomqty { get; set; }
            public string docQty { get; set; }
            public string docFocqty { get; set; }
            public string docTtlqty { get; set; }
            public string docPrice { get; set; }
            public string docMdisc { get; set; }
            public string docPdisc { get; set; }
            public string docDisc { get; set; }
            public string docAmt { get; set; }
            public string recQty1 { get; set; }
            public string recQty2 { get; set; }
            public string recQty3 { get; set; }
            public string recQty5 { get; set; }
            public string recTtl { get; set; }
            public string postedQty { get; set; }
            public string cancelQty { get; set; }
            public string ordMemo1 { get; set; }
            public string ordMemo2 { get; set; }
            public string ordMemo3 { get; set; }
            public string ordMemo4 { get; set; }
            public string createUser { get; set; }
            public string createDate { get; set; }
            public string docUom { get; set; }
            public string docExpdate { get; set; }
            public string docBatchNo { get; set; }
            public string phyNo { get; set; }
            public string itmBrand { get; set; }
            public string itmRange { get; set; }

            public string stkAdjReasonCode { get; set; }
            public string itemRemark { get; set; }
            public string itmBrandDesc { get; set; }
            public string itmRangeDesc { get; set; }
            public string DOCUOMDesc { get; set; }

            public string RunningNo { get; set; }
        }

        public class DelStkMovdocDtls
        {
            public string docId { get; set; }
        }

        public class StktrnsInput
        {
            public string trnPost { get; set; }
            public string trnNo { get; set; }
            public string trnDate { get; set; }
            public string postTime { get; set; }
            public string aperiod { get; set; }
            public string itemcode { get; set; }
            public string storeNo { get; set; }
            public string tstoreNo { get; set; }
            public string fstoreNo { get; set; }
            public string trnDocno { get; set; }
            public string trnType { get; set; }
            public string trnDbQty { get; set; }
            public string trnCrQty { get; set; }
            public string trnQty { get; set; }
            public string trnBalqty { get; set; }
            public string trnBalcst { get; set; }
            public string trnAmt { get; set; }
            public string trnCost { get; set; }
            public string trnRef { get; set; }
            public string hqUpdate { get; set; }
            public string lineNo { get; set; }
            public string itemUom { get; set; }
            public string itemBatch { get; set; }
            public string movType { get; set; }
            public string itemBatchCost { get; set; }
            public string stockIn { get; set; }
            public string transPackageLineNo { get; set; }
            public string RunningNo { get; set; }
        }


        public class ControlNos
        {
            
            public string controlPrefix { get; set; }
            public string siteCode { get; set; }
            public string controlNo { get; set; }
        }




        #endregion
        #region Functions
        #region LoadValue
        private void LoadValue()
        {

            try
            {
                oDT_General = (DataTable)JsonConvert.DeserializeObject(apiCalling(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/ItemSupplies"), (typeof(DataTable)));
                ddl_supplierDOrderApproval.Items.Add(new ListItem("Select your option", ""));
                foreach (DataRow oDr in oDT_General.Rows)
                {
                    ddl_supplierDOrderApproval.Items.Add(new ListItem(oDr["supplydesc"].ToString().Trim(), oDr["splyCode"].ToString().Trim()));
                }

                oDT_General = (DataTable)JsonConvert.DeserializeObject(apiCalling(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/Employees"), (typeof(DataTable)));
                ddlCreatedBy_DOrderApproval.Items.Add(new ListItem("Select your option", ""));
                foreach (DataRow oDr in oDT_General.Rows)
                {
                    ddlCreatedBy_DOrderApproval.Items.Add(new ListItem(oDr["empName"].ToString().Trim(), oDr["empCode"].ToString().Trim()));
                }

                oDT_General = (DataTable)JsonConvert.DeserializeObject(apiCalling(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/ItemSitelists"), (typeof(DataTable)));
                ddlStoreCode_DOrderApproval.Items.Add(new ListItem("Select your option", ""));
                foreach (DataRow oDr in oDT_General.Rows)
                {
                    ddlStoreCode_DOrderApproval.Items.Add(new ListItem(oDr["itemsiteDesc"].ToString().Trim(), oDr["itemsiteCode"].ToString().Trim()));
                }
                ddlStoreCode_DOrderApproval.Value= System.Configuration.ConfigurationManager.AppSettings["SiteCode"];

                //oDT_General = (DataTable)JsonConvert.DeserializeObject(apiCalling(System.Configuration.ConfigurationManager.AppSettings["uri"] +"api/ItemSitelists"), (typeof(DataTable)));
                //if (oDT_General.Rows.Count > 0 && stockListingMaster.Rows.Count == 1)
                //{
                //    for (int i = 0; i < oDT_General.Rows.Count; i++)
                //    {
                //        HtmlTableRow _Row = new HtmlTableRow();
                //        HtmlTableCell Col_1 = new HtmlTableCell();
                //        Col_1.InnerText = oDT_General.Rows[i]["itemsiteCode"].ToString();

                //        _Row.Controls.Add(Col_1);
                //        HtmlTableCell Col_2 = new HtmlTableCell();
                //        Col_2.InnerText = oDT_General.Rows[i]["itemsiteDesc"].ToString();
                //        _Row.Controls.Add(Col_2);
                //        HtmlTableCell Col_3 = new HtmlTableCell();
                //        Col_3.Attributes.Add("style", "width: 10 %; text-align:center");
                //        Col_3.InnerHtml = "<input type='checkbox' class='case'>";
                //        _Row.Controls.Add(Col_3);
                //        stockListingMaster.Rows.Add(_Row);
                //    }
                //}

            }
            catch (Exception Ex)
            {
                throw;
            }
        }


        private string apiCalling( string apiName)
        {
            HttpWebRequest WebReq = (HttpWebRequest)WebRequest.Create(string.Format(apiName));
            WebReq.Method = "GET";
            HttpWebResponse WebResp = (HttpWebResponse)WebReq.GetResponse();
            Console.WriteLine(WebResp.StatusCode);
            Console.WriteLine(WebResp.Server);
            string jsonString;
            using (Stream stream = WebResp.GetResponseStream())   //modified from your code since the using statement disposes the stream automatically when done
            {
                StreamReader reader = new StreamReader(stream, System.Text.Encoding.UTF8);
                jsonString = reader.ReadToEnd();
            }
            return jsonString;
        }

        private string GetapiCalling(string apiName)
        {
            using (var client = new HttpClient())
            {
                //client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                //GET Method  
                string api = apiName;
                var response = client.GetAsync(api).Result;
                return response.Content.ReadAsStringAsync().Result;
            }
        }

        #endregion

        #region Load Page Informations
        /// <summary>
        /// 
        /// </summary>
        private void LoadPageInformations()
        {
        }
        #endregion

        [WebMethod]
        public static void DelStkMovdocDtlsData(List<DelStkMovdocDtls> Details)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                DelStkMovdocDtls c = new DelStkMovdocDtls { docId = Details[0].docId };
                string api = "api/StkMovdocDtls/"+ Details[0].docId;
                var post = client.DeleteAsync(api);
                post.Wait();
                var response = post.Result;
                if (response.IsSuccessStatusCode)
                {
                    Console.Write("Success");
                }

            }
        }

        [WebMethod]
        public static void AddStkMovdocHdrsData(List<StkMovdocHdrsInput> Details)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                //GET Method  
                string codeDesc = "Goods Receive Note";
                string api = "api/ControlNos?filter={\"where\":{\"controlDescription\":\"" + codeDesc + "\"}}";
                var response = client.GetAsync(api).Result;
                if (response.IsSuccessStatusCode)
                {
                    var a = response.Content.ReadAsStringAsync().Result;
                    List<ControlNos> GRN = JsonConvert.DeserializeObject<List<ControlNos>>(a);
                    Details[0].docNo = GRN[0].controlPrefix + GRN[0].siteCode + GRN[0].controlNo;
                }
                else
                {
                    Console.WriteLine("Internal server Error");
                }
            }

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                var post = client.PostAsJsonAsync<List<StkMovdocHdrsInput>>("api/StkMovdocHdrs", Details);
                post.Wait();
                var response = post.Result;
                System.Net.ServicePointManager.Expect100Continue = false;
                if (response.IsSuccessStatusCode)
                {
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Success");
                }
                else
                {
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Error");
                }

            }
        }

        [WebMethod]
        public static void EditStkMovdocHdrsData(List<StkMovdocHdrsInput> Details)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                var post = client.PostAsJsonAsync<StkMovdocHdrsInput>("api/StkMovdocHdrs/update?[where][docNo]=" + Details[0].docNo + "", Details[0]);
                post.Wait();
                var response = post.Result;
                System.Net.ServicePointManager.Expect100Continue = false;
                if (response.IsSuccessStatusCode)
                {
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Success");
                }
                else
                {
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Error");
                }

            }
        }


        [WebMethod]
        public static void AddStkMovdocDtlsData(List<StkMovdocDtls> Details)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                //GET Method  
                string codeDesc = "Goods Receive Note";
                string api = "api/ControlNos?filter={\"where\":{\"controlDescription\":\"" + codeDesc + "\"}}";
                var response = client.GetAsync(api).Result;
                if (response.IsSuccessStatusCode)
                {
                    var a = response.Content.ReadAsStringAsync().Result;
                    List<ControlNos> GRN = JsonConvert.DeserializeObject<List<ControlNos>>(a);
                    Details[0].docNo = GRN[0].controlPrefix+ GRN[0].siteCode + GRN[0].controlNo;
                    Details[0].RunningNo =  GRN[0].controlNo;
                }
                else
                {
                    Console.WriteLine("Internal server Error");
                }
            }

            if (Details.Count > 0)
            {
                //List <StkMovdocDtls> datelist = new List<StkMovdocDtls>();

                foreach (var mc in Details)
                    mc.docNo = Details[0].docNo;

                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                    client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                    var post = client.PostAsJsonAsync<List<StkMovdocDtls>>("api/StkMovdocDtls", Details);
                    post.Wait();
                    var response = post.Result;
                    System.Net.ServicePointManager.Expect100Continue = false;
                    if (response.IsSuccessStatusCode)
                    {
                        
                        var errorMessage = response.Content.ReadAsStringAsync().Result;
                        Console.Write("Success");
                    }
                    else
                    {
                        var errorMessage = response.Content.ReadAsStringAsync().Result;
                        Console.Write("Error");
                    }

                }
            }
        }

        [WebMethod]
        public static void EditStkMovdocDtlsData(List<StkMovdocDtls> Details)
        {
            for (var i = 0; i < Details.Count; i++)
            {
                if (Details[i].docId != "" && Details[i].docId != null)
                {
                    using (var client = new HttpClient())
                    {
                        StkMovdocDtls p = new StkMovdocDtls
                        { docNo = Details[i].docNo, movCode = Details[i].movCode, movType = Details[i].movType,docLineno = Details[i].docLineno,
                            docDate = Details[i].docDate,grnNo = Details[i].grnNo,refNo = Details[i].refNo,itemcode = Details[i].itemcode,
                            itemdesc = Details[i].itemdesc,itemprice = Details[i].itemprice,docUomtype = Details[i].docUomtype,
                            docUomqty = Details[i].docUomqty,docQty = Details[i].docQty,docFocqty = Details[i].docFocqty,docTtlqty = Details[i].docTtlqty,
                            docPrice = Details[i].docPrice,docMdisc = Details[i].docMdisc,docPdisc = Details[i].docPdisc,docDisc = Details[i].docDisc,
                            docAmt = Details[i].docAmt,recQty1 = Details[i].recQty1,recQty2 = Details[i].recQty2,recQty3 = Details[i].recQty3,
                            recQty5 = Details[i].recQty5,recTtl = Details[i].recTtl,postedQty = Details[i].postedQty,cancelQty = Details[i].cancelQty,
                            ordMemo1 = Details[i].ordMemo1,ordMemo2 = Details[i].ordMemo2,ordMemo3 = Details[i].ordMemo3,ordMemo4 = Details[i].ordMemo4,
                            createUser = Details[i].createUser,createDate = Details[i].createDate,docUom = Details[i].docUom,
                            docExpdate = Details[i].docExpdate,docBatchNo = Details[i].docBatchNo,phyNo = Details[i].phyNo,itmBrand = Details[i].itmBrand,
                            itmRange = Details[i].itmRange,stkAdjReasonCode = Details[i].stkAdjReasonCode,itemRemark = Details[i].itemRemark,
                            itmBrandDesc = Details[i].itmBrandDesc,itmRangeDesc = Details[i].itmRangeDesc,DOCUOMDesc = Details[i].DOCUOMDesc
                        };
                        client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                        client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                        var post = client.PostAsJsonAsync<StkMovdocDtls>("api/StkMovdocDtls/update?[where][docId]=" + Details[i].docId + "", p);
                        post.Wait();
                        var response = post.Result;
                        System.Net.ServicePointManager.Expect100Continue = false;
                        if (response.IsSuccessStatusCode)
                        {
                            var errorMessage = response.Content.ReadAsStringAsync().Result;
                            Console.Write("Success");
                        }
                        else
                        {
                            var errorMessage = response.Content.ReadAsStringAsync().Result;
                            Console.Write("Error");
                        }

                    }
                }
                else
                {
                    using (var client = new HttpClient())
                    {
                        StkMovdocDtls p = new StkMovdocDtls
                        {
                            docNo = Details[i].docNo,movCode = Details[i].movCode,movType = Details[i].movType,docLineno = Details[i].docLineno,
                            docDate = Details[i].docDate,grnNo = Details[i].grnNo,refNo = Details[i].refNo,itemcode = Details[i].itemcode,
                            itemdesc = Details[i].itemdesc,itemprice = Details[i].itemprice,docUomtype = Details[i].docUomtype,
                            docUomqty = Details[i].docUomqty,docQty = Details[i].docQty,docFocqty = Details[i].docFocqty,docTtlqty = Details[i].docTtlqty,
                            docPrice = Details[i].docPrice,docMdisc = Details[i].docMdisc,docPdisc = Details[i].docPdisc,docDisc = Details[i].docDisc,
                            docAmt = Details[i].docAmt,recQty1 = Details[i].recQty1,recQty2 = Details[i].recQty2,recQty3 = Details[i].recQty3,
                            recQty5 = Details[i].recQty5,recTtl = Details[i].recTtl,postedQty = Details[i].postedQty,cancelQty = Details[i].cancelQty,
                            ordMemo1 = Details[i].ordMemo1,ordMemo2 = Details[i].ordMemo2,ordMemo3 = Details[i].ordMemo3,ordMemo4 = Details[i].ordMemo4,
                            createUser = Details[i].createUser,createDate = Details[i].createDate,docUom = Details[i].docUom,
                            docExpdate = Details[i].docExpdate,docBatchNo = Details[i].docBatchNo,phyNo = Details[i].phyNo,itmBrand = Details[i].itmBrand,
                            itmRange = Details[i].itmRange,stkAdjReasonCode = Details[i].stkAdjReasonCode,itemRemark = Details[i].itemRemark,
                            itmBrandDesc = Details[i].itmBrandDesc,itmRangeDesc = Details[i].itmRangeDesc,DOCUOMDesc = Details[i].DOCUOMDesc
                        };
                        client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                        client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                        var post = client.PostAsJsonAsync<StkMovdocDtls>("api/StkMovdocDtls", p);
                        post.Wait();
                        var response = post.Result;
                        System.Net.ServicePointManager.Expect100Continue = false;
                        if (response.IsSuccessStatusCode)
                        {
                            var errorMessage = response.Content.ReadAsStringAsync().Result;
                            Console.Write("Success");
                        }
                        else
                        {
                            var errorMessage = response.Content.ReadAsStringAsync().Result;
                            Console.Write("Error");
                        }

                    }
                }
            }
        }

        [WebMethod]
        public static void AddStktrnsData(List<StktrnsInput> Details)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                //GET Method  
                string codeDesc = "Goods Receive Note";
                string api = "api/ControlNos?filter={\"where\":{\"controlDescription\":\"" + codeDesc + "\"}}";
                var response = client.GetAsync(api).Result;
                if (response.IsSuccessStatusCode)
                {
                    var a = response.Content.ReadAsStringAsync().Result;
                    List<ControlNos> GRN = JsonConvert.DeserializeObject<List<ControlNos>>(a);
                    Details[0].trnDocno = GRN[0].controlPrefix + GRN[0].siteCode + GRN[0].controlNo;
                    Details[0].RunningNo = GRN[0].controlNo;
                }
                else
                {
                    Console.WriteLine("Internal server Error");
                }
            }

            foreach (var mc in Details)
                mc.trnDocno = Details[0].trnDocno;

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                var post = client.PostAsJsonAsync<List<StktrnsInput>>("api/Stktrns", Details);
                post.Wait();
                var response = post.Result;
                System.Net.ServicePointManager.Expect100Continue = false;
                if (response.IsSuccessStatusCode)
                {
                    for (var i = 0; i < Details.Count; i++)
                    {
                        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(System.Configuration.ConfigurationManager.AppSettings["SequoiaUri"] + "api/postTblStockBalanceDay?saDate=" + DateTime.Now.ToString("yyyy/MM/dd") + "&itemCode=" + Details[i].itemcode + "&uom=" + Details[i].itemUom + "&itemsiteCode=" + Details[i].storeNo + "&onhandQty=" + Details[i].trnQty + "");
                        req.ContentType = "application/json;";
                        req.Method = "GET";
                        WebResponse response1 = req.GetResponse();
                        Stream responseStream = response1.GetResponseStream();
                        StreamReader sr = new StreamReader(responseStream);
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        dynamic MyDynamic = js.Deserialize<dynamic>(sr.ReadToEnd());
                    }

                    if (response.IsSuccessStatusCode)
                    {
                        string control = Details[0].RunningNo;
                        string controlNo = control;
                        int Newcontrol = int.Parse(controlNo);
                        int NewcontrolNo = Newcontrol + 1;
                        ControlNosUpdate c = new ControlNosUpdate { controldescription = "Goods Receive Note", controlnumber = Convert.ToString(NewcontrolNo) };
                        string api = "api/ControlNos/updatecontrol";
                        post = client.PostAsJsonAsync<ControlNosUpdate>(api, c);
                        post.Wait();
                        response = post.Result;
                        if (response.IsSuccessStatusCode)
                        {
                            Console.Write("Success");
                        }
                    }
                    else
                    {

                    }
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Success");
                }
                else
                {
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Error");
                }

            }
        }

        #region Validation
        private bool Validation()
        {
            bool _RetVal = false;
            return _RetVal;
            
        }
        #endregion

        #region Update Table

        [WebMethod]
        public static void RemoveAttachment(string Index)
        {
            DataTable oDT_Static_StudentMaster = new DataTable();
            oDT_Static_StudentMaster = null;
            oDT_Static_StudentMaster = (DataTable)HttpContext.Current.Session["oDT_atStudent"];
            oDT_Static_StudentMaster.Rows.RemoveAt(Convert.ToInt32(Index) - 1);
            HttpContext.Current.Session["oDT_atStudent"] = oDT_Static_StudentMaster;
            oDT_Static_StudentMaster = null;

        }
        [WebMethod]
        public static void AddAttachment(string SourcePath)
        {
            DataTable oDT_Static_StudentMaster = new DataTable();
            oDT_Static_StudentMaster = null;
            oDT_Static_StudentMaster = (DataTable)HttpContext.Current.Session["oDT_atStudent"];
            DataRow oDr = oDT_Static_StudentMaster.NewRow();
            oDr["Document"] = "Student";
            oDr["ServerPath"] = (string)HttpContext.Current.Session["AttachmentPath"];
            oDr["FileInfo"] = SourcePath;
            oDr["Existing"] = "N";

            oDT_Static_StudentMaster.Rows.Add(oDr);
            HttpContext.Current.Session["oDT_atStudent"] = oDT_Static_StudentMaster;
            oDT_Static_StudentMaster = null;
        }
        #endregion

        #region Load HTML Table
        private void LoadHTMLTable()
        {
            //try
            //{

            //    oDT_atStudent = (DataTable)Session["oDT_atStudent"];
            //    if (oDT_atStudent.Rows.Count > 0 && atStudent.Rows.Count == 1)
            //    {

            //        for (int i = 0; i < oDT_atStudent.Rows.Count; i++)
            //        {
            //            HtmlTableRow _Row = new HtmlTableRow();
            //            HtmlTableCell Col_1 = new HtmlTableCell();
            //            Col_1.InnerText = oDT_atStudent.Rows[i]["FileInfo"].ToString();
            //            _Row.Controls.Add(Col_1);
            //            HtmlTableCell Col_2 = new HtmlTableCell();
            //            Col_2.Attributes.Add("style", "width: 20%; text-align:center");
            //            Col_2.InnerHtml = "<div class='tools'><i class='Download_Attachments_Student glyphicon glyphicon-download-alt'></i><i class='Remove_Attachments_Student glyphicon glyphicon-trash'></i></div>";
            //            _Row.Controls.Add(Col_2);
            //            atStudent.Rows.Add(_Row);
            //        }
            //    }


            //}
            //catch (Exception)
            //{
            //    throw;
            //}
        }
        #endregion

        #region Upload File
        private void UploadFile()
        {
            //try
            //{
            //    string strDirectory = (string)HttpContext.Current.Session["AttachmentPath"].ToString().Trim() + "/" + txtCode_Student.Value;
            //    if (System.IO.Directory.Exists(strDirectory) ==false)
            //    {
            //        System.IO.Directory.CreateDirectory(strDirectory);
            //    }
            //    HttpFileCollection flImages = Request.Files;
            //    foreach (string _key in flImages.Keys)
            //    {
            //        HttpPostedFile flFile = flImages[_key];
            //        if (flFile.FileName != "")
            //        {
            //            string _Path =Path.Combine(strDirectory,  flFile.FileName);
            //            flFile.SaveAs(_Path);
            //        }
            //    }
            //}
            //catch (Exception)
            //{
            //    throw;
            //}
        }
        #endregion
        #endregion
        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["AlertMessage"] != null)
                {
                    oCommonEngine.SetAlert(this.Page, Session["AlertMessage"].ToString(), Utilities.CommonEngine.MessageType.Success, Utilities.CommonEngine.MessageDuration.Short);
                    Session["AlertMessage"] = null;
                }
                //if (Session["User_UserCode"] == null)
                //{
                //    strUserCode = "";
                //    strSiteCode = "";
                //    Response.Redirect("~/Login.aspx");
                //}
                //else
                //{
                //    strUserCode = (string)Session["User_UserCode"];
                //    strSiteCode = (string)Session["User_SiteCode"];
                //}
                if (!IsPostBack)
                {
                    LoadValue();
                    LoadPageInformations();
                }

                _PKey = Request.QueryString["PKey"].ToString();
                _PKey1 = Request.QueryString["PKey1"].ToString();
                _PKey2 = Request.QueryString["PKey2"].ToString();

                if (Request.QueryString["PKey2"] != "null")
                {

                    btnSubmit_AddDOrderApproval.InnerText = "Edit";

                    if (_PKey1 == "Posted")
                    {
                        
                    }
                    else
                    {
                        using (var client = new HttpClient())
                        {
                            client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                            client.DefaultRequestHeaders.Accept.Clear();
                            client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                            //GET Method  
                            string api = "api/StkMovdocHdrs?filter={\"where\":{\"docNo\":\"" + _PKey2 + "\"}}";
                            var response = client.GetAsync(api).Result;
                            if (response.IsSuccessStatusCode)
                            {
                                var a = response.Content.ReadAsStringAsync().Result;
                                List<StkMovdocHdrsInput> StkMovdocHdrsVal = JsonConvert.DeserializeObject<List<StkMovdocHdrsInput>>(a);
                                txtDocNo_DOrderApproval.Value = _PKey;
                                txtGRNNo_DOrderApproval.Value = StkMovdocHdrsVal[0].docNo;
                                dt_DocDateDOrderApproval.Value = Convert.ToDateTime(StkMovdocHdrsVal[0].docDate).ToString("dd/MM/yyyy");
                                txtStatus_DOrderApproval.Value = "Approved";
                                ddl_supplierDOrderApproval.Value = StkMovdocHdrsVal[0].supplyNo;
                                dt_DeliveryDateDOrderApproval.Value = Convert.ToDateTime(StkMovdocHdrsVal[0].docDate).ToString("dd/MM/yyyy");
                                txtTerm_DOrderApproval.Value = StkMovdocHdrsVal[0].docTerm;
                                txtPO1Ref_DOrderApproval.Value = StkMovdocHdrsVal[0].docRef1;
                                ddlStoreCode_DOrderApproval.Value = StkMovdocHdrsVal[0].storeNo;
                                txtGrn1Ref_DOrderApproval.Value = StkMovdocHdrsVal[0].docRef2;
                                ddlCreatedBy_DOrderApproval.Value = StkMovdocHdrsVal[0].staffNo;
                                txtRemark_DOrderApproval.Value = StkMovdocHdrsVal[0].docRemk1;
                                txt_TotAmntDOrderApproval.Value = StkMovdocHdrsVal[0].docAmt;
                                txtAttnTo_DOrderApproval.Value = StkMovdocHdrsVal[0].docAttn;
                                txtAddress1_DOrderApproval.Value = StkMovdocHdrsVal[0].baddr1;
                                txtShipToAddress1_DOrderApproval.Value = StkMovdocHdrsVal[0].daddr1;
                                txtAddress2_DOrderApproval.Value = StkMovdocHdrsVal[0].baddr2;
                                txtShipToAddress2_DOrderApproval.Value = StkMovdocHdrsVal[0].daddr2;
                                txtAddress3_DOrderApproval.Value = StkMovdocHdrsVal[0].baddr3;
                                txtShipToAddress3_DOrderApproval.Value = StkMovdocHdrsVal[0].daddr3;
                                txtPostCode_DOrderApproval.Value = StkMovdocHdrsVal[0].bpostcode;
                                txtPostCodeTo_DOrderApproval.Value = StkMovdocHdrsVal[0].dpostcode;
                                txtCity_DOrderApproval.Value = StkMovdocHdrsVal[0].bcity;
                                txtCityTo_DOrderApproval.Value = StkMovdocHdrsVal[0].dcity;
                                txtState_DOrderApproval.Value = StkMovdocHdrsVal[0].bstate;
                                txtStateTo_DOrderApproval.Value = StkMovdocHdrsVal[0].dstate;
                                txtCountry_DOrderApproval.Value = StkMovdocHdrsVal[0].bcountry;
                                txtCountryTo_DOrderApproval.Value = StkMovdocHdrsVal[0].dcountry;
                                txtRemark1_DOrderApproval.Value = StkMovdocHdrsVal[0].docRemk2;
                                txtRemark2_DOrderApproval.Value = StkMovdocHdrsVal[0].docRemk3;
                                recStatus = StkMovdocHdrsVal[0].recStatus;
                                btnSubmit_AddDOrderApproval.Disabled = true;
                                btnSubmit_PostDOrderApproval.Disabled = true;
                            }
                            else
                            {
                                Console.WriteLine("Internal server Error");
                            }
                        }

                        List<StkMovdocDtls> StkMovdocDtlsVal = JsonConvert.DeserializeObject<List<StkMovdocDtls>>(GetapiCalling("api/StkMovdocDtls?filter={\"where\":{\"docNo\":\"" + _PKey2 + "\"}}"));
                        if (StkMovdocDtlsVal.Count > 0 && DOrderApprovalEntryModule.Rows.Count == 1)
                        {
                            for (int i = 0; i < StkMovdocDtlsVal.Count; i++)
                            {
                                HtmlTableRow _Row = new HtmlTableRow();

                                HtmlTableCell Col_0 = new HtmlTableCell();
                                Col_0.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                                Col_0.InnerHtml = StkMovdocDtlsVal[i].docId;
                                //Col_15.InnerHtml = "<input type='hidden' class=form-control' value=" + StkMovdocDtlsVal[i].docId + " id='txthiddenId_DOrderApprovalDtl' runat='server'>";
                                _Row.Controls.Add(Col_0);


                                HtmlTableCell Col_1 = new HtmlTableCell();
                                Col_1.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                                Col_1.InnerHtml = StkMovdocDtlsVal[i].docUom;
                                _Row.Controls.Add(Col_1);

                                HtmlTableCell Col_2 = new HtmlTableCell();
                                Col_2.Attributes.Add("style", "width: 5 %");
                                Col_2.InnerText = StkMovdocDtlsVal[i].docLineno;
                                _Row.Controls.Add(Col_2);

                                HtmlTableCell Col_3 = new HtmlTableCell();
                                Col_3.Attributes.Add("style", "width: 10 %");
                                Col_3.InnerText = StkMovdocDtlsVal[i].itemcode;
                                _Row.Controls.Add(Col_3);

                                HtmlTableCell Col_4 = new HtmlTableCell();
                                Col_4.Attributes.Add("style", "width: 20 %");
                                Col_4.InnerText = StkMovdocDtlsVal[i].itemdesc;
                                _Row.Controls.Add(Col_4);

                                HtmlTableCell Col_5 = new HtmlTableCell();
                                Col_5.Attributes.Add("style", "width: 10 %");
                                Col_5.InnerText = StkMovdocDtlsVal[i].itmBrandDesc;
                                _Row.Controls.Add(Col_5);

                                HtmlTableCell Col_6 = new HtmlTableCell();
                                Col_6.Attributes.Add("style", "width: 10 %");
                                Col_6.InnerText = StkMovdocDtlsVal[i].itmRangeDesc;
                                _Row.Controls.Add(Col_6);

                                HtmlTableCell Col_7 = new HtmlTableCell();
                                Col_7.Attributes.Add("style", "width: 10 %");
                                Col_7.InnerText = StkMovdocDtlsVal[i].docPrice;
                                _Row.Controls.Add(Col_7);

                                HtmlTableCell Col_8 = new HtmlTableCell();
                                Col_8.Attributes.Add("style", "width: 10 %");
                                Col_8.InnerText = StkMovdocDtlsVal[i].DOCUOMDesc;
                                _Row.Controls.Add(Col_8);

                                HtmlTableCell Col_9 = new HtmlTableCell();
                                Col_9.Attributes.Add("style", "width: 10 %");
                                Col_9.InnerText = StkMovdocDtlsVal[i].docQty;
                                _Row.Controls.Add(Col_9);

                                HtmlTableCell Col_10 = new HtmlTableCell();
                                Col_10.Attributes.Add("style", "width: 10 %");
                                Col_10.InnerText = StkMovdocDtlsVal[i].docAmt;
                                _Row.Controls.Add(Col_10);

                                HtmlTableCell Col_15 = new HtmlTableCell();
                                Col_15.Attributes.Add("style", "width: 10 %");
                                Col_15.InnerText = StkMovdocDtlsVal[i].itemRemark;
                                _Row.Controls.Add(Col_15);


                                //HtmlTableCell Col_11 = new HtmlTableCell();
                                //Col_11.Attributes.Add("style", "width: 10%; text-align:center");
                                //Col_11.InnerHtml = "<div class='tools'><i class='edit_AddItemToDOrderApproval glyphicon glyphicon-pencil'></i></div>";
                                //_Row.Controls.Add(Col_11);

                                //if (recStatus == "0")
                                //{
                                //    HtmlTableCell Col_12 = new HtmlTableCell();
                                //    Col_12.Attributes.Add("style", "width: 10%; text-align:center");
                                //    Col_12.InnerHtml = "<div class='tools'><i class='Remove_AddItemToGRNAfterSave glyphicon glyphicon-trash'></i></div>";
                                //    _Row.Controls.Add(Col_12);
                                //}



                                HtmlTableCell Col_13 = new HtmlTableCell();
                                Col_13.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                                Col_13.InnerHtml = StkMovdocDtlsVal[i].itmBrand;
                                _Row.Controls.Add(Col_13);

                                HtmlTableCell Col_14 = new HtmlTableCell();
                                Col_14.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                                Col_14.InnerHtml = StkMovdocDtlsVal[i].itmRange;
                                _Row.Controls.Add(Col_14);

                                DOrderApprovalEntryModule.Rows.Add(_Row);
                            }
                        }

                    }

                }
                else
                {
                    btnSubmit_AddDOrderApproval.InnerText = "Add";
                    txtStatus_DOrderApproval.Value = "Open";
                    //_PKey = "";
                    //FetchRecordAsync();
                    using (var client = new HttpClient())
                    {
                        client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                        client.DefaultRequestHeaders.Accept.Clear();
                        client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                        //GET Method  
                        string api = "api/dos?filter={\"where\":{\"doNo\":\"" + _PKey + "\"}}";
                        var response = client.GetAsync(api).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            var a = response.Content.ReadAsStringAsync().Result;
                            List<dosInput> StkMovdocHdrsVal = JsonConvert.DeserializeObject<List<dosInput>>(a);
                            txtDocNo_DOrderApproval.Value = StkMovdocHdrsVal[0].doNo;
                            if (_PKey2.ToString() != "null")
                            {
                                txtGRNNo_DOrderApproval.Value = _PKey2;
                            }
                            else
                            {
                                txtGRNNo_DOrderApproval.Value = "";
                            }
                            dt_DocDateDOrderApproval.Value = Convert.ToDateTime(StkMovdocHdrsVal[0].doDate).ToString("dd/MM/yyyy");
                            txtStatus_DOrderApproval.Value = StkMovdocHdrsVal[0].doStatus;
                            //if (StkMovdocHdrsVal[0].poStatus == "0")
                            //{
                            //    txtStatus_DOrderApproval.Value = "Open";
                            //}
                            //else
                            //{
                            //    txtStatus_DOrderApproval.Value = "Posted";
                            //}

                            ddl_supplierDOrderApproval.Value = StkMovdocHdrsVal[0].suppCode;
                            dt_DeliveryDateDOrderApproval.Value = "";
                            txtTerm_DOrderApproval.Value = "";
                            txtPO1Ref_DOrderApproval.Value = "";
                            ddlStoreCode_DOrderApproval.Value = StkMovdocHdrsVal[0].itemsiteCode;
                            txtGrn1Ref_DOrderApproval.Value = "";
                            ddlCreatedBy_DOrderApproval.Value = "";
                            txtRemark_DOrderApproval.Value = StkMovdocHdrsVal[0].doRemk1;

                            txtAttnTo_DOrderApproval.Value = StkMovdocHdrsVal[0].doAttn;
                            txtAddress1_DOrderApproval.Value = StkMovdocHdrsVal[0].doBaddr1;
                            txtShipToAddress1_DOrderApproval.Value = StkMovdocHdrsVal[0].doDaddr1;
                            txtAddress2_DOrderApproval.Value = StkMovdocHdrsVal[0].doBaddr2;
                            txtShipToAddress2_DOrderApproval.Value = StkMovdocHdrsVal[0].doDaddr2;
                            txtAddress3_DOrderApproval.Value = StkMovdocHdrsVal[0].doBaddr3;
                            txtShipToAddress3_DOrderApproval.Value = StkMovdocHdrsVal[0].doDaddr3;
                            txtPostCode_DOrderApproval.Value = StkMovdocHdrsVal[0].doBdostcode;
                            txtPostCodeTo_DOrderApproval.Value = StkMovdocHdrsVal[0].doDdostcode;
                            txtCity_DOrderApproval.Value = StkMovdocHdrsVal[0].doBcity;
                            txtCityTo_DOrderApproval.Value = StkMovdocHdrsVal[0].doDcity;
                            txtState_DOrderApproval.Value = StkMovdocHdrsVal[0].doBstate;
                            txtStateTo_DOrderApproval.Value = StkMovdocHdrsVal[0].doDstate;
                            txtCountry_DOrderApproval.Value = StkMovdocHdrsVal[0].doBcountry;
                            txtCountryTo_DOrderApproval.Value = StkMovdocHdrsVal[0].doDcountry;
                            txtRemark1_DOrderApproval.Value = StkMovdocHdrsVal[0].doRemk2;
                            txtRemark2_DOrderApproval.Value = StkMovdocHdrsVal[0].doRemk2;

                            recStatus = StkMovdocHdrsVal[0].doStatus;
                            if (StkMovdocHdrsVal[0].doStatus == "Approved")
                            {
                                btnSubmit_AddDOrderApproval.Disabled = false;
                                btnSubmit_PostDOrderApproval.Disabled = false;
                            }
                            else
                            {
                                btnSubmit_AddDOrderApproval.Disabled = true;
                                btnSubmit_PostDOrderApproval.Disabled = true;
                            }
                        }
                        else
                        {
                            Console.WriteLine("Internal server Error");
                        }
                    }

                    List<doDtls> StkMovdocDtlsVal = JsonConvert.DeserializeObject<List<doDtls>>(GetapiCalling("api/DODetailsLists?filter={\"where\":{\"dono\":\"" + _PKey + "\"}}"));
                    if (StkMovdocDtlsVal.Count > 0 && DOrderApprovalEntryModule.Rows.Count == 1)
                    {
                        for (int i = 0; i < StkMovdocDtlsVal.Count; i++)
                        {
                            HtmlTableRow _Row = new HtmlTableRow();

                            HtmlTableCell Col_0 = new HtmlTableCell();
                            Col_0.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                            Col_0.InnerHtml = StkMovdocDtlsVal[i].doid;
                            //Col_15.InnerHtml = "<input type='hidden' class=form-control' value=" + StkMovdocDtlsVal[i].docId + " id='txthiddenId_POrderApprovalDtl' runat='server'>";
                            _Row.Controls.Add(Col_0);


                            HtmlTableCell Col_1 = new HtmlTableCell();
                            Col_1.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                            Col_1.InnerHtml = StkMovdocDtlsVal[i].docuom;
                            _Row.Controls.Add(Col_1);

                            HtmlTableCell Col_2 = new HtmlTableCell();
                            Col_2.Attributes.Add("style", "width: 5 %");
                            Col_2.InnerText = StkMovdocDtlsVal[i].linenumber;
                            _Row.Controls.Add(Col_2);

                            HtmlTableCell Col_3 = new HtmlTableCell();
                            Col_3.Attributes.Add("style", "width: 10 %");
                            Col_3.InnerText = StkMovdocDtlsVal[i].doditemcode;
                            _Row.Controls.Add(Col_3);

                            HtmlTableCell Col_4 = new HtmlTableCell();
                            Col_4.Attributes.Add("style", "width: 20 %");
                            Col_4.InnerText = StkMovdocDtlsVal[i].doditemdesc;
                            _Row.Controls.Add(Col_4);

                            HtmlTableCell Col_5 = new HtmlTableCell();
                            Col_5.Attributes.Add("style", "width: 10 %");
                            Col_5.InnerText = StkMovdocDtlsVal[i].brandname;
                            _Row.Controls.Add(Col_5);

                            HtmlTableCell Col_6 = new HtmlTableCell();
                            Col_6.Attributes.Add("style", "width: 10 %");
                            Col_6.InnerText = StkMovdocDtlsVal[i].itmrangedesc;
                            _Row.Controls.Add(Col_6);

                            HtmlTableCell Col_7 = new HtmlTableCell();
                            Col_7.Attributes.Add("style", "width: 10 %");
                            Col_7.InnerText = StkMovdocDtlsVal[i].doditemprice;
                            _Row.Controls.Add(Col_7);

                            HtmlTableCell Col_8 = new HtmlTableCell();
                            Col_8.Attributes.Add("style", "width: 10 %");
                            Col_8.InnerText = StkMovdocDtlsVal[i].docuomdesc;
                            _Row.Controls.Add(Col_8);

                            HtmlTableCell Col_9 = new HtmlTableCell();
                            Col_9.Attributes.Add("style", "width: 10 %");
                            Col_9.InnerText = StkMovdocDtlsVal[i].dodqty;
                            _Row.Controls.Add(Col_9);

                            HtmlTableCell Col_10 = new HtmlTableCell();
                            Col_10.Attributes.Add("style", "width: 10 %");
                            Col_10.InnerText = StkMovdocDtlsVal[i].dodprice;
                            _Row.Controls.Add(Col_10);

                            HtmlTableCell Col_15 = new HtmlTableCell();
                            Col_15.Attributes.Add("style", "width: 10 %");
                            Col_15.InnerText = "";
                            _Row.Controls.Add(Col_15);


                            //HtmlTableCell Col_11 = new HtmlTableCell();
                            //Col_11.Attributes.Add("style", "width: 10%; text-align:center");
                            //Col_11.InnerHtml = "<div class='tools'><i class='edit_AddItemToDOrderApproval glyphicon glyphicon-pencil'></i></div>";
                            //_Row.Controls.Add(Col_11);

                            //if (recStatus == "0")
                            //{
                            //    HtmlTableCell Col_12 = new HtmlTableCell();
                            //    Col_12.Attributes.Add("style", "width: 10%; text-align:center");
                            //    Col_12.InnerHtml = "<div class='tools'><i class='Remove_AddItemToDOrderApprovalAfterSave glyphicon glyphicon-trash'></i></div>";
                            //    _Row.Controls.Add(Col_12);
                            //}



                            HtmlTableCell Col_13 = new HtmlTableCell();
                            Col_13.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                            Col_13.InnerHtml = StkMovdocDtlsVal[i].itmbrand;
                            _Row.Controls.Add(Col_13);

                            HtmlTableCell Col_14 = new HtmlTableCell();
                            Col_14.Attributes.Add("style", "width: 0 % ;visibility:hidden;");
                            Col_14.InnerHtml = StkMovdocDtlsVal[i].itmrange;
                            _Row.Controls.Add(Col_14);

                            DOrderApprovalEntryModule.Rows.Add(_Row);
                        }
                    }

                    txt_TotAmntDOrderApproval.Value = StkMovdocDtlsVal.Sum(x => Convert.ToDecimal(x.dodprice)).ToString();
                }
                
            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Medium);
            }

        }

        #endregion
    }
}