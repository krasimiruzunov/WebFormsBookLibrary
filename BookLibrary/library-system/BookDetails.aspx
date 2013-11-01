<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" 
    Inherits="BookLibrary.BookDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Book Details</h1>  
    <asp:FormView ID="FormViewBook" runat="server">
        <ItemTemplate>
            <h4 id="BookTitle" runat="server"><%#: Eval("Title") %></h4><br /> 
            <div id="BookAuthor" runat="server"><%#: Eval("Author") %></div><br />
            <div id="BookISBN" runat="server"><%#: Eval("ISBN") %></div><br />
            <div id="BookWebsite" runat="server">Website: <a href="<%#: Eval("Website") %>"><%#: Eval("Website") %></a></div><br />
            <div id="BookDescription" runat="server"><%#: Eval("Description") %></div><br />
            <asp:LinkButton ID="LinkButtonBackToBooks" runat="server"
                Text="Back to books" PostBackUrl="~/library-system/Default.aspx" /> 
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
