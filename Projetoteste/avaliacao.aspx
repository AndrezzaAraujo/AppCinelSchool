<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="avaliacao.aspx.cs" Inherits="Projetoteste.avaliacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--
    title: Nota
    hearder:
    nome curso, nome da turma, data início, data fim - sede
    table:
    nome Modulo | carga horária | carga assistida | nota avaliação--%>
   
    <div><h2>Assiduidade e Nota</h2></div>

    <div>
        <asp:Repeater ID="Repeater1" runat="server">
            <HeaderTemplate>
                <table>
                    <tr>
                        <th>Módulo</th>
                        <th>Horas previstas</th>
                        <th>Horas assistidas</th>
                        <th>Notas</th>                        
                    </tr>                
            </HeaderTemplate>
            <ItemTemplate>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
