using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projetoteste
{
    public partial class transition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
            {
                
            }
            else
            {
                // se não estiver na sessão, volta ao login
                Response.Redirect("index.aspx");
            }
        }       
    }
}