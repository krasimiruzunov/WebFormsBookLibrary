<%@ Page Title="Search Page" Language="C#" MasterPageFile="~/Site.Master"
     AutoEventWireup="true" CodeBehind="Search.aspx.cs" 
    Inherits="BookLibrary.library_system.Search" %>

<asp:Content ID="ContentSerachBook" ContentPlaceHolderID="MainContent" runat="server">
    <div id="PanelSearchBook"> 
        <h2 id="HeaderSearchPage" runat="server"></h2>
        <ul>
            <asp:Repeater ID="RepeaterBooks" runat="server" 
                ItemType="BookLibrary.Models.Book">
                <ItemTemplate>
                    <li>
                        <a href="BookDetails?id=<%#: Item.Id %>"><%#: Item.Title %> by <%#: Item.Author %></a>
                        (Category: <%#: Item.Category.Name %>)
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>

        <asp:LinkButton ID="LinkButtonBackToBooks" runat="server"
                Text="Back to books" PostBackUrl="~/library-system/Default.aspx" /> 
    </div>
</asp:Content>
