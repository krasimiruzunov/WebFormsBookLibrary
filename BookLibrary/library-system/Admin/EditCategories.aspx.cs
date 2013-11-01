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
    public partial class Categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            this.GridViewCategories.DataBind();
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<BookLibrary.Models.Category> GridViewCategories_GetData()
        {
            BookLibraryEntities db = new BookLibraryEntities();
            return db.Categories;
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void GridViewCategories_DeleteItem(int id)
        {
            BookLibraryEntities db = new BookLibraryEntities();
            Category category = db.Categories.FirstOrDefault(c => c.Id == id);
            try
            {
                db.Books.RemoveRange(category.Books);
                db.Categories.Remove(category);
                db.SaveChanges();
                this.GridViewCategories.PageIndex = 0;
                ErrorSuccessNotifier.AddInfoMessage("Category successfully deleted!");
            }
            catch(Exception ex)
            {
                ErrorSuccessNotifier.AddErrorMessage(ex);
            }
        }

        
        protected void LinkButtonCreateNewCategory_Click(object sender, EventArgs e)
        {
            this.TitleCreateOrEdit.InnerText = "Create New Category";
            this.LinkButtonCreateOrEdit.Text = "Create";
            this.TextBoxCreateOrEdit.Text = "";
            this.PanelCreateOrEdit.Visible = true;
        }

        protected void LinkButtonEditCategory_Command(object sender, CommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument); 

            BookLibraryEntities db = new BookLibraryEntities();
            Category category = db.Categories.FirstOrDefault(c => c.Id == categoryId);

            if (category != null)
            {
                this.LabelCategoryId.Text = categoryId.ToString();
                this.TitleCreateOrEdit.InnerText = "Edit Category";
                this.TextBoxCreateOrEdit.Text = category.Name;
                this.LinkButtonCreateOrEdit.Text = "Save";
                this.PanelCreateOrEdit.Visible = true;
            }
        }
        
        protected void LinkButtonCreateOrEdit_Click(object sender, EventArgs e)
        {
            Category category;
            int categoryId = 0;
            BookLibraryEntities db = new BookLibraryEntities();
            if(!String.IsNullOrEmpty(this.LabelCategoryId.Text))
            {
                categoryId = Convert.ToInt32(this.LabelCategoryId.Text);
                category = db.Categories.FirstOrDefault(c => c.Id == categoryId);
            }
            else
            {
                category = new Category();
                db.Categories.Add(category);
            }

            string categoryName = this.TextBoxCreateOrEdit.Text;
            try
            {
                if(String.IsNullOrEmpty(categoryName))
                {
                    throw new ArgumentException("Category name is required!");
                }

                category.Name = categoryName;
                db.SaveChanges();
                ErrorSuccessNotifier.AddInfoMessage("Category " + (categoryId == 0 ? "created!" : "edited!"));
                ErrorSuccessNotifier.ShowAfterRedirect = true;
                Response.Redirect("EditCategories.aspx", false);
            }
            catch(Exception ex)
            {
                ErrorSuccessNotifier.AddErrorMessage(ex);
            }
        }

        protected void LinkButtonCancel_Click(object sender, EventArgs e)
        {
            this.PanelCreateOrEdit.Visible = false;
            this.LabelCategoryId.Text = "";
        }
    }
}