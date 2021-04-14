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
    public partial class GRNInPrint : System.Web.UI.Page
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
                var client = new HttpClient();
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                string api = "api/Stkprintlists?filter={\"where\":{\"docNo\":\"" + _PKey1 + "\"}}";
                var response = client.GetAsync(api).Result;
                var a = response.Content.ReadAsStringAsync().Result;
                oDT_Header = (DataTable)JsonConvert.DeserializeObject(a, (typeof(DataTable)));
                oDT_Header.DefaultView.Sort = "docLineno asc";
                oDT_Header = oDT_Header.DefaultView.ToTable();
                ReportDataSource rds = new ReportDataSource("ds_Stkprintlist", oDT_Header);
                this.rv_webBI_GRNInPrint.LocalReport.DataSources.Clear();
                this.rv_webBI_GRNInPrint.LocalReport.DataSources.Add(rds);

                string strFromDate = "";
                string strToDate = "";
                string postData1Title = "{\"fromDate\":\"" + strFromDate.Trim() + "\"," +
                     "\"toDate\":\"" + strToDate.Trim() + "\"," +
                     //"\"ReportTitle\":\"" + "Sales Collection" + "\"," +
                     "\"ReportTitle\":\"" + " Stock Transfer Out Print " + "\"," +
                                          "\"site\":\"" + System.Configuration.ConfigurationManager.AppSettings["SiteCode"].ToString() + "\"}";
                //oDT_GeneralTitle = oCommonEngine.GetDataTableFromAPI(Login.strAPIURL + "/api/webBI_ReportTittle", postData1Title);
                oDT_GeneralTitle = oCommonEngine.ExecuteDataTable("select '' as fromDate,'' as toDate ,'Goods Receive Note Print' as reportTitle,'' as site ,'' as userCode,'' as siteText, Comp_Title1 as companyHeader1,Comp_Title2 as companyHeader2,Comp_Title3 as companyHeader3,Comp_Title4 as companyHeader4,Footer_1 as companyFooter1,Footer_2 as companyFooter2,Footer_3 as companyFooter3,Footer_4 as companyFooter4 from Title where Product_License='" + oDT_Header.Rows[0]["storeNo"] + "'");
                ReportDataSource titledatasource = new ReportDataSource("ds_webBI_ReportTittle", oDT_GeneralTitle);
                this.rv_webBI_GRNInPrint.LocalReport.DataSources.Add(titledatasource);

                oDT_Logo = oCommonEngine.ExecuteDataTable("select Trans_Logo as Logo from Title  ");
                ReportDataSource Logodatasource = new ReportDataSource("ds_Logo", oDT_Logo);
                this.rv_webBI_GRNInPrint.LocalReport.DataSources.Add(Logodatasource);

                this.rv_webBI_GRNInPrint.LocalReport.ReportPath = "rpt_webGRNIn.rdlc";
                this.rv_webBI_GRNInPrint.LocalReport.Refresh();
                this.rv_webBI_GRNInPrint.SizeToReportContent = true;
                this.rv_webBI_GRNInPrint.Width = Unit.Percentage(100);
                this.rv_webBI_GRNInPrint.Height = Unit.Percentage(100);
                this.rv_webBI_GRNInPrint.AsyncRendering = false;
                this.rv_webBI_GRNInPrint.ZoomMode = ZoomMode.FullPage;
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