<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddNewEmployee.aspx.cs" Inherits="AireSpringTest.AddNewEmployee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="AddNewEmployee" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">

        .InputLabels {
            background-color: #C0C0C0;
            color: #800080;
            font-family: Courier New;
            font-size: x-large;
        }

        </style>

    <div>
        <h1>Add New Employee</h1>
        <asp:Label ID="NewEmployeeLastName1" runat="server" ClientIDMode="Static" CssClass="InputLabels">Last Name:</asp:Label>
        <asp:TextBox ID="NewEmployeeLastName" runat="server" />
        <br />
        <br />

        <asp:Label ID="NewEmployeeFirstName1" runat="server" ClientIDMode="Static" CssClass="InputLabels">First Name:</asp:Label>
        <asp:TextBox ID="NewEmployeeFirstName" runat="server" />
        <br />
        <br />

        <asp:Label ID="NewEmployeePhoneNumber1" runat="server" ClientIDMode="Static" CssClass="InputLabels">Phone Number:</asp:Label>
        <asp:TextBox ID="NewEmployeePhoneNumber" runat="server" />
        <ajaxToolkit:MaskedEditExtender ID="PhoneNumberMask" TargetControlID="NewEmployeePhoneNumber" Mask="(999) 999-9999" runat="server" />
        <br />
        <br />

        <asp:Label ID="NewEmployeeZipCode1" runat="server" ClientIDMode="Static" CssClass="InputLabels">Zip Code:</asp:Label>
        <asp:TextBox ID="NewEmployeeZipCode" runat="server" />
        <ajaxToolkit:MaskedEditExtender ID="ZipCodeMask" TargetControlID="NewEmployeeZipCode" Mask="99999" runat="server" />
        <br />
        <br />

        <asp:Label ID="NewEmployeeHireDate1" runat="server" ClientIDMode="Static" CssClass="InputLabels">Hire Date:</asp:Label>
        <asp:TextBox ID="NewEmployeeHireDate" runat="server" TextMode="Date" />
        <br />
        <br />

    </div>
    <asp:Button ID="CreateNewEmployee" runat="server" Text="Submit" OnClick="CreateNewEmployeeClick" />
</asp:Content>
