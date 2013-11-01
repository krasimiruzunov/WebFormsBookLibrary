using BookLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookLibrary
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<BookLibrary.Models.Category> ListViewCategories_GetData()
        {            
            BookLibraryEntities db = new BookLibraryEntities();
            return db.Categories;
        }


        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string text = this.TextBoxSearch.Text;
            Response.Redirect("Search.aspx?q=" + text);
        }
    }
}