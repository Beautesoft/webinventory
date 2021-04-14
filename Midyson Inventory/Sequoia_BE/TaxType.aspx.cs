using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Sequoia_BE.Utilities;

namespace Sequoia_BE
{
    public partial class TaxType : System.Web.UI.Page
    {
        private DataTable oDT_City = new DataTable();
        private DataTable oDT_General = new DataTable();
        private CommonEngine oCommonEngine = new CommonEngine();
        string _Prefix = string.Empty, _ControlNo = string.Empty, _PKey = string.Empty;

        #region Methods


        protected void Get_TaxType()
        {

            //HttpWebRequest WebReq = (HttpWebRequest)WebRequest.Create(string.Format("http://103.253.14.203:3000/api/TaxType1TaxCodes"));
            HttpWebRequest WebReq = (HttpWebRequest)WebRequest.Create(string.Format(System.Configuration.ConfigurationManager.AppSettings["uri"] + "api/TaxType1TaxCodes"));
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

            List<TaxTypeMaster> items = new List<TaxTypeMaster>();
            items = JsonConvert.DeserializeObject<List<TaxTypeMaster>>(jsonString);

            for (int i = 0; i < items.Count; i++)
            {

                HtmlTableRow _Row = new HtmlTableRow();
                HtmlTableCell Col = new HtmlTableCell();
                Col.Attributes.Add("style", "width: 35 %");
                Col.InnerHtml = "<a href='TaxType.aspx?PKey=" + items[i].itemCode + "'><font color='#6a6000'><b>" + items[i].itemCode.ToString() + "</b></font></a>";                
                _Row.Controls.Add(Col);

                 Col = new HtmlTableCell();
                Col.Attributes.Add("style", "width: 20 %");
                Col.InnerText = items[i].taxCode;
                _Row.Controls.Add(Col);

                Col = new HtmlTableCell();
                Col.Attributes.Add("style", "width: 35 %");
                Col.InnerText = items[i].taxDesc;
                _Row.Controls.Add(Col);

                Col = new HtmlTableCell();
                Col.Attributes.Add("style", "width: 35 %");
                Col.InnerText = items[i].taxRatePercent;
                _Row.Controls.Add(Col);

                

                Col = new HtmlTableCell();
                Col.Attributes.Add("style", "width: 10 %; text-align:center");
                if (items[i].isactive)
                {
                    Col.InnerHtml = "<input type='checkbox' checked class='chk_ActiveTaxType editor - active'>";
                }
                else
                {
                    Col.InnerHtml = "<input type='checkbox' class='chk_ActiveTaxType editor - active'>";
                }
                _Row.Controls.Add(Col);

                tbl_TaxTypeList.Rows.Add(_Row);

            }
        }

        private bool Validation()
        {
            bool _RetVal = false;
            try
            {
                if (txt_TaxCode.Value.ToString().Trim().Replace("'", "") == "")
                {
                    //txtCode_Student.Value = oCommonEngine.GetAutoGenerateCode(strUserCode, strSiteCode, "Student");
                }
                if (txt_TaxDesc.Value.ToString().Trim().Replace("'", "") == "")
                {
                    oCommonEngine.SetAlert(this.Page, "Please enter Tax Description...!", Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Short);
                    return _RetVal;
                }


                _RetVal = true;
                return _RetVal;
            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Short);
                return _RetVal;
            }
        }

        private void DataClear()
        {
            btn_AddTaxType.InnerText = "Add";
            txt_TaxCode.Value = string.Empty;
            txt_TaxDesc.Value = string.Empty;
            txt_TaxPercent.Value = string.Empty;
            chk_ActiveTaxType.Checked = true;

        }

        private void FetchRecords()
        {

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                string api = "api/TaxType1TaxCodes?filter={\"where\":{\"itemCode\":\"" + _PKey + "\"}}";
                var response = client.GetAsync(api).Result;
                if (response.IsSuccessStatusCode)
                {
                    var a = response.Content.ReadAsStringAsync().Result;
                    List<TaxTypeMasterUpdate> TaxTypeMasters = JsonConvert.DeserializeObject<List<TaxTypeMasterUpdate>>(a);

                    if (TaxTypeMasters.Count > 0)
                    {
                        Session["id"] = TaxTypeMasters[0].id;
                        txt_TaxCode.Value = TaxTypeMasters[0].taxCode;
                        txt_TaxDesc.Value = TaxTypeMasters[0].taxDesc;
                        txt_TaxPercent.Value = TaxTypeMasters[0].taxRatePercent;
                        txt_itemCode.Value = TaxTypeMasters[0].itemCode;
                        chk_ActiveTaxType.Checked = TaxTypeMasters[0].isactive;
                    }

                }
                else
                {
                    Console.WriteLine("Internal server Error");
                }

            }

        }



        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {

                if (!IsPostBack)
                {
                    DataClear();
                    //   Get_ControlPrefixs();


                    if (Request.QueryString["PKey"] != null)
                    {
                        _PKey = Request.QueryString["PKey"].ToString();
                        btn_AddTaxType.InnerText = "Update";
                        CollapsiblePanelTaxTypeCreation.Collapsed = false;
                        FetchRecords();
                    }
                    else
                    {
                        btn_AddTaxType.InnerText = "Add";
                        _PKey = string.Empty;

                    }
                };

                if (Request.QueryString["PKey"] != null)
                {
                    _PKey = Request.QueryString["PKey"].ToString();
                }

                Get_TaxType();

            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Medium);
            }

        }


        protected void Operation_Click(object sender, EventArgs e)
        {
            try
            {
                if (Validation())
                {

                    if (btn_AddTaxType.InnerText.Trim() == "Add")
                    {

                        using (var client = new HttpClient())
                        {
                            TaxTypeMaster p = new TaxTypeMaster
                            {

                                itemCode = txt_itemCode.Value.ToString().Trim(),
                                taxCode = txt_TaxCode.Value.ToString().Trim(),
                                taxDesc = txt_TaxDesc.Value.ToString().Trim(),
                                taxRatePercent = txt_TaxPercent.Value.ToString().Trim(),
                                isactive = chk_ActiveTaxType.Checked,
                                //  siteCode = txt_SiteCode.Value.ToString().Trim(),
                            };


                            client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                            client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                            var post = client.PostAsJsonAsync<TaxTypeMaster>("api/TaxType1TaxCodes", p);
                            post.Wait();
                            var response = post.Result;


                            if (response.IsSuccessStatusCode)
                            {                              
                                oCommonEngine.SetAlert(this.Page, "Tax Type Saved Successfully..!", Utilities.CommonEngine.MessageType.Success, Utilities.CommonEngine.MessageDuration.Short);
                            }
                            else
                            {
                                oCommonEngine.SetAlert(this.Page, response.StatusCode + "...!", Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Short);
                            }


                        }

                    }
                    else
                    {
                        using (var client = new HttpClient())
                        {
                            TaxTypeMasterUpdate p = new TaxTypeMasterUpdate
                            {
                                id = int.Parse(Session["id"].ToString()),
                                itemCode = txt_itemCode.Value.ToString().Trim(),
                                taxCode = txt_TaxCode.Value.ToString().Trim(),
                                taxDesc = txt_TaxDesc.Value.ToString().Trim(),
                                taxRatePercent = txt_TaxPercent.Value.ToString().Trim(),
                                isactive = chk_ActiveTaxType.Checked,
                                //  siteCode = txt_SiteCode.Value.ToString().Trim(),
                            };
                            client.BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["uri"]);
                            client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                            var post = client.PutAsJsonAsync<TaxTypeMasterUpdate>("api/TaxType1TaxCodes", p);
                            post.Wait();
                            var response = post.Result;

                            if (response.IsSuccessStatusCode)
                            {
                                oCommonEngine.SetAlert(this.Page, "Tax Type Updated Successfully..!", Utilities.CommonEngine.MessageType.Success, Utilities.CommonEngine.MessageDuration.Short);
                            }
                            else
                                oCommonEngine.SetAlert(this.Page, response.StatusCode + "...!", Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Short);



                        }
                    }

                    DataClear();
                    Get_TaxType();

                }


            }
            catch (Exception Ex)
            {
                oCommonEngine.SetAlert(this.Page, Ex.Message, Utilities.CommonEngine.MessageType.Error, Utilities.CommonEngine.MessageDuration.Short);
            }



        }

        #endregion
    }
}