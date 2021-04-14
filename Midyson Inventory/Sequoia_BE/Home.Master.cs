using Newtonsoft.Json;
using System;
using System.Text;
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

namespace Sequoia_BE
{
    public partial class Home : System.Web.UI.MasterPage
    {
        #region Declaration
        private string strUserCode = "";
        private string strSiteCode = "";
        private string strUserName= "";
        private string strUserType = "";   
        private DataTable oDT_General = new DataTable();
        private CommonEngine oCommonEngine = new CommonEngine();
       

        #endregion

        #region Functions

        #region LoadValue

        private void LoadValue()
        {
            try
            {
                oDT_General = (DataTable)JsonConvert.DeserializeObject(apiCalling(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/ItemUOMs"), (typeof(DataTable)));
                if (oDT_General.Rows.Count > 0)
                {
                    DataView oDV = new DataView(oDT_General);
                    oDV.RowFilter = "uomIsactive = True";
                    oDT_General = oDV.ToTable();
                }
                //DataTable oDT_General = JsonConvert.DeserializeAnonymousType(jsonString, new { result = default(DataTable) }).result;
                ddlUomCDesc_mdladdUom.Items.Add(new ListItem("Select your option", ""));
                foreach (DataRow oDr in oDT_General.Rows)
                {
                    ddlUomCDesc_mdladdUom.Items.Add(new ListItem(oDr["uomDesc"].ToString().Trim(), oDr["uomCode"].ToString().Trim()));
                }
                ddlUomDesc_mdladdUom.Items.Add(new ListItem("Select your option", ""));
                foreach (DataRow oDr in oDT_General.Rows)
                {
                    ddlUomDesc_mdladdUom.Items.Add(new ListItem(oDr["uomDesc"].ToString().Trim(), oDr["uomCode"].ToString().Trim()));
                }

            }
            catch (Exception)
            {
                throw;
            }

        }

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

        #endregion

        #region Load Page Informations

        private void LoadPageInformations()
        {
            try
            {
                //oDT_General = oCommonEngine.ExecuteDataTable("Select Name from InstitutionProfile");
                //if(oDT_General.Rows.Count>0)
                //{
                //    Page.Title = ""+ oDT_General.Rows[0][0].ToString() + " | Home";
                //    lblInstitutionName.InnerText = oDT_General.Rows[0][0].ToString();
                //    lblInstitutionNameShort.InnerText = oDT_General.Rows[0][0].ToString().Substring(0,1);
                //    lblInstitutionName.InnerText = "SEQUOIA";
                //    lblInstitutionNameShort.InnerText = "SEQUOIA";
                //}

                Page.Title = "SEQUOIA | Inventory";
                //lblInstitutionName.InnerText = "SEQUOIA | BE";
                //lblInstitutionNameShort.InnerText = "SEQUOIA | BE";
                //lblInstitutionName.InnerText = "SEQUOIA | BE";
                //lblInstitutionNameShort.InnerText = "SEQUOIA | BE";

                //if (Session["User_UserLastLogin"] != null)
                //{ lblLastLogin_Home.InnerText = Session["User_UserLastLogin"].ToString(); }
                //else
                //{ lblLastLogin_Home.InnerText = "No Log Info...!"; }
                //lbl_VersionInfo_Home.InnerText = System.Configuration.ConfigurationManager.AppSettings["VersionInfo"];

                if (Session["isSettingEnabled"] != null)
                {
                    if (Session["isSettingEnabled"].ToString() == "Y")
                    {
                        aSetting.Visible = true;
                    }
                    else
                    {
                        aSetting.Visible = false;
                    }
                }
                else
                {
                    aSetting.Visible = false;
                }

                GRNList_aspx.Visible = false;
                GRNOutList_aspx.Visible = false;
                GRNInList_aspx.Visible = false;
                GRNReturnList_aspx.Visible = false;
                StockAdjList_aspx.Visible = false;
                POList_aspx.Visible = false;
                POApprovedList_aspx.Visible = false;
                POWithGRNList_aspx.Visible = false;
                webBI_StockBalance_aspx.Visible = false;
                if (DashBoard._oDT_InventoryAuth != null && DashBoard._oDT_InventoryAuth.Columns.Count > 0)
                {
                    for (int i = 0; i < DashBoard._oDT_InventoryAuth.Rows.Count; i++)
                    {
                        if(DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString()== "GRNList.aspx")
                        {
                            GRNList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "GRNOutList.aspx")
                        {
                            GRNOutList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "GRNInList.aspx")
                        {
                            GRNInList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "GRNReturnList.aspx")
                        {
                            GRNReturnList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "StockAdjList.aspx")
                        {
                            StockAdjList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "POList.aspx")
                        {
                            POList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "POApprovedList.aspx")
                        {
                            POApprovedList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "POWithGRNList.aspx" && strSiteCode.Contains("HQ"))
                        {
                            POWithGRNList_aspx.Visible = true;
                        }
                        else if (DashBoard._oDT_InventoryAuth.Rows[i]["URL"].ToString() == "webBI_StockBalance.aspx")
                        {
                            webBI_StockBalance_aspx.Visible = true;
                        }
                    }
                }

                //if (System.Configuration.ConfigurationManager.AppSettings["SiteSetup"] == "Outlet")
                //{
                //    A1.Visible = true;
                //    A5.Visible = true;
                //    A2.Visible = false;
                //}
                //else
                //{
                //    A1.Visible = true;
                //    A5.Visible = true;
                //    A2.Visible = true;
                //}

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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User_UserCode"] == null)
            {
                strUserCode = "";
                strSiteCode = "";
                strUserName = "";
                strUserType = "";
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                strUserCode = (string)Session["User_UserCode"];
                strSiteCode = (string)Session["User_SiteCode"];
                strUserName = (string)Session["User_UserName"];
                strUserType = (string)Session["User_UserType"];
            }
            if (!IsPostBack)
            {
                lbl_GlobalUserName.InnerText = strUserName.Trim();
                lbl_GlobalSignoutUserName.InnerText = strUserName.Trim();
                lbl_GlobalUserType.InnerText = strUserType.Trim();
                lbl_GlobalSignoutUserCode.InnerText = strUserCode.Trim();
                lbl_GlobalSignoutSiteCode.InnerText = strSiteCode.Trim();
                LoadValue();
                LoadPageInformations();
            }
        }

        protected void Setting_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UserAuthorization.aspx");
        }

        protected void GlobalSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtGlobalSearch_Home.Value.Trim()!="")
                {
                    Response.Redirect("~/SearchInfo.aspx?PKey="+ txtGlobalSearch_Home.Value.Trim() + "");
                }
            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Short);
            }
        }

    }
}