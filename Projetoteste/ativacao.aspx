<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ativacao.aspx.cs" Inherits="Projetoteste.ativacao" %>

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

        <div class="container" style="text-align: center; margin-top: 230px; margin-bottom: 35px;">
            <h1><asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label><%--A sua conta foi ativada com sucesso!--%></h1>
            <br />
            <br />
            <h3 class="login"><a href="login.aspx">Faça seu login aqui!</a></h3>            
                <br />
            <br />
        </div>

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
                            <span>&copy; Copyright 2024. All Rights Reserved. | Made by <a href="https://www.linkedin.com/in/andrezza-araujo-/">Andrezza</a> e <a href="https://www.linkedin.com/in/mariana-carvalho-376019175/">Mariana</a>.</span>
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
    </form>

    <!-- jQuery Plugins -->
    <script type="text/javascript" src="../main_template/js/jquery.min.js"></script>
    <script type="text/javascript" src="../main_template/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../main_template/js/main.js"></script>
</body>
</html>
