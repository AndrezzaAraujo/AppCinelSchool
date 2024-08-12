<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="alterarsenha.aspx.cs" Inherits="Projetoteste.alterarsenha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--Content--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>                  
        <div class="container" style="text-align: center; margin-top: 100px;">
            <div style="margin-bottom:30px;">
                <h1>Alteração de palavra-passe</h1></div>
            <p style="margin-bottom:15px;">Palavra-passe atual </p>
            <asp:TextBox ID="tb_atualPw" width="30%"  runat="server" TextMode="Password"></asp:TextBox>
            <p style="margin-bottom:15px; margin-top:15px;">Nova palavra-passe </p>
            <asp:TextBox ID="tb_newPw" width="30%" runat="server" TextMode="Password"></asp:TextBox>
            <p style="margin-bottom:15px; margin-top:15px;">Confirme nova palavra-passe </p>
            <asp:TextBox ID="tb_confNewPw" width="30%"  runat="server" TextMode="Password"></asp:TextBox>
            <div style="margin-bottom:15px; margin-top:30px;">
                <asp:Button ID="btn_changePw" CssClass="buttom" Text="Alterar palavra-passe" OnClick="btn_changePw_Click" style="background-color: #F79E74; color:white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0 5px 200px; left: 40%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server"  /></div>
            <div style="margin-top:15px;">
                <asp:Label ID="lbl_mensagem" Font-Bold="true" Text="" runat="server" ></asp:Label></div>
        </div>
             </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btn_changePw" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <%--/Content--%>
</asp:Content>
