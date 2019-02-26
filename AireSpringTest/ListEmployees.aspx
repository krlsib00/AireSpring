<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListEmployees.aspx.cs" Inherits="AireSpringTest.ListEmployees" %>

<asp:Content ID="ListEmployees" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">
        .TableCSS {
            border-style: none;
            background-color: #3BA0D8;
            width: 850px;
        }

        .TableHeader {
            background-color: #FF00FF;
            color: #800080;
            font-size: large;
            font-family: Verdana;
        }

        .TableData {
            background-color: #C0C0C0;
            color: #000000;
            font-family: Courier New;
            font-size: medium;
            font-weight: bold;
        }

        #EmployeeLastNameSearch1, #PhoneNumberSearch1 {
            background-color: #C0C0C0;
            color: #800080;
            font-family: Courier New;
            font-size: x-large;
        }
    </style>

    <h1>Search Employees</h1>

    <asp:Label ID="EmployeeLastNameSearch1" runat="server" ClientIDMode="Static">Last Name:</asp:Label>

    <asp:TextBox ID="EmployeeLastNameSearch" runat="server" Size="Small" />
    <br />
    <br />

    <asp:Label ID="PhoneNumberSearch1" runat="server" ClientIDMode="Static">Phone Number:</asp:Label>

    <asp:TextBox ID="PhoneNumberSearch" runat="server" />
    <ajaxToolkit:MaskedEditExtender ID="PhoneNumberMask" TargetControlID="PhoneNumberSearch" Mask="(999) 999-9999" runat="server" />
    <br />
    <br />

    <asp:Button ID="SearchEmployee" runat="server" Text="Search" OnClick="SearchClick" />
    <br />
    <br />

    <h1>Employee Directory</h1>
    <br />
    <h3>Please press arrow button to sort entries in ascending order</h3>

    <asp:Label ID="lblMessage" runat="server" EnableViewState="false" ForeColor="Blue"></asp:Label>

    <asp:ListView ID="EmployeeList" runat="server" AutoEventWireup="true" AllowSorting="true" OnSorting="SortListViewRecords" OnItemEditing="EditListViewItem"
        OnItemUpdating="UpdateListViewItem" OnItemCanceling="CancelListViewItem" DataKeyNames="EmployeeID" OnItemDeleting="DeleteListViewItem"
        OnItemInserting="InsertListViewItem" InsertItemPosition="LastItem" EnableViewState="true" ItemPlaceholderID="PlaceHolder1">

        <LayoutTemplate>
            <table id="Table1" class="TableCSS">
                <tr runat="server" class="TableHeader">
                    <th>ID<asp:ImageButton ID="SortEmployeeID" runat="server" CommandName="Sort" ImageUrl="~/img/asc.png" CommandArgument="EmployeeID" />
                    </th>
                    <th>Last Name<asp:ImageButton ID="SortEmployeeLastName" runat="server" CommandName="Sort" ImageUrl="~/img/asc.png" CommandArgument="EmployeeLastName" />
                    </th>
                    <th>First Name<asp:ImageButton ID="SortEmployeeFirstName" runat="server" CommandName="Sort" ImageUrl="~/img/asc.png" CommandArgument="EmployeeFirstName" />
                    </th>
                    <th>Phone<asp:ImageButton ID="SortEmployeePhone" runat="server" CommandName="Sort" ImageUrl="~/img/asc.png" CommandArgument="EmployeePhone" />
                    </th>
                    <th>Zip Code<asp:ImageButton ID="SortEmployeeZip" runat="server" CommandName="Sort" ImageUrl="~/img/asc.png" CommandArgument="EmployeeZip" />
                    </th>
                    <th>Hire Date<asp:ImageButton ID="SortEmployeeHireDate" runat="server" CommandName="Sort" ImageUrl="~/img/asc.png" CommandArgument="HireDate" />
                    </th>
                </tr>
                <tr id="ItemPlaceholder" runat="server">
                </tr>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
            </table>
        </LayoutTemplate>

        <ItemTemplate>
            <tr class="TableData">
                <td>
                    <asp:Label ID="EmployeeID" runat="server"><%#Eval("EmployeeID") %></asp:Label>
                </td>

                <td>
                    <asp:Label ID="EmployeeLastName" runat="server"><%#Eval("EmployeeLastName") %></asp:Label>
                </td>

                <td>
                    <asp:Label ID="EmployeeFirstName" runat="server"><%#Eval("EmployeeFirstName") %></asp:Label>
                </td>

                <td>
                    <asp:Label ID="EmployeePhone" runat="server"><%#string.Format("{0:(###) ###-####}", Int64.Parse(Eval("EmployeePhone").ToString())) %></asp:Label>
                </td>

                <td>
                    <asp:Label ID="EmployeeZip" runat="server"><%#Eval("EmployeeZip") %></asp:Label>
                </td>

                <td>
                    <asp:Label ID="EmployeeHireDate" runat="server"><%#Eval("HireDate","{0:d}") %></asp:Label>
                </td>

                <td>

                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />

                    <span onclick="return confirm('Are you sure to delete?')">

                        <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" ForeColor="Red" />

                    </span>

                </td>
            </tr>
        </ItemTemplate>

        <EditItemTemplate>
            <tr class="EditItem">
                <td>
                    <asp:Label ID="EmployeeID" runat="server"><%#Eval("EmployeeID") %></asp:Label>
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeeLastName" runat="server" Text='<%#Eval("EmployeeLastName") %>' />
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeeFirstName" runat="server" Text='<%#Eval("EmployeeFirstName") %>' />
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeePhone" runat="server" Text='<%#Eval("EmployeePhone") %>' />
                    <ajaxToolkit:MaskedEditExtender ID="PhoneNumberMask" TargetControlID="txtEmployeePhone" Mask="(999) 999-9999" runat="server" />
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeeZip" runat="server" Text='<%#Eval("EmployeeZip") %>' />
                    <ajaxToolkit:MaskedEditExtender ID="ZipCodeMask" TargetControlID="txtEmployeeZip" Mask="99999" runat="server" />
                </td>

                <td>
                    <asp:TextBox ID="txtHireDate" runat="server" placeholder="Date/Month/Year" Text='<%#Eval("HireDate","{0:MM/dd/yyyy}") %>' />
                </td>

                <td>
                    <span onclick="return confirm('Are you sure to update?')">
                        <asp:LinkButton ID="btnUpdate" runat="server" Text="Update" CommandName="Update" />
                    </span>

                    <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />
                </td>
            </tr>
        </EditItemTemplate>

        <InsertItemTemplate>
            <tr class="InsertItem">
                <td>
                    <asp:Label ID="EmployeeID" runat="server"><%#Eval("EmployeeID") %></asp:Label>
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeeLastName" runat="server" Text='<%#Eval("EmployeeLastName") %>' />
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeeFirstName" runat="server" Text='<%#Eval("EmployeeFirstName") %>' />
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeePhone" runat="server" Text='<%#Eval("EmployeePhone") %>' />
                    <ajaxToolkit:MaskedEditExtender ID="PhoneNumberMask" TargetControlID="txtEmployeePhone" Mask="(999) 999-9999" runat="server" />
                </td>

                <td>
                    <asp:TextBox ID="txtEmployeeZip" runat="server" Text='<%#Eval("EmployeeZip") %>' />
                    <ajaxToolkit:MaskedEditExtender ID="ZipCodeMask" TargetControlID="txtEmployeeZip" Mask="99999" runat="server" />
                </td>

                <td>
                    <asp:TextBox ID="txtHireDate" runat="server" TextMode="Date" Text='<%#Eval("HireDate","{0:}") %>' />
                </td>

                <td>
                    <span onclick="return confirm('Are you sure to add?')">
                        <asp:LinkButton ID="btnAdd" runat="server" Text="Add" CommandName="Insert" />
                    </span>

                    <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />
                </td>
            </tr>
        </InsertItemTemplate>

    </asp:ListView>
</asp:Content>
