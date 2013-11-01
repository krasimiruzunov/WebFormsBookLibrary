<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditBooks.aspx.cs" 
    Inherits="BookLibrary.Admin.Books" %>

<asp:Content ID="ContentBooks" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Edit Books</h1>
    <asp:GridView ID="GridViewBooks" runat="server"
        AutoGenerateColumns="False" DataKeyNames="Id"
        PageSize="5" AllowPaging="true" AllowSorting="true"
        ItemType="BookLibrary.Models.Book"
        SelectMethod="GridViewCategories_GetData"
        DeleteMethod="GridViewCategories_DeleteItem"
        HeaderStyle-BackColor="LightGray"
        CellPadding="5" BorderStyle="Dotted" BorderWidth="1"
        >
        <Columns>
            <asp:TemplateField HeaderText="Title" SortExpression="Title">
                <ItemTemplate>
                    <%#: Item.Title.Length > 15 ? Item.Title.Substring(0, 15) + "...." : Item.Title %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Author" SortExpression="Author">
                <ItemTemplate>
                    <%#: Item.Author.Length > 15 ? Item.Author.Substring(0, 15) + "...." : Item.Author %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
            <asp:TemplateField HeaderText="Web Site" SortExpression="Website">
                <ItemTemplate>
                    <a href="<%#: Item.Website %>"><%#: Item.Website.Length > 15 ? Item.Website.Substring(0, 15) + "...." : Item.Website %></a>  
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category" SortExpression="Category.Name">
                <ItemTemplate>
                    <%#: Item.Category.Name.Length > 15 ? Item.Category.Name.Substring(0, 15) + "...." : Item.Category.Name %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButtonEditCategory" runat="server" 
                        CommandName="EditBook" 
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

    <asp:LinkButton ID="LinkButtonCreateNewBook" runat="server"
         Text="Create New" OnClick="LinkButtonCreateNewBook_Click" CssClass="btn btn-info btn-small" /><br />

    <asp:Panel ID="PanelCreateOrEdit" runat="server" Visible="false">
        <asp:Label ID="LabelBookId"  runat="server" Visible="false"/>  
        <h4 id="TitleCreateOrEdit" runat="server"></h4>
        <asp:Label Text="Title: " runat="server" Width="75"/>
        <asp:TextBox ID="TextBoxTitle" runat="server" placeholder="Enter book title" /><br />

        <asp:Label Text="Author(s): " runat="server" Width="75"/>
        <asp:TextBox ID="TextBoxAuthors" runat="server" placeholder="Enter book authors" /><br />

        <asp:Label Text="ISBN: " runat="server" Width="75"/>
        <asp:TextBox ID="TextBoxISBN" runat="server" placeholder="Enter book ISBN" /><br />
        <asp:Label Text="Web site: " runat="server" Width="75"/>
        <asp:TextBox ID="TextBoxWebsite" runat="server" placeholder="Enter book website" /><br />
        <asp:Label Text="Description: " runat="server" Width="75"/>
        <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Height="200" placeholder="Enter book description" /><br />
        <asp:Label Text="Category: " runat="server" Width="75"/>
        <asp:DropDownList ID="DropDownListCategories" runat="server"
            DataTextField="Name" DataValueField="Id" /><br />
        <asp:LinkButton ID="LinkButtonCreateOrEdit" runat="server"
            OnClick="LinkButtonCreateOrEdit_Click" CssClass="btn btn-info btn-small" />  
        <asp:LinkButton ID="LinkButtonCancel" runat="server"
            Text="Cancel" OnClick="LinkButtonCancel_Click" CssClass="btn btn-info btn-small" />  
    </asp:Panel>

    <asp:LinkButton ID="LinkButtonBackToBooks" runat="server"
        Text="Back to books" PostBackUrl="~/library-system/Default.aspx" /> 
</asp:Content>
