using BookLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookLibrary
{
    public partial class BookDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int bookId = Convert.ToInt32(Request.Params["id"]);
            if (bookId > 0)
            {
                BookLibraryEntities db = new BookLibraryEntities();
                var currentBook = db.Books.Where(b => b.Id == bookId).ToList(); ;
                this.FormViewBook.DataSource = currentBook;
                this.DataBind();
                //this.LiteralTitle.Text = currentBook.Title;
                //this.LiteralAuthor.Text = currentBook.Author;
                //this.HyperLinkWebsite.Text = currentBook.Website;
                //this.LiteralDescription.Text = currentBook.Description;
            }
        }

    }
}