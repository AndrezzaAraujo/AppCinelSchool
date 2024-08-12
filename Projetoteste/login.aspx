<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Projetoteste.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title></title>
        <!-- CSS -->
        <%--<link rel="stylesheet" href="css/style.css"/>--%>
                
        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'/>
<style>
/* Google Fonts - Poppins */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

/*body{
    overflow:hidden;
    padding: 0;
    margin: 0;
}*/

.container{
    height: 100vh;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #f2d7b1; /*background-color: #4070f4;*/ /*#E68341*/  /* COR DO FUNDO DA PÁGINA */    
    background-image:url(img/cinel_Banner22_recortado.jpg);
    background-size: cover;
    background-repeat: no-repeat;
    /*opacity: 0.5;*/
    column-gap: 30px;
}

.form{
    position: absolute;
    max-width: 430px;
    width: 100%;
    padding: 30px;
    border-radius: 6px;
    background: #fff;
}

.form.signup{
    opacity: 0;
    pointer-events: none;
}

.forms.show-signup .form.signup{
    opacity: 1;
    pointer-events: auto;
}

.forms.show-signup .form.login{
    opacity: 0;
    pointer-events: none;
}

header{
    font-size: 28px;
    font-weight: 600;
    color: #232836;
    text-align: center;
}

form{
    margin-top: 30px;
}

.form .field{
    position: relative;
    height: 50px;
    width: 100%;
    margin-top: 20px;
    border-radius: 6px;
}

.field input,
.field button{
    height: 100%;
    width: 100%;
    border: none;
    font-size: 16px;
    font-weight: 400;
    border-radius: 6px;
}

.field input{
    outline: none;
    padding: 0 15px;
    border: 1px solid#CACACA;
}

.field input:focus{
    border-bottom-width: 2px;
}

.eye-icon{
    position: absolute;
    top: 50%;
    right: 10px;
    transform: translateY(-50%);
    font-size: 18px;
    color: #8b8b8b;
    cursor: pointer;
    padding: 5px;
}

.field button{
    color: #fff;
    background-color: #0171d3;
    transition: all 0.3s ease;
    cursor: pointer;
}

.field button:hover{
    background-color: #016dcb;
}

.form-link{
    text-align: center;
    margin-top: 10px;
}

.form-link span,
.form-link a{
    font-size: 14px;
    font-weight: 400;
    color: #232836;
}

.form a{
    color: #0171d3;
    text-decoration: none;
}

.form-content a:hover{
    text-decoration: underline;
}

.line{
    position: relative;
    height: 1px;
    width: 100%;
    margin: 36px 0;
    background-color: #d4d4d4;
}

.line::before{
    content: 'Or';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #FFF;
    color: #8b8b8b;
    padding: 0 15px;
}

.media-options a{
    display: flex;
    align-items: center;
    justify-content: center;
}

a.facebook{
    color: #fff;
    background-color: #4267b2;
}

a.facebook .facebook-icon{
    height: 28px;
    width: 28px;
    color: #0171d3;
    font-size: 20px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #fff;
}

.facebook-icon,
img.google-img{
    position: absolute;
    top: 50%;
    left: 15px;
    transform: translateY(-50%);
}

img.google-img{
    height: 20px;
    width: 20px;
    object-fit: cover;
}

a.google{
    border: 1px solid #CACACA;
}

a.google span{
    font-weight: 500;
    opacity: 0.6;
    color: #232836;
}

@media screen and (max-width: 400px) {
    .form{
        padding: 20px 10px;
    }    
}

/*.max-width{
    background-image:url(img/cinel_Banner22_recortado.jpg);
    background-size: cover;
    background-repeat: no-repeat;
    width: 100vw;
    height: 100vh;
    margin: 0 auto;
    background-color: #fff;
}*/

</style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="max-width"></div>
      <section class="container forms">
            <!-- Login Form -->
            <div class="form login">
                <div class="form-content">
                    <%--<div style="margin: 0 0 0 40%;" ><asp:Image ID="Image1" width="50px" height="50px" ImageUrl="~/img/logo_cinel.jpeg" runat="server" /></div>--%>
                    <header>Login</header>
                    <div action="#">
                        <div class="field input-field">                           
                            <asp:TextBox ID="nome" placeholder="Nome" class="input" runat="server"></asp:TextBox>
                        </div>
                        <div class="field input-field">                            
                            <asp:TextBox ID="password" placeholder="Palavra-Passe" class="password" runat="server" TextMode="Password"></asp:TextBox>                           
                        </div>
                        <div class="form-link">
                            <a href="recuperar.aspx" class="forgot-pass">Esqueceu a senha?</a> <%--redireciona em html--%>
                        </div>                         
                        <div class="field button-field">
                           <%-- <button>Login</button>--%>
                            <asp:Button ID="btn_login" runat="server" Text="Login" OnClick="btn_login_Click" ValidationGroup="loginValidation" />
                             <%--Validações Login--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="nome" ErrorMessage="Nome obrigatório." ForeColor="White" ValidationGroup="loginValidation">*</asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="password" ErrorMessage="Palavra-passe inválida." ForeColor="White" ValidationGroup="loginValidation">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-link">
                        <span>Já tem uma conta? <a href="#" class="link signup-link">Registe-se</a></span><br />
                        <span><a href="index.aspx"> Voltar a página inicial.</a></span> <br /> 
                        <asp:Label ID="lbl_mensagem1" Font-Bold="True" Text="" runat="server" ></asp:Label>
                    </div>
                </div>
                <div class="line"></div>                
                <div class="media-options">
                    <a href="#" class="field google"> <%--REDIRECIONA PARA AUTENTICACAO DO GOOGLE--%>
                        <img src="./img/google.png" alt="google" class="google-img"/>
                        <span>Login com Google</span>
                    </a>
                   <%-- <asp:Label ID="lbl_mensagem1" runat="server" Text=""></asp:Label>--%>
                    <%--<asp:ValidationSummary ID="ValidationSummary3" class="message" style="margin-top:30px;" runat="server" />--%>
                </div>
                <%--<asp:Label ID="Label2" runat="server" Text=""></asp:Label>--%>
                <asp:ValidationSummary ID="ValidationSummary1" class="message" style="margin-top:30px;" runat="server" />
            </div>

            <!-- Signup Form -->
            <div class="form signup">
                <div class="form-content">
                   <%-- <div style="margin: 0 0 0 40%;" ><asp:Image ID="Image2" width="50px" height="50px" ImageUrl="~/img/logo_cinel.jpeg" runat="server" /></div>--%>
                    <header>Registo</header>
                    <div action="#">
                        <div class="field input-field">                        
                            <asp:TextBox ID="name" placeholder="Nome" class="input" runat="server"></asp:TextBox>
                        </div>
                        <div class="field input-field">                           
                            <asp:TextBox ID="tb_email" placeholder="Email" class="input" runat="server"></asp:TextBox>
                        </div>
                        <div class="field input-field">                           
                            <asp:TextBox ID="tb_password" placeholder="Crie palavra_passe com 8 dígitos" class="password" runat="server" TextMode="Password"></asp:TextBox>
                        </div>              
                        <asp:Label ID="lbl_mensagem2" Font-Bold="True" Text="" runat="server" ></asp:Label>
                        <div class="field button-field">                            
                            <asp:Button ID="signup" runat="server" Text="Registar" OnClick="signup_Click" ValidationGroup="signupValidation" /><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tb_password" ErrorMessage=" Palavra-Passe deve ter 8 dígitos/Palavra-passe inválida." ForeColor="White" ValidationGroup="signupValidation">*</asp:RequiredFieldValidator>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tb_email" ErrorMessage="E-mail inválido." ForeColor="White" ValidationGroup="signupValidation">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tb_email" ErrorMessage="" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="signupValidation"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="name" ErrorMessage="Nome obrigatório." ForeColor="White" ValidationGroup="signupValidation">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-link">
                        <span>Já tem uma conta? <a href="#" class="link login-link">Login</a></span><br />
                        <span><a href="index.aspx"> Voltar a página inicial</a></span>
                    </div>                    
                </div>
                <div class="line"></div>                
                <div class="media-options">
                    <a href="#" class="field google"><%--REDIRECIONA PARA AUTENTICACAO DO GOOGLE--%>
                        <img src="./img/google.png" alt="google" class="google-img" />
                        <span>Login com Google</span>
                    </a>                    
                    <asp:ValidationSummary ID="ValidationSummary2" class="message" Style="margin-top: 30px;" runat="server" />
                </div>                
            </div>
        </section>
    </form>
    <!-- JavaScript -->
        <%--<script src="js/script.js"></script>--%>
    <script>
        const forms = document.querySelector(".forms");
        const pwShowHide = document.querySelectorAll(".eye-icon");
        const links = document.querySelectorAll(".link");
        const loginForm = document.querySelector(".form.login");
        const signupForm = document.querySelector(".form.signup");

        pwShowHide.forEach(eyeIcon => {
            eyeIcon.addEventListener("click", () => {
                let pwFields = eyeIcon.parentElement.parentElement.querySelectorAll(".password");

                pwFields.forEach(password => {
                    if (password.type === "password") {
                        password.type = "text";
                        eyeIcon.classList.replace("bx-hide", "bx-show");
                        return;
                    }
                    password.type = "password";
                    eyeIcon.classList.replace("bx-show", "bx-hide");
                })
            })
        })

        links.forEach(link => {
            link.addEventListener("click", e => {
                e.preventDefault(); // Prevent form submission
                forms.classList.toggle("show-signup");

                // Verificar qual formulário está sendo exibido e limpar as mensagens de validação
                if (forms.classList.contains("show-signup")) {
                    loginForm.querySelector(".message").innerHTML = "";
                } else {
                    signupForm.querySelector(".message").innerHTML = "";
                }
            })
        })
    </script>
</body>
</html>
