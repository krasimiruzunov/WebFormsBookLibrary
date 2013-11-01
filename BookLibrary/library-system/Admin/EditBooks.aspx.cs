using BookLibrary.Models;
using Error_Handler_Control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookLibrary.Admin
{
    public partial class Books : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            this.GridViewBooks.DataBind();
            this.DropDownListCategories.DataBind();
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<BookLibrary.Models.Book> GridViewCategories_GetData()
        {
            BookLibraryEntities db = new BookLibraryEntities();
            return db.Books;
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void GridViewCategories_DeleteItem(int id)
        {
            BookLibraryEntities db = new BookLibraryEntities();
            Book book = db.Books.FirstOrDefault(c => c.Id == id);
            try
            {                
                db.Books.Remove(book);
                db.SaveChanges();
                this.GridViewBooks.PageIndex = 0;
                ErrorSuccessNotifier.AddInfoMessage("Book successfully deleted!");
            }
            catch(Exception ex)
            {
                ErrorSuccessNotifier.AddErrorMessage(ex);
            }
        }

        protected void LinkButtonCreateOrEdit_Click(object sender, EventArgs e)
        {
            Book book;
            int bookId= 0;
            BookLibraryEntities db = new BookLibraryEntities();
            if (!String.IsNullOrEmpty(this.LabelBookId.Text))
            {
                bookId = Convert.ToInt32(this.LabelBookId.Text);
                book = db.Books.FirstOrDefault(c => c.Id == bookId);
            }
            else
            {
                book = new Book();
                db.Books.Add(book);
            }

            try
            {
                if(String.IsNullOrEmpty(this.TextBoxTitle.Text))
                {
                    throw new ArgumentException("Title must be filled!");
                }
                if (String.IsNullOrEmpty(this.TextBoxAuthors.Text))
                {
                    throw new ArgumentException("Author must be filled!");
                }

                book.Title = this.TextBoxTitle.Text;
                book.Author = this.TextBoxAuthors.Text;
                book.ISBN = this.TextBoxISBN.Text;
                book.Website = this.TextBoxWebsite.Text;
                book.Description = this.TextBoxDescription.Text;
                book.CategoryId = Convert.ToInt32(this.DropDownListCategories.SelectedItem.Value);
                db.SaveChanges();
                ErrorSuccessNotifier.AddInfoMessage("Book successfully " + (bookId == 0 ? "created!" : "edited!"));
                ErrorSuccessNotifier.ShowAfterRedirect = true;
                Response.Redirect("EditBooks.aspx", false);
            }
            catch (Exception ex)
            {
                ErrorSuccessNotifier.AddErrorMessage(ex);
            }
        }

        protected void LinkButtonCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditBooks.aspx");
            this.PanelCreateOrEdit.Visible = false;
            this.LabelBookId.Text = "";
        }

        protected void LinkButtonEditCategory_Command(object sender, CommandEventArgs e)
        {
            int bookId = Convert.ToInt32(e.CommandArgument);

            BookLibraryEntities db = new BookLibraryEntities();
            Book book = db.Books.FirstOrDefault(b => b.Id == bookId);

            if (book != null)
            {
                this.LabelBookId.Text = bookId.ToString();
                this.TitleCreateOrEdit.InnerText = "Edit Book";
                this.TextBoxTitle.Text = book.Title;
                this.TextBoxAuthors.Text = book.Author;
                this.TextBoxISBN.Text = book.ISBN;
                this.TextBoxWebsite.Text = book.Website;
                this.TextBoxDescription.Text = book.Description;
                this.DropDownListCategories.DataSource = db.Categories.ToList();
                this.LinkButtonCreateOrEdit.Text = "Save";
                this.PanelCreateOrEdit.Visible = true;
            }
        }

        protected void LinkButtonCreateNewBook_Click(object sender, EventArgs e)
        {
            BookLibraryEntities db = new BookLibraryEntities();
            this.TitleCreateOrEdit.InnerText = "Create New Book";
            this.LinkButtonCreateOrEdit.Text = "Create";
            this.TextBoxTitle.Text = "";
            this.TextBoxAuthors.Text = "";
            this.TextBoxISBN.Text = "";
            this.TextBoxWebsite.Text = "";
            this.TextBoxDescription.Text = "";
            this.DropDownListCategories.DataSource = db.Categories.ToList();
            this.PanelCreateOrEdit.Visible = true;
        }

    }
}