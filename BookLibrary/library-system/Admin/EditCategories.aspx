<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" CodeBehind="EditCategories.aspx.cs" 
    Inherits="BookLibrary.Admin.Categories" %>

<asp:Content ID="ContentCategories" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Edit Categories</h1>
    <asp:GridView ID="GridViewCategories" runat="server"
        AutoGenerateColumns="False" DataKeyNames="Id"
        PageSize="5" AllowPaging="true" AllowSorting="true"
        ItemType="BookLibrary.Models.Category"
        SelectMethod="GridViewCategories_GetData"
        DeleteMethod="GridViewCategories_DeleteItem"
        HeaderStyle-BackColor="LightGray"
        CellPadding="5" BorderStyle="Dotted" BorderWidth="1"
        >
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Category Name" SortExpression="Name" />
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButtonEditCategory" runat="server" 
                        CommandName="EditCategory" 
                        CommandArgument="<%# Item.Id %>"
                        OnCommand="LinkButtonEditCategory_Command"
                        Text="Edit" CssClass="btn btn-info btn-small" />
                    <asp:LinkButton ID="LinkButtonDeleteCategory" runat="server" 
                        CommandName="Delete" 
                        CommandArgument="<%# Item.Id %>"
                        OnClientClick = "return confirm('Do you want to cancel ?');"
                        Text="Delete" CssClass="btn btn-info btn-small" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:LinkButton ID="LinkButtonCreateNewCategory" runat="server"
         Text="Create New" OnClick="LinkButtonCreateNewCategory_Click" CssClass="btn btn-info btn-small" /><br />

    <asp:Panel ID="PanelCreateOrEdit" runat="server" Visible="false">
        <asp:Label ID="LabelCategoryId"  runat="server" Visible="false"/>  
        <h4 id="TitleCreateOrEdit" runat="server"></h4>
        <asp:Label Text="Category: " runat="server" />
        <asp:TextBox ID="TextBoxCreateOrEdit" runat="server" placeholder="Enter category name" /><br />
        <asp:LinkButton ID="LinkButtonCreateOrEdit" runat="server"
            OnClick="LinkButtonCreateOrEdit_Click" CssClass="btn btn-info btn-small" />  
        <asp:LinkButton ID="LinkButtonCancel" runat="server"
            Text="Cancel" OnClick="LinkButtonCancel_Click" CssClass="btn btn-info btn-small"/>  
    </asp:Panel>

    <asp:LinkButton ID="LinkButtonBackToBooks" runat="server"
        Text="Back to books" PostBackUrl="~/library-system/Default.aspx" /> 
</asp:Content>
