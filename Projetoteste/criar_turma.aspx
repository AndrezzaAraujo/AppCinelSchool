<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="criar_turma.aspx.cs" Inherits="Projetoteste.criar_turma" %>

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
    /*margin-bottom: 20px;*/
    margin: 40px 10% 7px 10%;
}

.section-box .title {
    font-size: 20px;
    font-weight: bold;
    /*margin-bottom: 10px;*/
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
                
                <%--section turma--%>
                <h1 style="margin: 80px 0 0 35%;">CRIAÇÃO DE TURMA</h1>
                <section class="section-box">
                    <div class="title">Criar Turma</div>
                    <div style="margin: 10px 0 0 10px;">
                        <asp:Label ID="lbl_turma" runat="server" Text="Nome Turma"></asp:Label>
                        <asp:TextBox ID="tb_turma" runat="server"></asp:TextBox>
                    </div>
                    <div style="margin: 10px 0 0 10px;">
                        <asp:Label ID="lbl_dataInicio" runat="server" Text="Data início"></asp:Label>
                        <asp:TextBox ID="tb_dataInicio" runat="server"  Style="width: calc(30% - 3px); display: inline-block;" TextMode="Date"></asp:TextBox>
                        <asp:Label ID="lbl_dataFim" runat="server" Textstyle="margin-left:argin-left: 220px;"></asp:Label>
                        <asp:TextBox ID="tb_dataFim" runat="server" Style="width: calc(30% - 3px); display: inline-block;" TextMode="Date"></asp:TextBox>
                    </div>
                    <div style="margin: 10px 0 0 10px;">
                        ASSOCIAR CURSO
                    </div>
                    <div style="margin: 10px 0 0 10px;">
                        <asp:DropDownList ID="ddl_cursos" runat="server" DataSourceID="SqlDataSource2" DataTextField="nome_curso" DataValueField="cod_curso" Style="border: 1px solid #ccc; border-radius: 5px;" AutoPostBack="True"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT * FROM [cursos]"></asp:SqlDataSource>
                    </div>
                    <div style="margin: 10px 0 0 10px;">
                        INSERIR ALUNOS
                    </div>
                    <div style="margin: 10px 0 0 10px;">
                        <asp:ListBox ID="lb_alunos" runat="server" DataSourceID="SqlDataSource1" DataTextField="nome" DataValueField="cod_user" Style="border: 1px solid #ccc; border-radius: 5px;" SelectionMode="Multiple"></asp:ListBox>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProjetoFinal1ConnectionString %>" SelectCommand="SELECT [cod_user], [nome]
                FROM [users]
                WHERE [candidato] = 1 and [ativo] = 1 "></asp:SqlDataSource>
                        </div>
                    <div style="margin: 10px 0 0 10px;">
                        <asp:Button ID="btn_criarTurma" Text="Salvar" OnClick="btn_criarTurma_Click" Style="background-color: #F79E74; color: white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0 5px 50px; left: 50%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server" />
                    </div>
                    <div style="font-weight: bold; margin: 10px 0 10px 0;">
                        <asp:Label ID="lbl_mensagem1" Text="" runat="server"></asp:Label>
                    </div>
                </section>                

                <%-- <div>
                    <asp:Button ID="Button1" Text="Ir para ?" Style="background-color: #F79E74; color: white; border: none; border-radius: 4px; padding: 7px 20px; right: 30%; margin: 15px 0 50px 1320px; /*left: 80%; */ bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;"
                        onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server" />
                </div>--%>

            </div>
        </ContentTemplate>
        <Triggers>
            <%--<asp:AsyncPostBackTrigger ControlID="btn_associar" EventName="Click" />--%>
            <asp:AsyncPostBackTrigger ControlID="btn_criarTurma" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

    <br />
    <br />
    <br />

    <%--/main--%>
    <script>    
        //função para selecionar a lb_alunos
        function enviarAlunosSelecionados() {
            var alunosSelecionados = $('#lb_alunos').val(); // Obter os valores selecionados na lista
            $.ajax({
                type: 'POST',
                url: 'urma.aspx', // Substitua pelo URL do seu script do lado do servidor
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
