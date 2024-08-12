<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="gestao_associar1.aspx.cs" Inherits="Projetoteste.gestao_associar1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
.main {
    display: flex;
    flex-direction: column;
}

.section-box {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
        margin: 40px 10% 7px 10%;
}

.section-box .title {
    font-size: 20px;
    font-weight: bold;
    margin: 0 0 0 10px;
}

.section-box hr {
    margin-top: 20px;
}


.button {
    background-color: #F79E74; /*#4CAF50;*/
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    position: absolute; /*absolute; */
    /*left: 50%;*/
    transform: translateX(-50%);
    bottom: 20px;
}

.button:hover {
    background-color: #FF7F50;
    cursor: pointer;
}

.footer {
    margin: 15px 0 15px 0;
    background-color: orange;
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="main">
                <h1 style="margin: 85px 0 0 40%;">ASSOCIAÇÃO</h1>
                <%--section Associar Módulo ao Curso--%>
                <section class="section-box">
                    <div class="title">Associar Módulos ao Curso</div>
                    <div style="margin: 10px 0 0 10px;">
                        Escolha o Curso
                    </div>

                    <div style="margin: 10px 0 0 10px;">
                        <asp:UpdatePanel ID="UpdatePanelDropdown" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddl_escolher" runat="server" OnSelectedIndexChanged="ddl_escolher_SelectedIndexChanged" DataSourceID="SqlDataSource2" DataTextField="nome_curso" DataValueField="cod_curso" Style="border: 1px solid #ccc; border-radius: 5px;" AutoPostBack="True"></asp:DropDownList>

                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [cursos]  ORDER BY [nome_curso]"></asp:SqlDataSource>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="ddl_escolher" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <div style="margin: 10px 0 0 10px;">
                            ASSOCIAR MÓDULOS
                        </div>
                        <div clss="container" style="margin: 10px 0 0 10px;">
                            <asp:UpdatePanel ID="UpdatePanelContent" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div>
                                        <asp:ListBox ID="lb_modulos" runat="server" Style="border: 1px solid #ccc; border-radius: 5px;" DataSourceID="SqlDataSource3" DataTextField="nome_modulo" DataValueField="cod_modulo" SelectionMode="Multiple"></asp:ListBox>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [modulos] ORDER BY [nome_modulo]"></asp:SqlDataSource> 
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div style="margin: 10px 0 0 10px;">**Para escolher mais de um item, segure a tecla Ctrl e clique nos itens desejados</div>
                        <div>
                            <asp:Button ID="btn_associar" runat="server" Text="Salvar" OnClick="btn_associar_Click" Style="background-color: #F79E74; color: white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0 5px 50px; left: 50%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColo='#F79E74'" />
                        </div>
                        <asp:HiddenField ID="hfHorasTotaisCurso" runat="server" />
                        <div>
                            <asp:Label ID="lbl_horas_totais" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            <asp:Label ID="lbl_horas_selecionadas" runat="server" Text=""></asp:Label>
                        </div>
                        <div style="font-weight: bold; margin: 10px 0 10px 0;">
                            <asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label>
                        </div>
                </section>
                <%--/section Associar Módulo ao Curso--%>
    </script>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [cursos]"></asp:SqlDataSource>
                    </div>

<%--                <div>
                    <asp:Button ID="Button1" Text="Ir para ?" Style="background-color: #F79E74; color: white; border: none; border-radius: 4px; padding: 7px 20px; right: 30%; margin: 15px 0 50px 1320px; /*left: 80%; */ bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;"
                        onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server" />
                </div>--%>

            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btn_associar" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

    <%--/main--%>
    <%-- modal da instrução--%>
    <%--<script type="text/javascript">
            function handleDropDownListPostBack() {
                // Atualiza manualmente o UpdatePanel quando a DropDownList é clicada
                __doPostBack('<%= UpdatePanel1.ClientID %>', '');
            }
    </script>--%>

    <script type="text/javascript">

        $(document).ready(function () {
            var selectedModules = []; // Lista para armazenar os valores selecionados

            $("#<%= lb_modulos.ClientID %>").change(function () {
                // Atualiza a lista de valores selecionados
                selectedModules = [];
                $("#<%= lb_modulos.ClientID %> option:selected").each(function () {
                    selectedModules.push($(this).val());
                });

                atualizarHoras(selectedModules);
            });
        });

        function atualizarHoras(cod_modulos) {
            $.ajax({
                type: "POST",
                url: "gestao_associar1.aspx/ObterDuracaoDosModulos",
                data: JSON.stringify({ cod_modulos: cod_modulos }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    debugger
                    var horasSelecionadas = parseInt(response.d);
                    $("#<%= lbl_horas_selecionadas.ClientID %>").text("Horas selecionadas: " + horasSelecionadas);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.responseText);
                }
            });
        }

        //função para selecionar a lb_alunos
        function enviarAlunosSelecionados() {
            var alunosSelecionados = $('#lb_alunos').val(); // Obter os valores selecionados na lista
            $.ajax({
                type: 'POST',
                url: 'gestao_associar1.aspx', // Substitua pelo URL do seu script do lado do servidor
                data: { alunos: alunosSelecionados },
                success: function (response) {
                    // Lidar com a resposta do servidor, se necessário
                    console.log(response);
                },
                error: function (error) {
                    console.error('Erro ao enviar alunos selecionados:', error);
                }
            });
        }
    </script>
</asp:Content>
