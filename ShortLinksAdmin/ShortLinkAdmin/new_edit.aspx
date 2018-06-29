<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="new_edit.aspx.cs" Inherits="ShortLinkAdmin.new_edit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
   
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <h3><asp:Label runat="server" ID="lblEvent" Text="" CssClass="my-5"></asp:Label></h3>
            <table class="table my-4">
                <tr>
                    <td class="w-25"><span>Short URL:</span><br />
                        <asp:Button runat="server" ID="btnRand" OnClick="btnRand_Click" Text="Random" CssClass="btn btn-sm btn-primary my-2" UseSubmitBehavior="False" />
                        <span>Length: </span>
                        <asp:DropDownList runat="server" ID="ddlLength">
                             <asp:ListItem>2</asp:ListItem>
                             <asp:ListItem>3</asp:ListItem>
                             <asp:ListItem>4</asp:ListItem>
                             <asp:ListItem>5</asp:ListItem>
                             <asp:ListItem>6</asp:ListItem>
                             <asp:ListItem>7</asp:ListItem>
                             <asp:ListItem>8</asp:ListItem>
                             <asp:ListItem>9</asp:ListItem>
                             <asp:ListItem>10</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td><asp:TextBox runat="server" ID="txtShortUrl" CssClass="w-100" required></asp:TextBox></td>
                </tr>
                <tr>
                    <td><span>Actual URL:</span><asp:Button runat="server" ID="btnCat" Text="Catalogue" CssClass="btn btn-sm btn-primary mx-2" OnClick="btnCat_Click" UseSubmitBehavior="False" required/></td><td><asp:TextBox runat="server" ID="txtActualUrl" CssClass="w-100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><span>Description / Keywords:</span></td><td><asp:TextBox runat="server" ID="txtDesK" CssClass="w-100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><span>Expires:</span><br /><span style="font-size:12px;"><i>A blank value will set the link to never expire.</i></span></td>
                    <td>
                        <asp:TextBox runat="server" ID="txtExpire" CssClass="w-100 form-control" TextMode="Date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </table>
            <br />
            <asp:Button runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn btn-success" />
            <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CssClass="btn btn-danger" UseSubmitBehavior="False" />
        </div>
    </form>
    <br />
    <div class="container">
     <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" >
    Catalogue Search Help
   </button>
        <div class="collapse" id="collapseExample">
            <div class="card card-body">
                <!-- This exists to make easy links to a library OPAC catologue using Evergreen ILS -->
                <h3>Catalogue Links</h3>
                <p>Click catalogue above and replace {INDEX} with an appropriate choice from below and {TERM} with the term to serch for.</p>
                <p>For Example: https://short.link/helpers/gsearch.asp?idx=au&term=stephen king </p>
            <table class="table w-50">
                <tr>
                    <th>INDEX</th>
                    <th>Refers To..</th>
                </tr>
                <tr>
                    <td>au</td>
                    <td>Author</td>
                </tr>
                 <tr>
                    <td>is</td>
                    <td>ISBN</td>
                </tr>
                 <tr>
                    <td>ti</td>
                    <td>Title</td>
                </tr>
                 <tr>
                    <td>kw</td>
                    <td>Keyword</td>
                </tr>
                 <tr>
                    <td>su</td>
                    <td>Subject</td>
                </tr>
                 <tr>
                    <td>se</td>
                    <td>Series</td>
                </tr>
            </table>
            </div>
        </div>
    </div>
</body>
</html>
