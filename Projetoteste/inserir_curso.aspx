<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="inserir_curso.aspx.cs" Inherits="Projetoteste.inserir_curso" %>

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
    background-color: #F79E74;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    position: absolute; 
  
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

.btn-item, button {
    padding: 10px 5px;
    margin-top: 20px;
    border-radius: 5px;
    border: none;
    background: #F79E74;
    text-decoration: none;
    font-size: 15px;
    font-weight: 400;
    color: #fff; 
}

.btn-item {
    display: inline-block;
    margin: 20px 5px 0;
}

button {
    width: 100%;
}

button:hover, .btn-item:hover {
    background: #FF6700; 
}


#line-beside {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 110px 0 25px 0;
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>            
    
    <%--main--%>
    <div class="main">        
        <div style="margin: 60px 0 -20px 1050px; display: flex; justify-content: center;">
            <asp:Button ID="btn_retornar" runat="server" Text="RETORNAR PÁGINA" CssClass="btn-item" OnClick="btn_retornar_Click" />
        </div>
        <div id="line-beside">            
            <h1 style="margin:0 0 0 0"; >CRIAÇÃO DE CURSOS, MÓDULOS E SALAS</h1>
            <div class="line"></div>
        </div>        
        <%--section curso--%>
        <section class="section-box" <%--style="margin: 40px 0 20px 0;"--%>>
            <div class="cursos">
                <div class="title">Criar Curso</div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_curso" runat="server" Text="Nome Curso"></asp:Label>
                    <asp:TextBox ID="tb_curso" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_horario" runat="server" Text="Horário"></asp:Label>               
                    <asp:TextBox ID="tb_horario" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_local" runat="server" Text="Local"></asp:Label>
                    <asp:TextBox ID="tb_local" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_tipo" runat="server" Text="Tipo"></asp:Label>
                    <asp:TextBox ID="tb_tipo" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_area" runat="server" Text="Área"></asp:Label>
                    <asp:TextBox ID="tb_area" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_modalidade" runat="server" Text="Modalidade"></asp:Label>
                    <asp:TextBox ID="tb_modalidade" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_qtdHoras" runat="server" Text="Quantidade de horas"></asp:Label>
                    <asp:TextBox ID="tb_qtdHoras" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_descricao" runat="server" Text="Descrição"></asp:Label>
                    <asp:TextBox ID="tb_descricao" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                   <%-- <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>--%>
                </div>
                <div >
                    <asp:Button ID="btn_criarCurso" OnClick="btn_criarCurso_Click" Text="Salvar" style="background-color: #F79E74; color:white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0 5px 50px; left: 50%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server"/></div> 
                <div style="font-weight: bold; margin: 10px 0 10px 0;"><asp:Label ID="lbl_mensagem" Text="" runat="server" ></asp:Label></div>
            </div>
        </section>
        <%--/section curso--%>
        <%--section modulo--%>
        <section class="section-box">
            <div class="modulos">
                <div class="title">Criar Modulo</div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_numModulo" runat="server" Text="Número Modulo"></asp:Label>
                    <asp:TextBox ID="tb_numModulo" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_nomeModulo" runat="server" Text="Nome Módulo"></asp:Label>
                    <asp:TextBox ID="tb_nomeModulo" runat="server"></asp:TextBox></div>
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_qtdHoras2" runat="server" Text="Quantidade de Horas"></asp:Label>
                    <asp:TextBox ID="tb_qtdHoras2" runat="server"></asp:TextBox></div>    
                <div style="font-weight: bold; margin: 10px 0 10px 0;">
                    <asp:Label ID="lbl_mensagem2" Text="" runat="server"></asp:Label></div>
                <div>
                    <asp:Button ID="btn_criarModulo" Text="Salvar" OnClick="btn_criarModulo_Click" Style="background-color: #F79E74; color: white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0 5px 50px; left: 50%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server" /></div>                
            </div>
        </section>
        <%--/section modulo--%>
        <%--section sala--%>
        <section class="section-box">
            <div class="title">Criar Sala</div>            
            <div class="salas">
                <div style="margin: 10px 0 0 10px;">
                    <asp:Label ID="lbl_nomeSala" runat="server" Text="Nome Sala"></asp:Label>
                    <asp:TextBox ID="tb_nomeSala" runat="server"></asp:TextBox></div>
                <%--<div style="margin: 10px 0 0 10px;">
                        <asp:Label ID="Label2" runat="server" Text="Quantidade de Horas"></asp:Label>
                        <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox></div>--%>
                <div style="font-weight: bold; margin: 10px 0 10px 0;">
                    <asp:Label ID="lbl_mensagem3" Text="" runat="server"></asp:Label></div>
                <div>
                    <asp:Button ID="btn_criarSala" Text="Salvar" OnClick="btn_criarSala_Click" Style="background-color: #F79E74; color: white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0 5px 50px; left: 50%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server" />
                </div>                
            </div>
        </section>
        
        <%--botão vai para ?--%>
        <%--<div>
            <asp:Button ID="Button1" Text="Ir para ?" style="background-color: #F79E74; color:white; border: none; border-radius: 4px; padding: 7px 20px; right: 30%; 
            margin: 15px 0 50px 1320px; /*left: 80%;*/ bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server"/>
        </div>--%>
   </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btn_criarCurso" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btn_criarModulo" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btn_criarSala" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <%--/main--%>
    <br />
    <br />
    <br />
</asp:Content>
