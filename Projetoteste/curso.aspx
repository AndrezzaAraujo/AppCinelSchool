<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="curso.aspx.cs" Inherits="Projetoteste.curso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="../main_template/js/bootstrap.min.js"></script>
<style>
.logo-cinel {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 0 0 0;
}

/* Estilo para a seção de filtros */
.filter-section {
	background-color: #e4e6df;
	padding: 20px;
	border-radius: 5px;
	margin: 195px 0 5px 0;
	position: relative;
	margin-top: 50px
}

/* Estilo para os rótulos */
.filter-section label {
	display: block;
	margin-bottom: 5px;
}

/* Estilo para os campos de entrada e seleção */
.filter-section input[type="text"],
.filter-section input[type="date"],
.filter-section select {
	width: 100%;
	padding: 8px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	background-color: white;
}

/* Estilo para o botão de pesquisa */
.search-button {
	background-color: #F79E74;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	position: absolute;
	margin: 5px 160px 40px 5px;
	right: 20px;
	bottom: -5px;
}

	.search-button:hover {
		background-color: #FF7F50;
	}

/***** CSS */

.roundend-button {
	background-color: #EE3E63;
	background-position: 0% 0%;
	color: #FFFFFF;
	cursor: pointer;
	height: 30px; /*43px*/
	border: 1px solid #ED3D62;
	padding: 6px 12px 6px 12px;
	transform: none;
	transition: all 0.3s ease-in-out 0s;
	outline: rgb(255, 255, 255) dashed 0px;
	box-sizing: border-box;
	border-top-left-radius: 4px;
	border-top-right-radius: 4px;
	border-bottom-left-radius: 4px;
	border-bottom-right-radius: 4px;
}

/*  card  */
#container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

#wrapper {
	position: relative; /*relative*/
	display: grid; /*flex*/
	align-items: flex-start; /*center*/
	justify-content: center;
	float: left; /*left*/
}

#line-beside {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 30px 0 25px 0;
}

.card {
	background: white; /*background-image: linear-gradient(0deg, #2c3e50 0%, #16a085 100%);*/
	border: 2px solid #e4e6df; /* Borda sólida de 2px de espessura com cor cinza escuro */
	border-radius: 10px; /* Raio de 10px para arredondar as bordas */
	width: 350px;
	height: 385px;
	margin: 20px;
	position: relative;
	overflow: auto; /*scroll;*/ /*overflow: hidden;*/
}

.card-title {
	padding-top: 10px;
	padding-left: 15px;
	margin: 8px 0;
	margin-bottom: 20px;
	font-weight: 300;
	font-size: 1.875em;
	text-align: center; /* Centralizar o texto */
}

h1 {
	margin-right: 5px;
	font: bold;
	font-size: 30px;
}

.card-text {
	margin: 0 70px 0 0;
}

.card img.card-image {
	width: 100%;
	height: 20%; /* Define a altura da imagem como 50% do card */
	object-fit: cover;
	position: absolute; /* Posiciona a imagem de forma absoluta */
	top: 0; /* Alinha a imagem ao topo do card */
	left: 0; /* Alinha a imagem à esquerda do card */
}

.card-meta {
	padding-left: 15px;
	margin: 0 15px 0 0; /*não está funcionando*/
	font-size: 0.6875em;
	line-height: 1.7;
	letter-spacing: 1px;
	text-transform: uppercase;
}

.btn-saibamais {
	background-color: #F79E74; /*#4CAF50;*/
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	position: absolute; /*absolute; */
	left: 50%;
	transform: translateX(-50%);
	bottom: 15px; /* Ajuste a posição vertical conforme necessário */
}

.card-meta::after before {
	content: "";
	height: 1px;
	width: 30px;
	background-color: #fff;
	position: relative;
	display: block;
	margin-bottom: 10px;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
	opacity: 0;
	transform: translate(0, -10px);
	transition: all 200ms cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.card a:hover .card-text {
	background-color: rgba(17, 17, 17, 0.86); /*rgba(17, 17, 17, 0.86)*/ /* COLOR*/
}

.card a:hover .card-meta:before {
	transform: translate(0, 0);
	opacity: 1;
	transition: all 200ms cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.card a:hover .card-image {
	transform: translate(20px, 0);
	transition: all 400ms cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.page-number {
	order: 5;
	display: flex;
	justify-content: center;
	align-items: center;
}


#lbtn_next {
	/* background: #FFff;*/
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
}

/*modal*/
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover,
.close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>
</head>
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
						<li><a href="login.aspx">Login & Registo</a></li>  
					</ul>
				</nav>
				<!-- /Navigation -->
			</div>
		</header> 
		<!--/ Header -->
		<div>			
	 <!-- Sessão Pesquisas -->
    <div class="filter-section">
        <h2 style="margin: -5px 0 10px 0;">Encontre um curso: </h2>
        <div id="filterForm" runat="server">
            <div class="form-group" style="display: inline-block; width: 40%; margin: 0 60px 0 0;">			
                <asp:TextBox ID="tb_search" BackColor="White" runat="server"></asp:TextBox>
            </div>
			<div class="form-group" style="display: inline-block; width: 33%;">
                <asp:ImageButton ID="img_lupa" src="img/icon_search.png" alt="pesquisar" Style="width: 25px; height: 25px; margin:10px 0 0 0;" runat="server" Onclick="img_lupa_Click" title="Pesquisar" />
				<asp:ImageButton ID="img_retornar" src="img/icon-eraser2.png" alt="limpar pesquisa" Style="width: 25px; height: 25px; margin:10px 0 0 30px;" runat="server" title="Limpar" OnClick="img_retornar_Click"/>				
            </div>                                          
            <div class="form-group" style="display: inline-block; width: 33%;">
            <asp:Label ID="lbl_cursosADecorrer" runat="server" Text="Cursos que estão a decorrer"></asp:Label>
                <asp:DropDownList ID="ddl_cursosADecorrer" runat="server" OnSelectedIndexChanged="ddl_cursosADecorrer_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="form-group" style="display: inline-block; width: 33%;">
            <asp:Label ID="lbl_cursosAIniciar" runat="server" Text="Cursos a iniciar nos próximos 60 dias"></asp:Label>
                <asp:DropDownList ID="ddl_cursosAIniciar" runat="server" OnSelectedIndexChanged="ddl_cursosAIniciar_SelectedIndexChanged"> 
					<asp:ListItem Value="0">Menor Preco</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>
            </div>            
            </div>                
        </div>    
    <!-- /Sessão Pesquisas -->       
        <div id="line-beside">
            <h1 style="margin:30px 0 25px 0"; >Cursos</h1>
        <div class="line"></div>
        </div>
		</div>
        <div id="container">
			<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
			<asp:UpdatePanel ID="UpdatePanel1" runat="server">
				<ContentTemplate>
		<div id="myModal" class="modal">
			<div class="modal-content">
				<span class="close">&times;</span>
				<p id="descricao"></p>
				<p>Para inscrever, registre-se <a href="login.aspx">aqui</a>.</p>
			</div>
		</div>
        <%--repeater--%>		
        <asp:Repeater ID="rpt_cursos" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="rpt_cursos_ItemCommand">          
            <ItemTemplate>  
			      <div id="wrapper">
                    <article class="card" role="article">
                        <div class="card-text">                        
                            <h2 class="card-title"disable-output-escaping="yes"> <%-- não importa o que esteja aqui add. disable-output-escaping="yes"--%>
                                <%# Eval("nome_curso") %><%--EVAL nome curso--%></h2>
                            <div class="card-meta">
                                <strong>Horário: </strong><%# Eval("horario") %></div>
                            <div class="card-meta">
                                <strong>Local: </strong><%# Eval("local") %></div>
                            <div class="card-meta">
                                <strong>Tipo: </strong><%# Eval("tipo") %></div>
                            <div class="card-meta">
                                <strong>Área: </strong><%# Eval("area") %></div>
                            <div class="card-meta">
                                <strong>Modalidade: </strong><%# Eval("modalidade") %></div>
                            <div class="card-meta">
                                <%# Eval("qtd_horas") %> <strong> horas</strong></div>
                            <div style="justify-content: center; display: flex; ">
							 <div class="card-meta">
								<asp:Button ID="btn_descricao" CommandName="saibaMais" CommandArgument='<%# Eval("descricao") %>' data-descricao='<%# Eval("descricao") %>' aria-hidden="true" Text="Descrição" CssClass="btn-saibamais" runat="server" /></div>
                            <div >
                        </div>
                    </article>
                </div>
            </ItemTemplate>        
        </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [cursos]" EnableCaching="false"></asp:SqlDataSource>
				</ContentTemplate>
					<Triggers>
						<asp:AsyncPostBackTrigger ControlID="img_lupa" EventName="Click" />
						<%--<asp:AsyncPostBackTrigger ControlID="img_limpar" EventName="Click"/>--%>
						<asp:AsyncPostBackTrigger ControlID="img_retornar" EventName="Click" />
					</Triggers>
				</asp:UpdatePanel>
        </div>
        <%--/repeater--%>
        <%--paginação--%>
        <div class="page-number" style="display: flex; justify-content: center;margin: 20px 0 30px 0;">
            <asp:LinkButton ID="lbtn_previous" style="" OnClick="lbtn_previous_Click" runat="server" UseSubmitBehavior="false" >Anterior</asp:LinkButton>&nbsp;&nbsp;
            <asp:Label ID="lbl_pageNumber" style="" runat="server"></asp:Label>&nbsp;&nbsp;
            <asp:LinkButton ID="lbtn_next" style="" Onclick="lbtn_next_Click" runat="server" UseSubmitBehavior="false">Próximo</asp:LinkButton>
        </div>       
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
							<span>&copy; Copyright 2024. All Rights Reserved. | Made by <a href="https://www.linkedin.com/in/andrezza-araujo-/">Andrezza Araujo</a> e <a href="https://www.linkedin.com/in/mariana-carvalho-376019175/">Mariana Carvalho</a>.</span>
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

		<%--JS Paginação--%>
        <script>
            var currentPage = 1;
            var cardsPerPage = 6;
            var cards = document.querySelectorAll('.card');

            function showCards(page) {
                var start = (page - 1) * cardsPerPage;
                var end = start + cardsPerPage;

                for (var i = 0; i < cards.length; i++) {
                    if (i >= start && i < end) {
                        cards[i].style.display = 'block';
                    } else {
                        cards[i].style.display = 'none';
                    }
                }

                document.getElementById('<%= lbl_pageNumber.ClientID %>').innerText = 'Página ' + page;

                /* Esconde o botão "Anterior" se estiver na página 1*/
                if (page === 1) {
                    document.getElementById('<%= lbtn_previous.ClientID %>').style.display = 'none';
                } else {
                    document.getElementById('<%= lbtn_previous.ClientID %>').style.display = 'inline-block';
                }

                // Esconde o botão "Próximo" se estiver na última página
                var totalCards = cards.length;
                var totalPages = Math.ceil(totalCards / cardsPerPage);
                if (page === totalPages) {
                    document.getElementById('<%= lbtn_next.ClientID %>').style.display = 'none';
                } else {
                    document.getElementById('<%= lbtn_next.ClientID %>').style.display = 'inline-block';
                }
            }

            function nextPage() {
                event.preventDefault(); // Evita o comportamento padrão do navegador (postback)
                var totalCards = cards.length;
                var totalPages = Math.ceil(totalCards / cardsPerPage);

                if (currentPage < totalPages) {
                    currentPage++;
                    showCards(currentPage);
                }
                /*return false;*/
            }

            function prevPage() {
                event.preventDefault(); // Evita o comportamento padrão do navegador (postback)
                if (currentPage > 1) {
                    currentPage--;
                    showCards(currentPage);
                }
                /* return false;*/
            }

            document.getElementById('<%= lbtn_previous.ClientID %>').addEventListener('click', prevPage);
            document.getElementById('<%= lbtn_next.ClientID %>').addEventListener('click', nextPage);

            // Chame a função showCards com a página inicial
            showCards(currentPage);

            // JS para pesquisa
            //associa o manipulador do evento click ao elemento da lupa pelo ID
            $("#<%= img_lupa.ClientID %>").click(function (event) {
                // Impede o envio do formulário padrão
                event.preventDefault();

                //obtém a palavra-chave digitada pelo usuário
                var palavra = $("#<%= tb_search.ClientID %>").val().trim().toLowerCase();

                // Oculta todos os cards
                $(".card").hide();

                // Itera sobre cada card para verificar se corresponde à palavra-chave
                $(".card").each(function () {
                    // Obtém o texto do título do card
                    var titulo = $(this).find(".card-title").text().trim().toLowerCase();

                    // Verifica se a palavra-chave está contida no título do card
                    if (titulo.indexOf(palavra) >= 0) {
                        // Exibe o card se o título corresponder à palavra-chave
                        $(this).show();
                    }
                });
            });

            // Array para armazenar os IDs dos cards ocultados
            var cardsOcultados = [];

            // Função para recarregar os dados originais dos cards
            function recarregarDadosOriginais() {
                // Faça uma chamada ao servidor para recuperar os dados originais do banco de dados
                $.ajax({
                    type: "GET",
                    url: "SeuEndpointParaRecarregarOsDados",
                    success: function (data) {
                        // Limpe os cards existentes
                        $(".card").remove();

                        // Preencha os cards com os novos dados
                        data.forEach(function (curso) {
                            var cardHtml = `<div class="card" id="card_${curso.cod_curso}">
                                    <!-- Conteúdo do card -->
                                </div>`;
                            $("#container_cards").append(cardHtml);
                            // Adicione o conteúdo aos cards, conforme necessário
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error("Erro ao recarregar os dados:", error);
                    }
                });
            }

            //** JS - Modal **
            // Obtenha o modal
            document.addEventListener("DOMContentLoaded", function () {
                // Obtenha o modal
                var modal = document.getElementById("myModal");

                // Obtenha o elemento de fechamento do modal
                var span = document.getElementsByClassName("close")[0];

                // Adicione um manipulador de eventos de clique para cada botão de descrição
                var buttons = document.querySelectorAll('.btn-saibamais');
                buttons.forEach(function (button) {
                    button.addEventListener('click', function (event) {
                        console.log("Botão clicado"); // Verifica se o evento de clique está sendo capturado
                        event.preventDefault(); // Impede o comportamento padrão do botão (submissão de formulário)
                        event.stopPropagation(); // Impede a propagação do evento de clique para o elemento pai
                        var descricao = this.getAttribute('data-descricao');
                        console.log(descricao); // Verifica se a descrição está sendo capturada corretamente
                        document.getElementById('descricao').innerHTML = descricao;
                        modal.style.display = 'block';
                    });
                });

                // o user ao clicar no 'x' ou fora do modal, fecha
                window.onclick = function (event) {
                    if (event.target == modal || event.target == span) {
                        modal.style.display = 'none';
                    }
                };
            });
        </script>
    </form>
    <!-- jQuery Plugins -->
		<script type="text/javascript" src="../main_template/js/jquery.min.js"></script>
		<script type="text/javascript" src="../main_template/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../main_template/js/main.js"></script>
</body>
</html>
