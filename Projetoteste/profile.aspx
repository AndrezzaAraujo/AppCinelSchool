<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Projetoteste.profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet"/>
<style>
body {
    background: rgb(245, 245, 245);
}

.form-control:focus {
    box-shadow: none;
    border-color: #c78646; /* /#BA68C8/*/
}

.profile-button {
    background: rgb(247, 158, 116);
    box-shadow: none;
    border: none
}

.profile-button:hover {
    background: #FF7F50; /*/#682773/*/
}

.profile-button:focus {
    background: #FF7F50; /*/#682773/;*/
    box-shadow: none;
}

.profile-button:active {
    background: #FF7F50; /*/#682773/;*/
    box-shadow: none;
}

.back:hover {
    color: #FF7F50; /*/#682773/;*/
    cursor: pointer;
}

.labels {
    font-size: 11px;
}

.add-experience:hover {
    background: #c78646; /*/#BA68C8/;*/
    color: #fff;
    cursor: pointer;
    border: solid 1px #c78646; /*/#BA68C8/*/
}
</style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <%--<img class="rounded-circle mt-5" width="150" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"/>--%>
                        <div class="rounded-circle mt-5" width="150">
                            <asp:Image ID="img_foto" runat="server" /></div>
                        <%--image--%>
                        <span></span>
                    </div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-center">Perfil</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <%--<label class="labels">Full Name</label><input type="text" class="form-control" placeholder="full name" value=""/>--%>
                                <%--<p >Nome:<asp:Label ID="lbl_name" runat="server" Text=""></asp:Label></p>--%>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <%--<div class="col-md-12"><label class="labels">Mobile Number</label><input type="text" class="form-control" placeholder="enter phone number" value=""/></div>--%>
                            <p>
                                <strong>Nome:</strong>
                                <asp:Label ID="lbl_nome" runat="server" Text=""></asp:Label></p>
                            <p>
                                <strong>E-mail:</strong>
                                <asp:Label ID="lbl_email" runat="server" Text=""></asp:Label></p>
                            <p>
                                <strong>NIF:</strong>
                                <asp:Label ID="lbl_nif" runat="server" Text=""></asp:Label></p>
                            <p>
                                <strong>Telefone:</strong>
                                <asp:Label ID="lbl_telefone" runat="server" Text=""></asp:Label></p>
                            <p>
                                <strong>Morada:</strong>
                                <asp:Label ID="lbl_morada" runat="server" Text=""></asp:Label></p>                          
                            <asp:Xml ID="Xml1" runat="server"></asp:Xml>

                            <div class="col-md-12">
                            </div>
                            
                            <div class="col-md-12">
                            </div>

                             <div style="margin: 0 0 10px 0;">
                                <asp:LinkButton ID="lbtn_fichaPDF" OnClick="lbtn_fichaPDF_Click1" runat="server">Exportar minha ficha em PDF</asp:LinkButton>
                            </div>

                            <div>
                                 <div>
                                    <strong>Enviar documento: </strong>
                                    <asp:TextBox ID="tb_titulo" placeholder="Nome do documento" runat="server"></asp:TextBox>
                                    <asp:FileUpload ID="flUp_doc" AllowMultiple="true" Style="margin: 10px 0 10px 0;" runat="server" />
                                    <asp:Button ID="btn_salvar" Text="Salvar" Style="margin: 0px 0 0px 20px" OnClick="btn_salvar_Click" runat="server" />
                                    <strong><asp:Label ID="lbl_mensagem" Text="" Style="margin: 10px 0 10px 0" runat="server"></asp:Label></strong>
                                </div>
                            </div>

                        </div>


                        <div class="row mt-3">
                            <%-- <div class="col-md-6"><label class="labels">Country</label><input type="text" class="form-control" placeholder="country" value=""/></div>--%>
                            <%--<div class="col-md-6"><label class="labels">State/Region</label><input type="text" class="form-control" value="" placeholder="state"/></div>--%>
                        </div>

                        <div class="mt-5 text-center">
                            <asp:Button ID="btn_changePassword" class="btn btn-primary profile-button" runat="server" Text="Alterar Palavra-Passe" OnClick="btn_changePassword_Click" />
                            <asp:Button ID="btn_retornar" class="btn btn-primary profile-button" runat="server" Text="Retornar" OnClick="btn_retornar_Click"/>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-3 py-5">
                        <div style="margin-top: 45px; display: flex; justify-content: center; align-items: center;"><asp:Image ID="Image1" src="../main_template/img/logo_cinel_sem_fundo.png" runat="server" /></div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
