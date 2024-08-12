<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="gestao_turmas.aspx.cs" Inherits="Projetoteste.gestao_turmas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
table{
    margin-left: auto;
    margin-right: auto;
    /*border= 1;*/
    border-collapse: collapse;
    border-radius: 5px; /* Adiciona borda arredondada */
    border: 2px solid black; /* Adiciona uma borda externa */
    overflow: hidden; /* Para cortar as bordas arredondadas das células da tabela */    
}
th, td {
    padding: 10px;
    border: 1px solid black;          
    width: auto; /* Define o tamanho automático */
}

td{
     word-wrap: break-word; /* Quebra automática de texto */
     overflow-wrap: break-word; /* Para navegadores mais recentes */
}

th{
    
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--SqlDataSource--%>
    <div> <%--main--%>
        <div><asp:Button ID="btn_goPage"  Text="RETORNAR PÁGINA" OnClick="btn_goPage_Click1" style="background-color: #F79E74; color:white; border: none; border-radius: 4px; padding: 7px 20px; margin: 15px 0px 5px 200px; left: 50%; bottom: 20px; transform: translateX(-50%); cursor: pointer; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#FF7F50'" onmouseout="this.style.backgroundColor='#F79E74'" runat="server" /></div>
        <div style="margin: 70px 0 0 0;  text-align: center;"><h3>Title</h3></div>

        <div style="  margin: 0 0px 10px 600px; /*margin-left: auto; margin-right: auto;*/ ">
            <div style="display: inline-block; margin: 0 10px 0px 0px; width: 40%;"><asp:TextBox ID="tb_pesquisar" runat="server"></asp:TextBox></div>
            <div style="display: inline-block; margin: 0 0px 0 10px"><asp:ImageButton ID="imgBtn_pesquisa" ImageUrl="~/img/icon_search.png" runat="server" /></div>
            <div style="display: inline-block; margin: 0 0px 0 10px"><asp:ImageButton ID="imgBtn_limpar" ImageUrl="~/img/icon-eraser2.png" runat="server" /></div>
        </div>

        <asp:Repeater ID="rpt_turmas" runat="server">  <%--OnItemCommand="rpt_turmas_ItemCommand" OnItemDataBound="rpt_turmas_ItemDataBound"--%>
            <HeaderTemplate>
                <table>
                    <tr style="background-color: #cccccc">
                        <th style=" text-align: center;"></th>
                        <th style=" text-align: center;"></th>
                        <th style=" text-align: center;">Editar</th>
                        <th style=" text-align: center;">Deletar</th>
                    </tr>
                
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:ImageButton ID="imgBtn_editar" ImageUrl="~/img/icon_edit.png" runat="server" /></td>
                    <td>
                        <asp:ImageButton ID="imgBtn_deletar" ImageUrl="~/img/icon_delete2.png" runat="server" /></td>
                </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </AlternatingItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <div><asp:Label ID="lbl_mensagem" runat="server" Text=""></asp:Label></div>
        
    </div>
</asp:Content>
