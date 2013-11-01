using BookLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookLibrary.library_system
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string text = Request.Params["q"];
            this.HeaderSearchPage.InnerText = String.Format("Search Results for Query \"{0}\":", text);
            BookLibraryEntities db = new BookLibraryEntities();
            var books = db.Books.Where(b => b.Title.Contains(text));
            this.RepeaterBooks.DataSource = books.ToList();
            this.RepeaterBooks.DataBind();
        }
    }
}