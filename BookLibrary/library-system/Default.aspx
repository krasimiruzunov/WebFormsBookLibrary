<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" 
    Inherits="BookLibrary._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div id="Search">
            <asp:TextBox ID="TextBoxSearch" runat="server" />
            <asp:Button ID="ButtonSearch" Text="Search" runat="server" OnClick="SearchButton_Click" />
        </div>
    
        <h1>Books</h1>

        <asp:ListView ID="ListViewCategories" runat="server" 
            ItemType="BookLibrary.Models.Category"
            SelectMethod="ListViewCategories_GetData">
            <ItemTemplate>
                <div class="categories" style="min-height: 200px">
                    <h2><%#: Item.Name.Length > 20 ? Item.Name.Substring(0, 20) : Item.Name %></h2>
                    <ul>
                        <asp:Repeater ID="RepeaterBooks" runat="server" 
                            DataSource="<%# Item.Books %>" ItemType="BookLibrary.Models.Book">
                            <ItemTemplate> 
                                <li>
                                    <a href="BookDetails?id=<%#: Item.Id %>"><%# Item.Title %></a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
