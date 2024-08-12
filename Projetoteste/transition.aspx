<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="transition.aspx.cs" Inherits="Projetoteste.transition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- The above 3 meta tags must come first in the head; any other head content must come after these tags -->   
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

    <!-- Required meta tags body template -->
    <link rel="icon" type="image/x-icon" href="favicon.ico">
    <!-- Bootstrap CSS body template -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/style.css">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="text-align: center; margin-top: 60px; margin-bottom: 35px;">

        <h1><asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label></h1>

        <section id="services" class="text-center">
            <div class="container">

                <%--<div style="margin: 30px 0 0 0;"></div>--%>

                <div class="row">
                    <div class="col-12">
                        <div class="intro">
                            <h6></h6>
                            <h1>Bem-vindo(a) à Intranet da escola Cinel!</h1>
                            <%-- <p class="mx-auto">Contrary to popular belief, Lorem Ipsum is not simply random text. It has
                            roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old</p>--%>
                        </div>
                    </div>
                </div>

                <div style="margin: 0 0 60px 0;"></div>

                <div class="row g-4">

                    <div class="col-lg-4 col-md-6">

                        <div class="service"><%--1º quadro--%>                            
                            <img src="../intra_template/img/icon1.png" alt="">
                            <h5>Intranet</h5>
                            <p>
                                Encontre aqui o que você precisa para gerir melhor seu tempo e estudo.
                                <br />
                                <%--Juntos fazemos um futuro melhor! --%>
                            </p>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="service"><%--2º quadro--%>                            
                            <img src="../intra_template/img/icon2.png" alt="">
                            <h5>Área Formando</h5>
                            <p>Acompanhe o calendário de aulas, e as avaliações. </p>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="service"><%--3º quadro--%>                            
                            <img src="../intra_template/img/icon3.png" alt="">
                            <h5>Área Candidato</h5>
                            <p>
                                Faça inscrição no curso favorito e aceda seus dados.
                               <%-- Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of
                            classical Latin literature from--%>
                            </p>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="service"><%--4º quadro--%>                            
                            <img src="../intra_template/img/icon4.png" alt="">
                            <h5>Junte-se a nós</h5>
                            <p>
                                Crie sua história de sucesso connosco.</br>
                                Juntos fazemos um futuro melhor!
                                <%--Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of
                            classical Latin literature from--%>
                            </p>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="service"><%--5º quadro--%>                            
                            <img src="../intra_template/img/icon5.png" alt="">
                            <h5>Área Formador</h5>
                            <p>Planeie sua disponibilidade, aulas, e aceda seus dados.</p>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="service"><%--6º quadro--%>                            
                            <img src="../intra_template/img/icon6.png" alt="">
                            <h5>Área Secretaria</h5>
                            <p>Crie, gira e acompanhe toda a performance escolar.</p>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</asp:Content>
