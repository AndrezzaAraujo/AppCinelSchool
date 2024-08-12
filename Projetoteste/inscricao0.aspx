<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inscricao0.aspx.cs" Inherits="Projetoteste.inscricao0" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Educational registration form</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700"/>
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
    color: #000000; /* #eee cor da letra*/
}
select option{
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
    text-align:center/* text-align: center;*/
}
.fa-graduation-cap {
    font-size: 72px;
}
form {
    background: /*#000000;*/ /* rgba(0, 0, 0, 0.7); opaco cor externa/form/escuro           */
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
    background: #F79E74; /* #26a9e0 original */
    text-decoration: none;
    font-size: 15px;
    font-weight: 400;
    color: #fff ; /* #000000 - #fff cor da letra*/
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
    background: #FF7F50;  /* #4070F4  - #85d6de cor original hover*/
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
</head>

<body>
    <form id="form1" runat="server">
         <div class="main-block">

            <div class="left-part">
                <i class="fas fa-graduation-cap"></i>
                <h1>Inscrição</h1>                
                <div class="btn-group"></div>          
            </div>

            <div action="/">

                <div class="title">
                    <i class="fas fa-pencil-alt"></i><%--icon--%>                    
                    <h2>Candidate-se aqui</h2>
                </div>

                <div class="info">                    
                    <p style="margin-bottom:15px;"> Para se increver preencha os campos abaixo, envie uma foto e seu certificado do 12º ano.</p>
                    <asp:HiddenField ID="hdndataInscricao" runat="server" />
                    <p >Escolha o curso que deseja se increver:
                        <asp:DropDownList ID="ddl_cursos" runat="server" DataSourceID="SqlDataSource1" DataTextField="nome_curso" DataValueField="cod_curso" AutoPostBack="True"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [cursos]"></asp:SqlDataSource></p>    
                    <p>NIF: <asp:TextBox ID="tb_nif" placeholder="" runat="server"></asp:TextBox></p>
                    <p>Telefone: <asp:TextBox ID="tb_telefone" placeholder="" runat="server"></asp:TextBox></p>
                    <p>Morada: <asp:TextBox ID="tb_morada" placeholder="" runat="server"></asp:TextBox></p>                    
                    <p>Foto: <asp:FileUpload ID="FileUpload_foto" runat="server" /></p>                     
                    <p class="fname">Carregue seus docs: <asp:FileUpload ID="FileUpload_documento" runat="server" /></p>                      
                </div>
                <div class="checkbox">                    
                </div>             
                
                <div style="margin-left:auto; margin-right:auto; text-align:center; margin-top:15px;"><asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label>
                </div>
                <asp:Button ID="btn_submit" type="button" Text="Submeter" CssClass="btn-item" style="width:100%;" Onclick="btn_submit_Click" runat="server"/>
                 <%--colocar btn retorne?--%>
            </div>
        </div>
    </form>
     
    <script type="text/javascript">
        // Obter a data atual
        var dataAtual = new Date().toLocaleDateString('en-US'); // Ou qualquer outro formato desejado

        // Definir o valor do campo oculto
        document.getElementById('<%= hdndataInscricao.ClientID %>').value = dataAtual;
    </script>
</body>
</html>