<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="inserir_gestao.aspx.cs" Inherits="Projetoteste.inserir_gestao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title></title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" />
<style>
html, body {
    max-height: 100%;
}

body, div, form, input, p {
    padding: 0;
    margin: 0;
    outline: none;
    font-family: Roboto, Arial, sans-serif;
    font-size: 16px;
    color: #000000; /* #eee         cor da letra*/
}

select option {
    color: #000000;
    background: #ffffff;
    border: none;
}

body {
    /*background: url("/uploads/media/default/0001/01/b5edc1bad4dc8c20291c8394527cb2c5b43ee13c.jpeg") no-repeat center;*/
    background-size: cover;
}

h1, h2 {
    text-transform: uppercase;
    font-weight: 400;
}

h2 {
    margin: 0 0 0 8px;
}

.main-block {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100%;
    padding: 25px;
    background: #ffffff; /* rgba(0, 0, 0, 0.5); cor interna/clara   #FF812D    */
}

.left-part, form {
    padding: 25px;
}

.left-part {
    text-align: center /* text-align: center;*/
}

.fa-graduation-cap {
    font-size: 72px;
}

form {
    background: #fff; /* rgba(0, 0, 0, 0.7); opaco cor externa/form/escuro           */
}

.title {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.info {
    display: flex;
    flex-direction: column;
}

input, select {
    padding: 5px;
    margin-bottom: 30px;
    background: transparent;
    border: none;
    border-bottom: 1px solid #eee;
}

input::placeholder {
    color: #eee;
}

option:focus {
    border: none;
}

option {
    background: black;
    border: none;
}

.checkbox input {
    margin: 0 10px 0 0;
    vertical-align: middle;
}

.checkbox a {
    color: #26a9e0;
}

.checkbox a:hover {
    color: #85d6de;
}

.btn-item, button {
    padding: 10px 5px;
    margin-top: 20px;
    border-radius: 5px;
    border: none; /*border: none;*/
    background: #F79E74;
    text-decoration: none;
    font-size: 15px;
    font-weight: 400;
    color: #fff; /* #000000 - #fff cor da letra*/
    /*cursor: pointer;*/
}

.btn-item {
    display: inline-block;
    margin: 20px 5px 0;
}

button {
    width: 100%;
    /*cursor:pointer;*/
}

button:hover, .btn-item:hover {
    background: #FF7F50; /* #4070F4  - #85d6de cor do hover*/
    /*border:solid;*/
}

@media (min-width: 568px) {
    html, body {
        height: 100%;
    }

    .main-block {
        flex-direction: row;
        height: calc(100% - 50px);
    }

    .left-part, form {
        flex: 1;
        height: auto;
    }
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <div class="main-block" style="margin-top: 50px;">
                <div class="left-part">
                    <i class="fas fa-graduation-cap"></i>                    
                    <div class="btn-group">                       
                    </div>
                    <%--botão retornar em laranja--%>
                </div>
                <div action="/">
                    <div class="title">
                        <i class="fas fa-pencil-alt"></i><%--icon--%>
                        <h2>Registo de Utilizador</h2>
                    </div>
                    <div class="info">
                        <asp:HiddenField ID="hdndataInscricao" runat="server" />                       
                        <div>
                            Perfil:
                            <asp:CheckBox ID="cbox_candidato" runat="server" />
                            Candidato
                            <asp:CheckBox ID="cbox_formando" runat="server" />
                            Formando
                            <asp:CheckBox ID="cbox_formador" runat="server" />
                            Formador
                            <asp:CheckBox ID="cbox_secretaria" runat="server" />
                            Secretaria
                        </div>
                        <br />
                        <div style="width: 700px;">
                            Nome:
                            <asp:TextBox ID="tb_nome" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            Email:
                            <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            Palavra-Passe:
                            <asp:TextBox ID="tb_password" placeholder="Crie palavra-passe com mínimo 8 dígitos" runat="server" TextMode="Password"></asp:TextBox>
                        </div>

                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tb_password" ErrorMessage="Palavra-passe deve ter 8 digitos/Palavra-passe inválida." ForeColor="DarkGray"></asp:RegularExpressionValidator>--%>
                        <div>
                            NIF:
                            <asp:TextBox ID="tb_nif" placeholder="" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            Telefone:
                            <asp:TextBox ID="tb_telefone" placeholder="" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            Morada:
                            <asp:TextBox ID="tb_morada" placeholder="" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            Foto:
                            <asp:FileUpload ID="FileUpload_foto" runat="server" />
                        </div>
                        <div class="fname">
                            Docs:
                            <asp:FileUpload ID="FileUpload_documento" runat="server" />
                        </div>
                    </div>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tb_password" ErrorMessage="**Deve preencher a palavra-passe" ForeColor="DarkGray"></asp:RequiredFieldValidator><br />
                    <asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label>
                    <br />
                    <asp:Button ID="btn_submit" type="button" Text="Submit" CssClass="btn-item" Style="width: 100%;" runat="server" OnClick="btn_submit_Click" /><br />             
                    <%--br + lbl_mensagem--%> 
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btn_submit" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
