<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Projetoteste.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

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

<style>
.logo-cinel
{
	display: flex;
	justify-content:center;
	align-items:center;
	/*margin: 0px 0 0 0;*/
}
</style>
</head>

<!--Start of Tawk.to Script-->
<script type="text/javascript">
    var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
    (function () {
        var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
        s1.async = true;
        s1.src = 'https://embed.tawk.to/65ea06808d261e1b5f6a4074/1hod2ipre';
        s1.charset = 'UTF-8';
        s1.setAttribute('crossorigin', '*');
        s0.parentNode.insertBefore(s1, s0);
    })();
</script>
<!--End of Tawk.to Script-->
																<%--PAGE SEM MASTER PAGE--%>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
		<header id="header" class="transparent-nav" style="background-color:lightgray;">
			<div class="container">

				<div class="navbar-header">
					<!-- Logo -->
					<div class="navbar-brand">
						<a class="logo" href="index.aspx">
							<img src="../main_template/img/logo_cinel_nome_sem_fundo.png" alt="logo"/>
							<%--<img src="img/logo1_transparent.png" style="width: 50px; height: 50px;" alt="logo"/>--%>
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
						<li><a href="index.aspx">Home</a></li>
						<li><a href="curso.aspx">Cursos</a></li> <%--sem page--%>							
						<%--<li><a href="blog.aspx">Blog</a></li>--%>
						<%--<li><a href="#">About</a></li>--%> <%--sem page--%>
						<%--<li><a href="contact.aspx">Sobre Nós</a></li>--%>		
						<li><a href="login.aspx">Login & Registo</a></li>  
						<%--<li><a href="login.aspx">Registe para se candidatar</a></li>--%>
					</ul>
				</nav>
				<!-- /Navigation -->
			</div>
		</header>
		<!-- /Header -->

		<%--***********************--%>

		<!-- Home -->
		<div id="home" class="hero-area">
			<!-- Backgound Image -->
			<div class="bg-image bg-parallax overlay" style="background-image:url(../main_template/img/image_redes.jpg)"></div>
			<%--<div class="bg-image bg-parallax overlay" style="background-image:url(../main_template/img/home-background.jpg)"></div>--%>
			<!-- /Backgound Image -->

			<div class="home-wrapper">
				<div class="container">
					<div class="row">
						<div class="col-md-8">
							<h1 class="white-text">Cursos de tecnologia online e presencial</h1>
							<p class="lead white-text">A tecnologia e o Futuro num só Centro.</p>							
							<%--<a class="main-button icon-button" href="#">Get Started!</a>--%> <%--button--%>
						</div>
					</div>					
				</div>
				<%--<div class="logo-cinel"><image src="./img/logo_cinelbranco_transparente.png"/></div>--%>
			</div>			
		</div>

		<!-- /Home -->
		<!-- About -->		
		<!-- /About -->
		<!-- Courses -->

		<div id="courses" class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="section-header text-center">
						<h2>Conheça nossos cursos</h2>
						<p class="lead">De Formação Modular a Curso de Especialização Tecnológica.</p>
					</div>
				</div>
				<!-- /row -->
				<!-- courses -->
				<div id="courses-wrapper">
					<!-- row -->
					<div class="row">

						<!-- 1º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/image_servidores.jpg" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/>
									<i class="course-link-icon fa fa-link"></i>
								</a>
								<a class="course-title" href="#">Servidores Web e Segurança de Redes</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: MOD-Formação Modular Certificada (Empregados)</span>
									<span class="course-price course-premium">100 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->

						<!-- 2º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/course02.jpg" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/>
									<i class="course-link-icon fa fa-link"></i>
								</a>
								<a class="course-title" href="#">Especialista em Tecnologias e Programação de Sistemas de Informação</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: CET-Curso de especialização Tecnológica</span>
									<span class="course-price course-premium">1400 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->

						<!-- 3º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/image_multimidia.png" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/> 
									<i class="course-link-icon fa fa-link"></i> 
								</a>
								<a class="course-title" href="#">Especialista em Desenvolvimento de Produtos Multimédia</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: CET-Curso de especialização Tecnológica</span>
									<span class="course-price course-premium">1500 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->

						<!-- 4º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/image_iot.jpg" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/>
									<i class="course-link-icon fa fa-link"></i>
								</a>
								<a class="course-title" href="#">IOT</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: FEC-Formação Extra CNQ </span>
									<span class="course-price course-premium">  50 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->
					</div>

					<!-- /row -->
					<!-- row -->

					<div class="row">
						<!-- 5º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img">
									<img src="../main_template/img/image_redes (2).jpg" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/> <%--link / add button? --%>
									<i class="course-link-icon fa fa-link"></i>  
								</a>
								<a class="course-title" href="#">Especialista em Gestão de Redes e Sistemas Informáticos</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: CET-Curso de especialização Tecnológica</span>
									<span class="course-price course-premium">1375 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->

						<!-- 6º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/course06.jpg" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/>
									<i class="course-link-icon fa fa-link"></i>
								</a>
								<a class="course-title" href="#">Análise de Dados e Dashboards - Microsoft Power BI</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">FEC_Formação Extra CNQ</span>
									<span class="course-price course-premium">100 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->

						<!-- 7º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/image_dados.png" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/> 
									<i class="course-link-icon fa fa-link"></i>
								</a>
								<a class="course-title" href="#">Linguagem de Programação SQL - iniciação</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: FEC-Formação Extra CNQ</span>
									<span class="course-price course-premium">100 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->


						<!-- 8º single course -->
						<div class="col-md-3 col-sm-6 col-xs-6">
							<div class="course">
								<a href="curso.aspx" class="course-img"> <%--link / add button? --%>
									<img src="../main_template/img/robotica.jpg" alt="" style="height:175px; width:262.5px; margin:0 0 20px 0; border-radius:4px;"/> 
									<i class="course-link-icon fa fa-link"></i>
								</a>
								<a class="course-title" href="#">Especialista em Automação, Robótica e Controlo Industrial</a> <%--link / add button? --%>
								<div class="course-details">
									<span class="course-category">Tipo: CET-Curso de especialização Tecnológica</span>
									<span class="course-price course-premium">1560 horas</span>
								</div>
							</div>
						</div>
						<!-- /single course -->
					</div>
					<!-- /row -->
				</div>
				<!-- /courses -->			
			</div>
			<!-- container -->
		</div>		

		<!-- Why us -->
		<div id="why-us" class="section" style="margin-top:-10px">

			<!-- container -->
			<div class="container">

				<!-- row -->
				<div class="row">
					<div class="section-header text-center">
						<h2>Por quê Cinel?</h2>
						<p class="lead">Escola referência e acreditada.</p>
					</div>

					<!-- feature -->
					<div class="col-md-4">
						<div class="feature">
							<i class="feature-icon fa fa-flask"></i>
							<div class="feature-content">
								<h4>Cursos</h4>
								<p>Escolhas entre as modalidades Online, Presencial e B-Learning .</p>
							</div>
						</div>
					</div>
					<!-- /feature -->

					<!-- feature -->
					<div class="col-md-4">
						<div class="feature">
							<i class="feature-icon fa fa-users"></i>
							<div class="feature-content">
								<h4>Formadores </h4>
								<p>Formadores especialistas e com formação continuada.</p>
							</div>
						</div>
					</div>
					<!-- /feature -->

					<!-- feature -->
					<div class="col-md-4">
						<div class="feature">
							<i class="feature-icon fa fa-comments"></i>
							<div class="feature-content">
								<h4>Comunicação</h4>
								<p>Desenvolva habilidades além de hard-skills.</p>
							</div>
						</div>
					</div>
					<!-- /feature -->

				</div>
				<!-- /row -->
				<%--<hr class="section-hr"/>--%>
				<!-- row -->				
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /Why us -->

		<!-- Contact CTA -->
		<div id="contact-cta" class="section">

			<!-- Backgound Image -->
			<div class="bg-image bg-parallax overlay" style="background-image:url(../main_template/img/image_contato.jpg)"></div>
			<%--<div class="bg-image bg-parallax overlay" style="background-image:url(../main_template/img/cta2-background.jpg)"></div>--%>
			<!-- Backgound Image -->

			<!-- container -->
			<div class="container">

				<!-- row -->
				<div class="row">

					<div class="col-md-8 col-md-offset-2 text-center">
						<h2 class="white-text">Conecte-se connosco</h2>
						<p class="lead white-text"> Faça contato por uma de nossas redes sociais.</p>
						<%--<a class="main-button icon-button" href="#">Contact Us Now</a>--%> <%--link / add button? --%>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /Contact CTA -->
		<%--****************--%>

		<!-- Footer -->
		<footer id="footer" class="section">
			<!-- container -->
			<div class="container">
				<!-- row de cima -->
				<div class="row">					
					<!-- footer logo -->					
					<!-- footer logo -->
					<!-- footer nav -->					
					<!-- /footer nav -->
				</div>
				<!-- /row -->
				<!-- row de baixo -->
				<div id="bottom-footer" class="row">

					<!-- social -->
					<div class="col-md-4 col-md-push-8">
						<ul class="footer-social">
							<li><a href="https://www.facebook.com/cinelcentroformacaoeletronica/?locale=pt_PT" class="facebook"><i class="fa fa-facebook"></i></a></li> <%--link --%>
							<li><a href="https://twitter.com/cinel_formacao?lang=pt" class="twitter"><i class="fa fa-twitter"></i></a></li> <%--link --%>
							<%--<li><a href="#" class="google-plus"><i class="fa fa-google-plus"></i></a></li> <%--link --%>
							<li><a href="https://www.instagram.com/cinel.formacao/" class="instagram"><i class="fa fa-instagram"></i></a></li> <%--link --%>
							<li><a href="https://www.youtube.com/c/cinelptform" class="youtube"><i class="fa fa-youtube"></i></a></li> <%--link --%>
							<li><a href="https://www.linkedin.com/school/cinel-centro-forma-o-profissional-ind-stria-electr-nica-energia-telecom.-e-tec.-de-informa-o/?originalSubdomain=pt" class="linkedin"><i class="fa fa-linkedin"></i></a></li> <%--link --%>
						</ul>
					</div>
					<!-- /social -->
					<!-- copyright -->
					<div class="col-md-8 col-md-pull-4">
						<div class="footer-copyright">
							<span>&copy; <%: DateTime.Now.Year %> All Rights Reserved | Made by <a href="https://www.linkedin.com/in/andrezza-araujo-/">Andrezza Araujo</a> e <a href="https://www.linkedin.com/in/mariana-carvalho-376019175/">Mariana Carvalho</a></span>
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
		<div id='preloader'><div class='preloader'></div></div>
		<!-- /preloader -->		
    </form>
	<!-- jQuery Plugins -->
		<script type="text/javascript" src="../main_template/js/jquery.min.js"></script>
		<script type="text/javascript" src="../main_template/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../main_template/js/main.js"></script>
</body>
</html>