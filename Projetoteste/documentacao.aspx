<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="documentacao.aspx.cs" Inherits="Projetoteste.documentacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- jQuery UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Certifique-se de incluir jQuery -->
<style>
/* Estilo para a seção de filtros */
.filter-section {
    background-color: #e4e6df;
    padding: 20px;
    border-radius: 5px;
    margin: 195px 0 5px 0;
    position: relative;
    margin-top: 10px;
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
    /*margin: 10px 0;
    border: none;
    box-shadow: 0px 0px 16px -6px rgba(0, 0, 0, .5);
    color: #fff;
    font-size: 1.25rem;
    letter-spacing: 1px;
    outline: none;
    cursor: pointer;
    width: 160px;
    height: 50px;
    border-radius: 15px;
    background-color: #EB1F4A;*/
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
    background: #F2F3EB; /*background-image: linear-gradient(0deg, #2c3e50 0%, #16a085 100%);*/
    width: 350px;
    height: 350px;
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
    /* text-align: center;*/ /* Centralizar o texto */
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
    /*-o-object-fit: cover;
    -o-object-fit: cover;
    transform: translate(0, 0);
    transition: all 400ms cubic-bezier(0.25, 0.46, 0.45, 0.94);*/
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
    /*margin: 5px 160px 40px 5px;*/
    /*right: 20px; */
    /*bottom: -5px;*/
}
    /*position: absolute;
    display: flex; 
    justify-content: center;
    background-color: #F79E74;
    border: none;
    border-radius: 3px;
    left: 50%;
    margin: 10px 0 15px 0;
    transform: translateX(-50%);
    text-align: center;*/
    /*cor do laranja mais suave #F79E74 e cor do laranja mais vivo #FF7F50*/


.btn-saibamais:hover {
    background-color: #FF7F50;
    cursor: pointer;
}

.btn-saibamais:focus {
    background: #FF7F50;
    box-shadow: none;
}

.btn-saibamais:active {
    background: #FF7F50;
    /*box-shadow: none;*/
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

/*.page-number:hover{
    background: #FF7F50;
}*/

#lbtn_next {
    background: #FF7F50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    transition: background-color 0.3s ease; /* Adicionando uma transição suave */
}

#lbtn_next:hover {
    background: #FF6347; /* Cor do background ao passar o mouse */
}


/*  css que coloquei*/
.btn-item, button {
    padding: 10px 5px;
    margin-top: 20px;
    border-radius: 5px;
    border: none;
    background: #F79E74;
    text-decoration: none;
    font-size: 15px;
    font-weight: 400;
    color: #fff; /*cor da letra*/
}

.btn-item {
    display: inline-block;
    margin: 20px 5px 0;
}

button {
    width: 100%;
}

button:hover, .btn-item:hover {
    background: #FF6700; /*cor do hover*/
}

table {
    border-collapse: collapse;
    width: 90%;
}

th, td {
    border: 1px solid #dddddd;
    text-align: left;
    /*padding: 4px;*/
}

th {
    background-color: #f2f2f2;
    cursor: col-resize; /* Altera o cursor quando o mouse passa sobre as células da primeira linha */
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
       
    <!-- Sessão Pesquisa -->  
    <%--<div class="filter-section">
        <div id="filterForm" runat="server">
            <div class="form-group" style="display: inline-block; width: 40%; margin: 30px 10px 0 0;">
                <asp:Label ID="lbl_search" Text="Pesquisar por nome" runat="server"></asp:Label>
                <asp:TextBox ID="tb_search" BackColor="White" runat="server" onkeyup="filtrarRepeater()"></asp:TextBox>
            </div>
            <div class="form-group" style="display: inline-block; width: 33%;">
                <asp:ImageButton ID="img_lupa" src="img/icon_search.png" alt="img pesquisar" title="Pesquisar" Style="width: 25px; height: 25px; margin: 10px 0 0 0;" OnClick="img_lupa_Click" runat="server" />
                <asp:ImageButton ID="img_limpar" src="img/icon-eraser2.png" alt="img limpar busca" title="Limpar" Style="width: 25px; height: 25px; margin: 10px 0 0 0; margin-left: 30px;" OnClick="img_limpar_Click" runat="server" />
            </div>
        </div>
    </div>--%>
    <!-- /Sessão Pesquisa -->  

    <div style="margin: 0 0 50px 0;"></div>

    <div style="margin: 0 0 50px 1080px; display: flex; justify-content: center; ">
        <asp:Button ID="btn_retornar" runat="server" Text="RETORNAR PÁGINA" CssClass="btn-item" OnClick="btn_retornar_Click" />
    </div>

     <div id="line-beside">
            <h1 style="margin:0 0 0 0"; >Documentação</h1>
        <div class="line"></div>
     </div>

     <div style="margin-top: 40px; margin-left:100px;">    

            <asp:Repeater ID="rpt_documentacao"   OnItemDataBound="rpt_documentacao_ItemDataBound" OnItemCommand="rpt_documentacao_ItemCommand" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
                    <table id="myTable" border="1" style="border-collapse: collapse" width="250">
                        <tr style="background-color: #e4e6df">
                            <th style="text-align: center;">ID Documento</th>
                            <th style="text-align: center;">ID Utilizador</th>                             
                            <th style="text-align: center;">Título</th>
                            <th style="text-align: center;">Tipo Doc.</th>                                                                       
                            <th style="text-align: center;">Visualizar</th>
                            <th style="text-align: center;">Editar</th>
                            <th style="text-align: center;">Deletar</th>
                        </tr>                    
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td style="text-align: center;"><asp:Label ID="lbl_cod" runat="server" Text=""></asp:Label></td>
                        <td style="text-align: center;"><asp:Label ID="lbl_codUser" runat="server" Text=""></asp:Label></td>                        
                        <td style="text-align: center;"><asp:TextBox ID="tb_titulo" runat="server"></asp:TextBox></td>
                        <td style="text-align: center;"><asp:Label ID="lbl_tipoDoc" runat="server" Text=""></asp:Label></td>                        
                        <td style="text-align: center;"><asp:Button ID="btn_visualizar" CommandName="btn_visualizar" Text="Visualizar" alt="visualizar" runat="server" /></td>                       
                        <td style="text-align: center;"><asp:ImageButton ID="btn_editar" CommandName="btn_editar" CssClass="btn-editar" ImageUrl="~/img/icon_edit.png" alt="editar" runat="server" /></td>
                        <td style="text-align: center;"><asp:ImageButton ID="btn_deletar" CommandName="btn_deletar" CssClass="btn-deletar" ImageUrl="~/img/icon_delete2.png" alt="deletar"  runat="server" /></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [documentos]"></asp:SqlDataSource>
                    <asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label>
          </ContentTemplate>
        <Triggers>            
        </Triggers>
    </asp:UpdatePanel>      

    <div class="page-number" style="display: flex; justify-content: center;margin: 20px 0 30px 0;">
            <asp:LinkButton ID="lbtn_previous" style="" OnClick="lbtn_previous_Click1" runat="server" UseSubmitBehavior="false" >Anterior</asp:LinkButton>&nbsp;&nbsp;
            <asp:Label ID="lbl_pageNumber" style="" runat="server"></asp:Label>&nbsp;&nbsp;
            <asp:LinkButton ID="lbtn_next" style="" OnClick="lbtn_next_Click1" runat="server" UseSubmitBehavior="false">Próximo</asp:LinkButton>
     </div>         
     
    <script>        
        /*código da pesquisa*/
            function filtrarRepeater() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("tb_search");
            filter = input.value.toUpperCase();
            table = document.getElementById("myTable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[1]; // Coluna onde está o nome
            if (td) {
                txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
                    } else {
                tr[i].style.display = "none";
                    }
                }
            }
        }

            // Função para lidar com o clique no botão de edição
            $('.btn-editar').click(function () {
            var cod_documento = $(this).attr('data-cod-documento');
            // Envie uma solicitação AJAX para editar o documento com o código fornecido
            $.ajax({
                type: "POST",
            url: "SuaPagina.aspx/EditarDocumento",
            data: JSON.stringify({cod_documento: cod_documento }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                // Manipular a resposta do servidor, se necessário
            },
            error: function (xhr, status, error) {
                // Manipular erros de requisição, se necessário
            }
            });
        });

            // Função para lidar com o clique no botão de exclusão
            $('.btn-deletar').click(function () {
            var cod_documento = $(this).attr('data-cod-documento');
            // Envie uma solicitação AJAX para excluir o documento com o código fornecido
            $.ajax({
                type: "POST",
            url: "SuaPagina.aspx/DeletarDocumento",
            data: JSON.stringify({cod_documento: cod_documento }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                // Manipular a resposta do servidor, se necessário
            },
            error: function (xhr, status, error) {
                // Manipular erros de requisição, se necessário
            }
            });
        });

            /*código da paginacao*/
            var currentPage = 1;
            var rowsPerPage = 3;
            var rows = document.querySelectorAll('#myTable tr');

            function showRows(page) {
            var start = (page - 1) * rowsPerPage;
            var end = start + rowsPerPage;

            for (var i = 1; i < rows.length; i++) {
                if (i >= start && i < end) {
                rows[i].style.display = 'table-row';
                } else {
                rows[i].style.display = 'none';
                }
            }

            document.getElementById('<%= lbl_pageNumber.ClientID %>').innerText = 'Página ' + page;

          // Esconde o botão "Anterior" se estiver na página 1
          if (page === 1) {
              document.getElementById('<%= lbtn_previous.ClientID %>').style.display = 'none';
            } else {
              document.getElementById('<%= lbtn_previous.ClientID %>').style.display = 'inline-block';
            }

          // Esconde o botão "Próximo" se estiver na última página
          var totalRows = rows.length - 1; // Exclui o cabeçalho da tabela
          var totalPages = Math.ceil(totalRows / rowsPerPage);
          if (page === totalPages) {
              document.getElementById('<%= lbtn_next.ClientID %>').style.display = 'none';
            } else {
            document.getElementById('<%= lbtn_next.ClientID %>').style.display = 'inline-block';
            }
        }

        function nextPage() {
            event.preventDefault(); // Evita o comportamento padrão do navegador (postback)
            var totalRows = rows.length - 1; // Exclui o cabeçalho da tabela
            var totalPages = Math.ceil(totalRows / rowsPerPage);

            if (currentPage < totalPages) {
                currentPage++;
                showRows(currentPage);
            }
        }

        function prevPage() {
            event.preventDefault(); // Evita o comportamento padrão do navegador (postback)
            if (currentPage > 1) {
                currentPage--;
                showRows(currentPage);
            }
        }

        document.getElementById('<%= lbtn_previous.ClientID %>').addEventListener('click', prevPage);
          document.getElementById('<%= lbtn_next.ClientID %>').addEventListener('click', nextPage);

          // Chama a função showRows com a página inicial
          showRows(currentPage);
    </script>
</asp:Content>
