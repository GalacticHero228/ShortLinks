<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="ShortLinkAdmin.search" EnableEventValidation="false" EnableSessionState="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <style>
        #ListView1_DataPager1{
            margin: 0 auto;
            display: table;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-3">
            <h1>Short URLs</h1>
            <div>
                <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control mt-2" ></asp:TextBox>
                <asp:DropDownList runat="server" ID="ddlSearch" CssClass="form-control w-25 mt-3">
                    <asp:ListItem Value="search">Search All Link Fields</asp:ListItem>
                    <asp:ListItem Value="klink">Keyword</asp:ListItem>
                    <asp:ListItem Value="slink">Short Link</asp:ListItem>
                    <asp:ListItem Value="alink">Absolute URL</asp:ListItem>
                    <asp:ListItem Value="all">Show All (No Filter)</asp:ListItem>
                </asp:DropDownList><br />

                <asp:Button runat="server" ID="btnSearch"  Text="Search" CssClass="btn btn-primary mt-2" OnClick="btnSearch_Click"/>
                <a href="search.aspx" class="btn btn-danger mt-2">Clear Search</a>
                <a href="new_edit.aspx" class="btn btn-success mt-2">Add New</a>
            </div>
            
            <br />
            <br />
        </div>
        <div class="mx-3 ">
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SQLDataSource1" DataKeyNames="fwd_id" OnPagePropertiesChanging="ListView1_PagePropertiesChanging">
                
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:TextBox ID="fwd_shortTextBox" runat="server" Text='<%# Bind("fwd_short") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="fwd_urlTextBox" runat="server" CssClass="w-100" Text='<%# Bind("fwd_url") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="fwd_createTextBox" runat="server" Text='<%# Bind("fwd_create", "{0:d}") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="fwd_expireTextBox" runat="server" Text='<%# Bind("fwd_expire", "{0:d}") %>' />
                        </td>
                          <td>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-success btn-sm" />
                            </td>
                        <td>
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger btn-sm" />
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">
                        <td>&nbsp;</td>
                        <td>
                            <asp:TextBox ID="fwd_shortTextBox" runat="server" Text='<%# Bind("fwd_short") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="fwd_urlTextBox" runat="server" Text='<%# Bind("fwd_url") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="fwd_createTextBox" runat="server" Text='<%# Bind("fwd_create", "{0:d}") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="fwd_expireTextBox" runat="server" Text='<%# Bind("fwd_expire", "{0:d}") %>' />
                        </td>
                          <td>
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" CssClass="btn btn-success btn-sm" />
                        </td>
                        <td>
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" CssClass="btn btn-danger btn-sm" />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr class="py-2">
                        
                        <td>
                            <asp:Label ID="fwd_shortLabel" runat="server" Text='<%# Eval("fwd_short") %>' />
                        </td>
                        <td style="max-width:250px;">
                            <a href='<%# Eval("fwd_url") %>' runat="server" id="fwd_url_link"><%# (Eval("fwd_url").ToString().Length > 50) ? Eval("fwd_url").ToString().Substring(0,50) + "..." : Eval("fwd_url").ToString() %></a>
                            <br />
                            <asp:Label ID="fwd_kwdLabel" runat="server" Text='<%# Eval("fwd_kwd") %>' />
                        </td>
                        <td>
                            <asp:Label ID="fwd_createLabel" runat="server" Text='<%# Eval("fwd_create", "{0:d}") %>' />
                        </td>
                        <td>
                            <asp:Label ID="fwd_expireLabel" runat="server" Text='<%# Eval("fwd_expire", "{0:d}") %>' />
                        </td>
                        <td>
                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Are you certain you want to delete?');" />
                        </td>
                        <td>
                             <a href='<%# "new_edit.aspx?q=" + Eval("fwd_id") %>' runat="server" id="A3" class="btn btn-warning btn-sm">Edit</a>
                        </td>
                        <td>
                             <a href='<%# "https://short.link/" + Eval("fwd_short") %>' runat="server" id="A1" class="btn btn-success btn-sm" target="_blank">Test</a>
                        </td>
                        <td>
                            <a href='<%# "click_log.aspx?q=" + Eval("fwd_id") %>' runat="server" id="A2" class="btn btn-primary btn-sm">ClickLog:<%# Eval("fwd_id") %></a>
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" class="mx-auto w-100">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" class="w-100 table table-striped">
                                    <tr runat="server"  class="thead-dark">
                                        <th runat="server">Short URL</th>
                                        <th runat="server">Actual URL / Description</th> 
                                        <th runat="server">Created</th>
                                        <th runat="server">Expires</th>
                                        <th runat="server" colspan="4">Options</th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="">
                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="ListView1" PageSize="10">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowLastPageButton="False" ButtonCssClass="btn btn-primary"  />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
        
    </form>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ShortLinkConnectionString %>" 
        DeleteCommand="DELETE FROM [tbl_Forward] WHERE [fwd_id] = @fwd_id" 
        InsertCommand="INSERT INTO [tbl_Forward] ([fwd_short], [fwd_url], [fwd_expire], [fwd_expired], [fwd_kwd], [fwd_create]) VALUES (@fwd_short, @fwd_url, @fwd_expire, @fwd_expired, @fwd_kwd, @fwd_create)" 
        SelectCommand="SELECT * FROM [tbl_Forward]  WHERE (UPPER([fwd_url]) LIKE '%' + UPPER(@fwd_url) + '%') OR (UPPER([fwd_short]) LIKE '%' + UPPER(@fwd_url) + '%') OR (UPPER([fwd_kwd]) LIKE '%' + UPPER(@fwd_url) + '%')" 
        UpdateCommand="UPDATE [tbl_Forward] SET [fwd_short] = @fwd_short, [fwd_url] = @fwd_url, [fwd_expire] = @fwd_expire, [fwd_expired] = @fwd_expired, [fwd_kwd] = @fwd_kwd, [fwd_create] = @fwd_create WHERE [fwd_id] = @fwd_id">
        <DeleteParameters>
            <asp:Parameter Name="fwd_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="fwd_short" Type="String" />
            <asp:Parameter Name="fwd_url" Type="String" />
            <asp:Parameter Name="fwd_expire" Type="DateTime" />
            <asp:Parameter Name="fwd_expired" Type="Boolean" />
            <asp:Parameter Name="fwd_kwd" Type="String" />
            <asp:Parameter Name="fwd_create" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" Name="fwd_url" PropertyName="Text" Type="String" DefaultValue="`" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="fwd_short" Type="String" />
            <asp:Parameter Name="fwd_url" Type="String" />
            <asp:Parameter Name="fwd_expire" Type="DateTime" />
            <asp:Parameter Name="fwd_expired" Type="Boolean" />
            <asp:Parameter Name="fwd_kwd" Type="String" />
            <asp:Parameter Name="fwd_create" Type="DateTime" />
            <asp:Parameter Name="fwd_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</body>
</html>
