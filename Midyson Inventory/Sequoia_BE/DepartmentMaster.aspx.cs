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

namespace Sequoia_BE
{
    public partial class DepartmentMaster : System.Web.UI.Page
    {
        #region Declaration
        private string strUserCode = "";
        private string strSiteCode = "";
        private string _PKey = "";
        private DataTable oDT_General = new DataTable();
        private DataTable oDT_Lead = new DataTable();
        private DataTable oDT_atStudent = new DataTable();

        public class deptMasterInput
        {
            public string itmCode { get; set; }
            public string itmDesc { get; set; }
            public bool itmStatus { get; set; }
            public string itmSeq { get; set; }
            public bool allowcashsales { get; set; }
            public bool itmShowonsales { get; set; }
            public bool isfirsttrial { get; set; }
            public bool isVoucher { get; set; }
            public bool isPrepaid { get; set; }
            public bool isRetailproduct { get; set; }
            public bool isSalonproduct { get; set; }
            public bool isPackage { get; set; }
            public bool isService { get; set; }
            public bool isCompound { get; set; }
            public string validityPeriod { get; set; }
            public string deptPic { get; set; }
        }

        #endregion
        #region Functions
        #region LoadValue
        private void LoadValue()
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

        #region Load Page Informations
        /// <summary>
        /// 
        /// </summary>
        private void LoadPageInformations()
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
                return _RetVal;
            }
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
            try
            {

            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion

        #region Upload File
        private void UploadFile()
        {
            try
            {
                string strDirectory = (string)HttpContext.Current.Session["AttachmentPath"].ToString().Trim() + "/" + "";
                if (System.IO.Directory.Exists(strDirectory) ==false)
                {
                    System.IO.Directory.CreateDirectory(strDirectory);
                }
                HttpFileCollection flImages = Request.Files;
                foreach (string _key in flImages.Keys)
                {
                    HttpPostedFile flFile = flImages[_key];
                    if (flFile.FileName != "")
                    {
                        string _Path =Path.Combine(strDirectory,  flFile.FileName);
                        flFile.SaveAs(_Path);
                    }
                }
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
                if (Request.QueryString["PKey"] != null)
                {
                    _PKey = Request.QueryString["PKey"].ToString();
                    btnSubmit_AddDeptMaster.InnerText = "Edit";

                    using (var client = new HttpClient())
                    {
                        client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                        client.DefaultRequestHeaders.Accept.Clear();
                        client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                        //GET Method  
                        string api = "api/ItemDepts?filter={\"where\":{\"itmCode\":\"" + _PKey + "\"}}";
                        var response = client.GetAsync(api).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            var a = response.Content.ReadAsStringAsync().Result;
                            List<deptMasterInput> depts = JsonConvert.DeserializeObject<List<deptMasterInput>>(a);
                            txtDeptCode_DeptMaster.Value = depts[0].itmCode;
                            txtDeptCode_DeptMaster.Disabled = true;
                            txtDeptDesc_DeptMaster.Value = depts[0].itmDesc;
                            ddl_ValidityPeriodDeptMaster.Value = depts[0].validityPeriod;
                            txtSeqNo_DeptMaster.Value = depts[0].itmSeq;
                            if (depts[0].allowcashsales == true)
                            {
                                chkAllowCashSales_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkAllowCashSales_DeptMaster.Checked = false;
                            }
                            if (depts[0].itmStatus == true)
                            {
                                chkActive_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkActive_DeptMaster.Checked = false;
                            }
                            if (depts[0].isfirsttrial == true)
                            {
                                chkFirstTrial_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkFirstTrial_DeptMaster.Checked = false;
                            }
                            if (depts[0].isRetailproduct == true)
                            {
                                chkRetail_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkRetail_DeptMaster.Checked = false;
                            }
                            if (depts[0].isSalonproduct == true)
                            {
                                chkSaolon_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkSaolon_DeptMaster.Checked = false;
                            }
                            if (depts[0].isService == true)
                            {
                                chkService_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkService_DeptMaster.Checked = false;
                            }
                            if (depts[0].isVoucher == true)
                            {
                                chkVoucher_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkVoucher_DeptMaster.Checked = false;
                            }
                            if (depts[0].isPrepaid == true)
                            {
                                chkPrepaid_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkPrepaid_DeptMaster.Checked = false;
                            }
                            if (depts[0].isCompound == true)
                            {
                                chkCompound_DeptMaster.Checked = true;
                            }
                            else
                            {
                                chkCompound_DeptMaster.Checked = false;
                            }
                        }
                        else
                        {
                            Console.WriteLine("Internal server Error");
                        }
                    }

                }
                else
                {
                    _PKey = "";
                    btnSubmit_AddDeptMaster.InnerText = "Add";
                    txtDeptCode_DeptMaster.Focus();
                    //using (var client = new HttpClient())
                    //{
                    //    client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                    //    client.DefaultRequestHeaders.Accept.Clear();
                    //    client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                    //    //GET Method  
                    //    string codeDesc = "DEPT CODE";
                    //    string api = "api/ControlNos?filter={\"where\":{\"controlDescription\":\"" + codeDesc + "\"}}";
                    //    var response = client.GetAsync(api).Result;
                    //    if (response.IsSuccessStatusCode)
                    //    {
                    //        var a = response.Content.ReadAsStringAsync().Result;
                    //        List<ControlNos> depts = JsonConvert.DeserializeObject<List<ControlNos>>(a);
                    //        txtDeptCode_DeptMaster.Value = depts[0].controlNo;
                    //    }
                    //    else
                    //    {
                    //        Console.WriteLine("Internal server Error");
                    //    }
                    //}
                }
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


        [WebMethod]
        public static void AddDeptMasterData(string itmCode, string itmDesc, bool itmStatus, string itmSeq, bool allowcashsales, bool itmShowonsales, bool isfirsttrial, bool isVoucher, bool isPrepaid, bool isRetailproduct, bool isSalonproduct, bool isPackage, bool isService, bool isCompound, string validityPeriod)
        {
            using (var client = new HttpClient())
            {
                deptMasterInput p = new deptMasterInput { itmCode = itmCode, itmDesc = itmDesc, itmStatus = itmStatus, itmSeq = itmSeq, allowcashsales = allowcashsales, itmShowonsales = itmShowonsales, isfirsttrial = isfirsttrial, isVoucher = isVoucher, isPrepaid = isPrepaid, isRetailproduct = isRetailproduct, isSalonproduct = isSalonproduct, isPackage = isPackage, isService = isService, isCompound = isCompound, validityPeriod = validityPeriod };
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                var post = client.PostAsJsonAsync<deptMasterInput>("api/ItemDepts", p);
                post.Wait();
                var response = post.Result;
                System.Net.ServicePointManager.Expect100Continue = false;
                if (response.IsSuccessStatusCode)
                {
                    int Newcontrol = int.Parse(itmCode);
                    int NewcontrolNo = Newcontrol + 1;
                    ControlNosUpdate c = new ControlNosUpdate { controldescription = "DEPT CODE", controlnumber = Convert.ToString(NewcontrolNo) };
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
                    var errorMessage = response.Content.ReadAsStringAsync().Result;
                    Console.Write("Error");
                }

            }
        }

        [WebMethod]
        public static void EditAddDeptMasterData(string itmCode, string itmDesc, bool itmStatus, string itmSeq, bool allowcashsales, bool itmShowonsales, bool isfirsttrial, bool isVoucher, bool isPrepaid, bool isRetailproduct, bool isSalonproduct, bool isPackage, bool isService, bool isCompound, string validityPeriod)
        {
            using (var client = new HttpClient())
            {
                deptMasterInput p = new deptMasterInput { itmCode = itmCode, itmDesc = itmDesc, itmStatus = itmStatus, itmSeq = itmSeq, allowcashsales = allowcashsales, itmShowonsales = itmShowonsales, isfirsttrial = isfirsttrial, isVoucher = isVoucher, isPrepaid = isPrepaid, isRetailproduct = isRetailproduct, isSalonproduct = isSalonproduct, isPackage = isPackage, isService = isService, isCompound = isCompound, validityPeriod = validityPeriod };
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                var post = client.PostAsJsonAsync<deptMasterInput>("api/ItemDepts/update?[where][itmCode]=" + itmCode + "", p);
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


        #endregion
    }
}