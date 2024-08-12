<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="recuperar.aspx.cs" Inherits="Projetoteste.recuperar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- The above 3 meta tags must come first in the head; any other head content must come after these tags -->
    <title></title>
    <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Lato:700%7CMontserrat:400,600" rel="stylesheet"/>
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="../main_template/css/bootstrap.min.css"/>
        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="../main_template/css/font-awesome.min.css"/>
        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="../main_template/css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
        <div>            
      <header id="header" class="transparent-nav">
        <div class="container">

                <div class="navbar-header">
                    <!-- Logo -->
                    <div class="navbar-brand">
                        <a class="logo" href="index.aspx">                           
                        </a>
                    </div>
                    <!-- /Logo -->

                    <!-- Mobile toggle -->
                    <button class="navbar-toggle">
                        <span></span>
                    </button>
                    <!-- /Mobile toggle -->
                </div>

                <!-- Navigation -->
                <nav id="nav">
                    <ul class="main-menu nav navbar-nav navbar-right">                       
                    </ul>
                </nav>
                <!-- /Navigation -->

            </div>
        </header>
        <!-- /Header -->

        <%--Content--%>
        <div class="container" style="text-align: center; margin-top: 100px;">
            <div style="margin-bottom:50px; ">
                <h1>Recupere sua Password!</h1></div>
            <p style="margin-bottom:25px;">E-mail: </p><asp:TextBox ID="tb_email" width="60%" runat="server"></asp:TextBox>            
            <div style="margin-bottom:15px; margin-top:50px;">
                <asp:Button ID="Button1" runat="server" OnClick="btn_recuperar_Click" Text="Recuperar Password"/></div>
            <div style="margin-top:15px;">
                <asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label></div>
        </div>
        <%--/Content--%>

       <%-- Footer--%>
        <footer id="footer" class="section">
            <!-- container -->
            <div class="container">

                <!-- row -->
                <div class="row">

                    <!-- footer logo -->
                    <div class="col-md-6">
                        <div class="footer-logo">                           
                        </div>
                    </div>
                    <!-- footer logo -->

                    <!-- footer nav -->
                    <div class="col-md-6">                        
                    </div>
                    <!-- /footer nav -->

                </div>
                <!-- /row -->

                <!-- row -->
                <div id="bottom-footer" class="row">

                    <!-- social -->
                    <div class="col-md-4 col-md-push-8">                       
                    </div>
                    <!-- /social -->

                    <!-- copyright -->
                    <div class="col-md-8 col-md-pull-4">
                        <div class="footer-logo">
                            <a class="logo" href="index.aspx">
                                <img src="../main_template/img/logo_cinel.jpeg" alt="logo" />
                            </a>
                            <span>&copy; Copyright 2024. All Rights Reserved. | This template is made by <a href="https://www.linkedin.com/in/andrezza-araujo-/">Andrezza</a> e <a href="https://www.linkedin.com/in/mariana-carvalho-376019175/">Mariana</a>.</span>
                        </div>
                        <div class="footer-copyright">                           
                        </div>
                    </div>
                    <!-- /copyright -->

                </div>
                <!-- row -->

            </div>
            <!-- /container -->

        </footer>
        <!-- /Footer -->

        <!-- preloader -->
        <div id='preloader'>
            <div class='preloader'></div>
        </div>
        <!-- /preloader -->            
        </div>
    </form>
    <!-- jQuery Plugins -->
    <script type="text/javascript" src="../main_template/js/jquery.min.js"></script>
    <script type="text/javascript" src="../main_template/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../main_template/js/main.js"></script>
</body>
</html>
