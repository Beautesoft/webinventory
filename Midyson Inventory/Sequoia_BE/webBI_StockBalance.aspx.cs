using Newtonsoft.Json;
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
using Microsoft.Reporting.WebForms;

namespace Sequoia_BE
{
    public partial class webBI_StockBalance : System.Web.UI.Page
    {
        #region Declaration
        private string strUserCode = "";
        private string strSiteCode = "";
        private DataTable oDT_General = new DataTable();
        private DataTable oDT_GeneralTitle = new DataTable();
        private DataSet oDS_General = new DataSet();
        private CommonEngine oCommonEngine = new CommonEngine();

        public class ComboOutput
        {
            public string success { get; set; }
            public List<comboBoxList> result { get; set; }
            public string error { get; set; }
        }

        public class comboBoxList
        {
            public string itemCode { get; set; }
            public string itemDesc { get; set; }
            public string brandCode { get; set; }
            public string brandName { get; set; }
            public string itemName { get; set; }
            public string rangeName { get; set; }

            public string departmentCode { get; set; }
            public string departmentName { get; set; }
        }

        #endregion
        #region Functions

        #region LoadValue

        private string apiCalling(string apiName)
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

        private void LoadValue()
        {
            try
            {

                oDT_General = (DataTable)JsonConvert.DeserializeObject(apiCalling(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/ItemSitelists"), (typeof(DataTable)));
                DataView oDV1 = new DataView(oDT_General);
                oDV1.RowFilter = "itemsiteCode='" + strSiteCode + "'";
                oDT_General = oDV1.ToTable();

                foreach (DataRow oDr in oDT_General.Rows)
                {
                    ddlSite_webBI_StockBalance.Items.Add(new ListItem(oDr["itemsiteDesc"].ToString().Trim(), oDr["itemsiteCode"].ToString().Trim()));
                }

                //HttpWebRequest req = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/siteListing?userCode='" + strUserCode.Trim() + "'");
                //req.ContentType = "application/json;";
                //req.Method = "GET";
                //WebResponse response = req.GetResponse();
                //Stream responseStream = response.GetResponseStream();
                //StreamReader sr = new StreamReader(responseStream);
                //JavaScriptSerializer js = new JavaScriptSerializer();
                //ComboOutput oComboOutput = js.Deserialize<ComboOutput>(sr.ReadToEnd());
                //if (oComboOutput.success == "1")
                //{
                //    for (int i = 0; i < oComboOutput.result.Count; i++)
                //    {
                //        ddlSite_webBI_StockBalance.Items.Add(new ListItem(oComboOutput.result[i].itemDesc.ToString(), oComboOutput.result[i].itemCode.ToString()));
                //    }
                //}

                HttpWebRequest req1 = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/Brand?siteCode=NIL");
                req1.ContentType = "application/json;";
                req1.Method = "GET";
                WebResponse response1 = req1.GetResponse();
                Stream responseStream1 = response1.GetResponseStream();
                StreamReader sr1 = new StreamReader(responseStream1);
                JavaScriptSerializer js1 = new JavaScriptSerializer();
                ComboOutput oComboOutput1 = js1.Deserialize<ComboOutput>(sr1.ReadToEnd());
                if (oComboOutput1.success == "1")
                {
                    for (int i = 0; i < oComboOutput1.result.Count; i++)
                    {
                        ddlBrand_webBI_StockBalance.Items.Add(new ListItem(oComboOutput1.result[i].brandName.ToString(), oComboOutput1.result[i].brandCode.ToString()));
                    }
                }

                HttpWebRequest req2 = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/StockList?siteCode=NIL");
                req2.ContentType =  "application/json;";
                req2.Method = "GET";
                WebResponse response2 = req2.GetResponse();
                Stream responseStream2 = response2.GetResponseStream();
                StreamReader sr2 = new StreamReader(responseStream2);
                JavaScriptSerializer js2 = new JavaScriptSerializer();
                ComboOutput oComboOutput2 = js2.Deserialize<ComboOutput>(sr2.ReadToEnd());
                if (oComboOutput2.success == "1")
                {
                    for (int i = 0; i < oComboOutput2.result.Count; i++)
                    {
                        ddlFItem_webBI_StockBalance.Items.Add(new ListItem(oComboOutput2.result[i].itemName.ToString(), oComboOutput2.result[i].itemName.ToString()));
                        ddlTItem_webBI_StockBalance.Items.Add(new ListItem(oComboOutput2.result[i].itemName.ToString(), oComboOutput2.result[i].itemName.ToString()));
                    }
                }

                HttpWebRequest req3 = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/Range?siteCode=NIL&brandCode=NIL");
                req3.ContentType = "application/json;";
                req3.Method = "GET";
                WebResponse response3 = req3.GetResponse();
                Stream responseStream3 = response3.GetResponseStream();
                StreamReader sr3 = new StreamReader(responseStream3);
                JavaScriptSerializer js3 = new JavaScriptSerializer();
                ComboOutput oComboOutput3 = js3.Deserialize<ComboOutput>(sr3.ReadToEnd());
                if (oComboOutput3.success == "1")
                {
                    for (int i = 0; i < oComboOutput3.result.Count; i++)
                    {
                        ddlRange_webBI_StockBalance.Items.Add(new ListItem(oComboOutput3.result[i].rangeName.ToString(), oComboOutput3.result[i].rangeName.ToString()));
                    }
                }

                HttpWebRequest req4 = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/department?siteCode=NIL");
                req4.ContentType = "application/json;";
                req4.Method = "GET";
                WebResponse response4 = req4.GetResponse();
                Stream responseStream4 = response4.GetResponseStream();
                StreamReader sr4 = new StreamReader(responseStream4);
                JavaScriptSerializer js4 = new JavaScriptSerializer();
                ComboOutput oComboOutput4 = js4.Deserialize<ComboOutput>(sr4.ReadToEnd());
                if (oComboOutput4.success == "1")
                {
                    for (int i = 0; i < oComboOutput4.result.Count; i++)
                    {
                        ddlDept_webBI_StockBalance.Items.Add(new ListItem(oComboOutput4.result[i].departmentName.ToString(), oComboOutput4.result[i].departmentCode.ToString()));
                    }
                }


                DateTime _ToDate = DateTime.Now;
                dtAsOnDate_webBI_StockBalance.Value = _ToDate.ToString("dd/MM/yyyy");

            }
            catch (Exception)
            {
                throw;
            }

        }
        #endregion

        #region Load Page Informations
        private void LoadPageInformations()
        {
            try
            {
                string strDept = "";
                string strBrand = "";
                string strRange = "";
                string strSite = "";
                string strFromItem = "";
                string strToItem = "";
                string strAsOnDate = "";
                string strShowZeroQty = "N";
                string strShowInactive = "N";
                for (int i = 0; i < ddlDept_webBI_StockBalance.Items.Count; i++)
                {
                    if (ddlDept_webBI_StockBalance.Items[i].Selected == true)
                    { strDept = strDept + ddlDept_webBI_StockBalance.Items[i].Value.ToString().Trim().Replace("'", "") + ","; }
                }
                for (int i = 0; i < ddlBrand_webBI_StockBalance.Items.Count; i++)
                {
                    if (ddlBrand_webBI_StockBalance.Items[i].Selected == true)
                    { strBrand = strBrand + ddlBrand_webBI_StockBalance.Items[i].Value.ToString().Trim().Replace("'", "") + ","; }
                }
                for (int i = 0; i < ddlRange_webBI_StockBalance.Items.Count; i++)
                {
                    if (ddlRange_webBI_StockBalance.Items[i].Selected == true)
                    { strRange = strRange + ddlRange_webBI_StockBalance.Items[i].Value.ToString().Trim().Replace("'", "") + ","; }
                }
                for (int i = 0; i < ddlSite_webBI_StockBalance.Items.Count; i++)
                {
                    if (ddlSite_webBI_StockBalance.Items[i].Selected == true)
                    { strSite = strSite + ddlSite_webBI_StockBalance.Items[i].Value.ToString().Trim().Replace("'", "") + ","; }
                }
                for (int i = 0; i < ddlFItem_webBI_StockBalance.Items.Count; i++)
                {
                    if (ddlFItem_webBI_StockBalance.Items[i].Selected == true)
                    { strFromItem = strFromItem + ddlFItem_webBI_StockBalance.Items[i].Value.ToString().Trim().Replace("'", "") + ","; }
                }

                //strFromItem = ddlFItem_webBI_StockBalance.Items[ddlFItem_webBI_StockBalance.SelectedIndex].Value;
                //strToItem = ddlTItem_webBI_StockBalance.Items[ddlTItem_webBI_StockBalance.SelectedIndex].Value;
                strAsOnDate = dtAsOnDate_webBI_StockBalance.Value.ToString();
                if(chkShowZeroQtyItems_webBI_StockBalance.Checked)
                {
                    strShowZeroQty = "Y";
                }
                if (chkShowInActive_webBI_StockBalance.Checked)
                {
                    strShowInactive = "Y";
                }
                string postData = "{\"toDate\":\"" + strAsOnDate.Trim()+ "\"," +
                     "\"Site\":\"" + strSite.Trim() + "\"," +
                     "\"Dept\":\"" + strDept.Trim() + "\"," +
                     "\"Brand\":\"" + strBrand.Trim() + "\"," +
                     "\"fromItem\":\"" + strFromItem.Trim() + "\"," +
                     "\"toItem\":\"" + strToItem.Trim() + "\"," +
                     "\"Range\":\"" + strRange.Trim() + "\"," +                    
                     "\"showInActive\":\"" + strShowInactive.Trim() + "\"," +
                     "\"showZeroQty\":\"" + strShowZeroQty.Trim() + "\"}";
                oDT_General = oCommonEngine.GetDataTableFromAPI(Login.strAPIURL + "/api/webInventory_StockBalance", postData);
                ReportDataSource rds = new ReportDataSource("ds_webBI_StockBalance", oDT_General);
                this.rv_webBI_StockBalance.LocalReport.DataSources.Clear();
                this.rv_webBI_StockBalance.LocalReport.DataSources.Add(rds);

                string postData1Title = "{\"fromDate\":\"" + strAsOnDate.Trim() + "\"," +
                     "\"toDate\":\"" + strSite.Trim() + "\"," +
                     "\"ReportTitle\":\"" + "Stock Balance" + "\"," +
                     "\"site\":\"" + strSite.Trim() + "\"}";
                //oDT_GeneralTitle = oCommonEngine.GetDataTableFromAPI(Login.strAPIURL + "/api/webBI_ReportTittle", postData1Title);
                oDT_GeneralTitle = oCommonEngine.ExecuteDataTable("select '' as fromDate,'' as toDate ,'Goods Receive Note Print' as reportTitle,'' as site ,'' as userCode,'' as siteText, Comp_Title1 as companyHeader1,Comp_Title2 as companyHeader2,Comp_Title3 as companyHeader3,Comp_Title4 as companyHeader4,Footer_1 as companyFooter1,Footer_2 as companyFooter2,Footer_3 as companyFooter3,Footer_4 as companyFooter4 from Title where Product_License='" + ddlSite_webBI_StockBalance.Value + "'");
                ReportDataSource titledatasource = new ReportDataSource("ds_webBI_ReportTittle", oDT_GeneralTitle);
                this.rv_webBI_StockBalance.LocalReport.DataSources.Add(titledatasource);

                this.rv_webBI_StockBalance.LocalReport.ReportPath = "rpt_webBI_StockBalance.rdlc";
                this.rv_webBI_StockBalance.LocalReport.Refresh();
                this.rv_webBI_StockBalance.SizeToReportContent = true;
                this.rv_webBI_StockBalance.Width = Unit.Percentage(100);
                this.rv_webBI_StockBalance.Height = Unit.Percentage(100);
                this.rv_webBI_StockBalance.AsyncRendering = false;
                this.rv_webBI_StockBalance.ZoomMode = ZoomMode.FullPage;
                oCommonEngine.SetAlert(this.Page, "Report Loaded Sucessfully...!", Utilities.CommonEngine.MessageType.Success, Utilities.CommonEngine.MessageDuration.Short);

            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion

        #region Validation
        private bool Validation()
        {
            bool _RetVal = false;
            try
            {
                string strSite = "";

                for (int i = 0; i < ddlSite_webBI_StockBalance.Items.Count; i++)
                {
                    if (ddlSite_webBI_StockBalance.Items[i].Selected == true)
                    { strSite = strSite + ddlSite_webBI_StockBalance.Items[i].Value.ToString().Trim().Replace("'", "") + ","; }
                }
                if (strSite.Trim() == "")
                {
                    oCommonEngine.SetAlert(this.Page, "Please Select a Site...!", CommonEngine.MessageType.Error, CommonEngine.MessageDuration.Short);
                    return _RetVal;
                }

                _RetVal = true;
                return _RetVal;
            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.Message);
                return _RetVal;
            }
        }
        #endregion
        #endregion
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["User_UserCode"] == null)
                {
                    strUserCode = "";
                    strSiteCode = "";
                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    strUserCode = (string)Session["User_UserCode"];
                    strSiteCode = (string)Session["User_SiteCode"];
                }
                string strName = this.GetType().Name.ToString().Trim();
                if (!IsPostBack)
                {
                    LoadValue();

                }
            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.Message);
            }
        }
        protected void Operation_Click(object sender, EventArgs e)
        {
            try
            {
                if (Validation())
                {
                    LoadPageInformations();
                }
            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.Message);
            }
        }


        #endregion
        
    }
}