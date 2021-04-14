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
    public partial class UserAuthorization : System.Web.UI.Page
    {
        #region Declaration     
        private DataTable oDT_General = new DataTable();
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
        private void LoadValue()
        {
            try
            {
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/User?siteCode=NIL");
                req.ContentType = "application/json;";
                req.Method = "GET";
                WebResponse response = req.GetResponse();
                Stream responseStream = response.GetResponseStream();
                StreamReader sr = new StreamReader(responseStream);
                JavaScriptSerializer js = new JavaScriptSerializer();
                ComboOutput oComboOutput = js.Deserialize<ComboOutput>(sr.ReadToEnd());
                if (oComboOutput.success == "1")
                {
                    for (int i = 0; i < oComboOutput.result.Count; i++)
                    {
                        ddlUser.Items.Add(new ListItem(oComboOutput.result[i].itemDesc.ToString(), oComboOutput.result[i].itemCode.ToString()));
                    }
                }
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
                oDT_General = new DataTable();               
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/getInventoryAuth?userCode=" + ddlUser.SelectedValue.ToString().Trim()+"");
                req.ContentType = "application/json;";
                req.Method = "GET";
                WebResponse response = req.GetResponse();
                Stream responseStream = response.GetResponseStream();
                StreamReader sr = new StreamReader(responseStream);
                JavaScriptSerializer js = new JavaScriptSerializer();
                dynamic MyDynamic = js.Deserialize<dynamic>(sr.ReadToEnd());
                dynamic MyDynamic_Result = MyDynamic["result"];
                JavaScriptSerializer js_result = new JavaScriptSerializer();
                js_result.MaxJsonLength = Int32.MaxValue;
                js_result.RecursionLimit = 100;
                var json = js_result.Serialize(MyDynamic_Result);
                oDT_General = (DataTable)JsonConvert.DeserializeObject(json, (typeof(DataTable)));
                if (oDT_General.Rows.Count > 0 && UserAuthorizationHTML.Rows.Count == 1)
                {
                    for (int i = 0; i < oDT_General.Rows.Count; i++)
                    {
                        HtmlTableRow _Row = new HtmlTableRow();
                        HtmlTableCell Col_1 = new HtmlTableCell();
                        Col_1.InnerText = oDT_General.Rows[i]["Code"].ToString();
                        _Row.Controls.Add(Col_1);                       
                        HtmlTableCell Col_2 = new HtmlTableCell();
                        Col_2.InnerText = oDT_General.Rows[i]["Name"].ToString();
                        _Row.Controls.Add(Col_2);
                        HtmlTableCell Col_3 = new HtmlTableCell();
                        Col_3.Attributes.Add("style", "width: 10 %; text-align:center");
                        if (oDT_General.Rows[i]["Active"].ToString() == "Y")
                        {
                            Col_3.InnerHtml = "<input type='checkbox' checked class='chk_UserAuthorization editor - active'>";
                        }
                        else
                        {
                            Col_3.InnerHtml = "<input type='checkbox' class='chk_UserAuthorization editor - active'>";
                        }
                        _Row.Controls.Add(Col_3);
                        UserAuthorizationHTML.Rows.Add(_Row);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
        #region Bind Data
        private void BindData()
        {
            try
            {

            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
        #endregion
        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {                               
                if (!IsPostBack)
                {
                    LoadValue();
                    LoadPageInformations();
                }
            }
            catch (Exception Ex)
            {
            }
        }
        protected void ddlUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                LoadPageInformations();
            }
            catch (Exception Ex)
            {
            }
        }

        [WebMethod]
        public static void UserAuthorizationService(string User, string Code, string Active)
        {
           
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(Login.strAPIURL + "/api/postInventoryAuth?UserCode=" + User + "&ReportCode="+ Code + "&Active="+ Active + "");
            req.ContentType = "application/json;";
            req.Method = "GET";
            WebResponse response = req.GetResponse();
            Stream responseStream = response.GetResponseStream();
            StreamReader sr = new StreamReader(responseStream);
            JavaScriptSerializer js = new JavaScriptSerializer();
            dynamic MyDynamic = js.Deserialize<dynamic>(sr.ReadToEnd());
            if (MyDynamic["success"] == "1")
            {
              
            }



        }

        #endregion
    }
}