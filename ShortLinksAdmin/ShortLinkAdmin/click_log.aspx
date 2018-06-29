<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="click_log.aspx.cs" Inherits="ShortLinkAdmin.click_log" %>

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
        <div class="container">
            <h1>Click Log</h1>
            <h5><asp:HyperLink runat="server" ID="hlShort" NavigateUrl="#"></asp:HyperLink></h5>
            <a href="search.aspx" class="btn btn-primary my-3">Back To Search</a>
            <br />
            <h6>Clicks: <asp:Label runat="server" ID="lblCount"></asp:Label></h6>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="click_id" DataSourceID="SqlDataSource1">
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="click_datetimeLabel" runat="server" Text='<%# Eval("click_datetime") %>' />
                        </td>
                        <td>
                            <a href='<%# @"http://whois.arin.net/rest/nets;q=" + Eval("click_ip") + "?showDetails=true&showarin=false" %>'>
                            <asp:Label ID="click_ipLabel" runat="server" Text='<%# Eval("click_ip") %>' /></a>
                        </td>
                        <td>
                            <asp:Label ID="click_referLabel" runat="server" Text='<%# Eval("click_refer") %>' />
                        </td>
                       
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <asp:Label ID="short_lin" runat="server" Text='<%# Eval("fwd_short") %>' />
                    <table runat="server" class="w-100">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" class="w-100 table table-striped">
                                    <tr runat="server" style="">
                                        <th runat="server">Click Date & Time</th>
                                        <th runat="server">Clicker IP</th>
                                        <th runat="server">Referer</th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="">
                                <asp:DataPager ID="DataPager1" runat="server" class="btn-group">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-default" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                        <asp:NumericPagerField CurrentPageLabelCssClass="btn btn-primary disabled" NumericButtonCssClass="btn btn-default" />
                                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-default" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="short_link" runat="server" Text='<%# Eval("fwd_short") %>' />
                </LayoutTemplate>
            </asp:ListView>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ShortLinkConnectionString %>" SelectCommand="  SELECT * FROM [tbl_Clicklog] INNER JOIN [tbl_Forward] ON tbl_clicklog.click_short = tbl_Forward.fwd_id WHERE ([click_short] = @click_short) ORDER BY [click_datetime] DESC">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="click_short" QueryStringField="q" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>

</body>
</html>
