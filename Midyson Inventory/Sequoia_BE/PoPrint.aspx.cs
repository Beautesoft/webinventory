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
    public partial class PoPrint : System.Web.UI.Page
    {
       
        #region Declaration
        private string strUserCode = "";
        private string _PKey = "";
        private string _PKey1 = "";
        private DataTable oDT_General = new DataTable();
        private DataTable oDT_Header = new DataTable();
        private DataTable oDT_Detail = new DataTable();
        private DataTable oDT_GeneralTitle = new DataTable();
        private DataTable oDT_Logo = new DataTable();
        
        private DataSet oDS_General = new DataSet();
        private CommonEngine oCommonEngine = new CommonEngine();

        private class Employees
        {

        }
        #endregion
        #region Functions

        #region LoadValue
        private void LoadValue()
        {

        }
        #endregion

        #region Load Page Informations
        private void LoadPageInformations(string _PKey1)
        {
            try
            {
                HttpWebRequest WebReq = (HttpWebRequest)WebRequest.Create(string.Format(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/PoPrintLists"));
                WebReq.Method = "GET";
                HttpWebResponse WebResp = (HttpWebResponse)WebReq.GetResponse();
                Console.WriteLine(WebResp.StatusCode);
                Console.WriteLine(WebResp.Server);
                string jsonString;
                using (Stream stream = WebResp.GetResponseStream()) 
                {
                    StreamReader reader = new StreamReader(stream, System.Text.Encoding.UTF8);
                    jsonString = reader.ReadToEnd();
                }
                oDT_Header = (DataTable)JsonConvert.DeserializeObject(jsonString, (typeof(DataTable)));
                if (_PKey1 != "")
                {
                    DataView oDV = new DataView(oDT_Header);
                    oDV.RowFilter = "poNo='" + _PKey1 + "'";
                    oDT_Header = oDV.ToTable();
                }

                //oDT_Header = (DataTable)JsonConvert.DeserializeObject(jsonString, (typeof(DataTable)));
                ReportDataSource rds = new ReportDataSource("ds_PORequest", oDT_Header);
                this.rv_webBI_InvoicePrint.LocalReport.DataSources.Clear();
                this.rv_webBI_InvoicePrint.LocalReport.DataSources.Add(rds);

                string strFromDate = "";
                string strToDate = "";
                string postData1Title = "{\"fromDate\":\"" + strFromDate.Trim() + "\"," +
                     "\"toDate\":\"" + strToDate.Trim() + "\"," +
                     //"\"ReportTitle\":\"" + "Sales Collection" + "\"," +
                     "\"ReportTitle\":\"" + " Invoice Print " + "\"," +
                                          "\"site\":\"" + System.Configuration.ConfigurationManager.AppSettings["SiteCode"].ToString() + "\"}";
                //oDT_GeneralTitle = oCommonEngine.GetDataTableFromAPI(Login.strAPIURL + "/api/webBI_ReportTittle", postData1Title);
                oDT_GeneralTitle = oCommonEngine.ExecuteDataTable("select '' as fromDate,'' as toDate ,'Goods Receive Note Print' as reportTitle,'' as site ,'' as userCode,'' as siteText, Comp_Title1 as companyHeader1,Comp_Title2 as companyHeader2,Comp_Title3 as companyHeader3,Comp_Title4 as companyHeader4,Footer_1 as companyFooter1,Footer_2 as companyFooter2,Footer_3 as companyFooter3,Footer_4 as companyFooter4 from Title where Product_License='" + oDT_Header.Rows[0]["itemSiteCode"] + "'");
                ReportDataSource titledatasource = new ReportDataSource("ds_webBI_ReportTittle", oDT_GeneralTitle);
                this.rv_webBI_InvoicePrint.LocalReport.DataSources.Add(titledatasource);

                oDT_Logo = oCommonEngine.ExecuteDataTable("select Trans_Logo as Logo from Title  ");
                ReportDataSource Logodatasource = new ReportDataSource("ds_Logo", oDT_Logo);
                this.rv_webBI_InvoicePrint.LocalReport.DataSources.Add(Logodatasource);

                this.rv_webBI_InvoicePrint.LocalReport.ReportPath = "rpt_webBI_Invoice.rdlc";
                this.rv_webBI_InvoicePrint.LocalReport.Refresh();
                this.rv_webBI_InvoicePrint.SizeToReportContent = true;
                this.rv_webBI_InvoicePrint.Width = Unit.Percentage(100);
                this.rv_webBI_InvoicePrint.Height = Unit.Percentage(100);
                this.rv_webBI_InvoicePrint.AsyncRendering = false;
                this.rv_webBI_InvoicePrint.ZoomMode = ZoomMode.FullPage;
                oCommonEngine.SetAlert(this.Page, "Report Loaded Sucessfully...!", Utilities.CommonEngine.MessageType.Success, Utilities.CommonEngine.MessageDuration.Short);

            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Medium);
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
                _RetVal = true;
                return _RetVal;
            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, CommonEngine.MessageType.Error, CommonEngine.MessageDuration.Short);
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
                //if (Session["strUserName"] == null)
                //{
                //    strUserCode = "";
                //    Response.Redirect("~/Login.aspx");
                //}
                //else
                //{
                //    strUserCode = (string)Session["strUserName"];
                //}
                //string strName = this.GetType().Name.ToString().Trim();
                
                if (!IsPostBack)
                {
                    //rv_webBI_SaleCollection.LocalReport.EnableHyperlinks = true;
                    if (Request.QueryString["PKey"] != null)
                    {
                        _PKey = Request.QueryString["PKey"].ToString();
                        LoadPageInformations(_PKey);
                    }

                }
            }
            catch (Exception Ex)
            {
                throw;
            }
        }
        #endregion
    }
}