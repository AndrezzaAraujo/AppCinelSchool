using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO; //
using System.Data; // permite conexao à base de dados
using System.Data.SqlClient; // permite conexao à base de dados
using System.Configuration; // permite ir na web config buscar a conexao a base de dados
using System.Security.Cryptography; // para encriptar a senha do user
using System.Net; // enviar e-mail
using System.Net.Mail; // enviar e-mail
using System.Text.RegularExpressions; //regex
using System.Globalization;

namespace Projetoteste
{
    public partial class inscricao0 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
            {

            }
            else
            {
                // se não estiver na sessão, volta ao index
                Response.Redirect("index.aspx");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            // Verificar se o usuário está logado
            if (Session["nome"] != null)
            {
                // Obter o nome do usuário da sessão
                string nomeUser = Session["nome"].ToString();

                // Obter o ID do usuário baseado no nome de usuário
                int codUser = ObterCodUserPeloNome(nomeUser);

                if (codUser != 0)// Verificar se o código do usuário foi obtido com sucesso
                {
                    //para apanhar o contenttype
                    Stream imgStream1 = FileUpload_foto.PostedFile.InputStream;
                    Stream imgStream2 = FileUpload_documento.PostedFile.InputStream;

                    //para criar o array na dimensão do ficheiro que está sendo criado
                    int tamanhoFicheiro1 = FileUpload_foto.PostedFile.ContentLength;
                    int tamanhoFicheiro2 = FileUpload_documento.PostedFile.ContentLength;

                    //para apanhar os dados binários necessita de array de byte
                    byte[] imgBinaryData1 = new byte[tamanhoFicheiro1]; //temos que já definir a dimensão do ficheiro
                    byte[] imgBinaryData2 = new byte[tamanhoFicheiro2]; //temos que já definir a dimensão do ficheiro

                    imgStream1.Read(imgBinaryData1, 0, tamanhoFicheiro1);
                    imgStream2.Read(imgBinaryData2, 0, tamanhoFicheiro2);

                    SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);
                    SqlCommand myCommand = new SqlCommand();

                    // Input dos inscritos
                    DateTime dataInscricao;
                    if (!DateTime.TryParseExact(hdndataInscricao.Value, "M/d/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dataInscricao))
                    {
                        lbl_mensagem.Text = "A data de inscrição fornecida não é válida. Por favor, forneça uma data válida no formato M/d/yyyy.";
                    }
                    else
                    {
                        myCommand.Parameters.AddWithValue("@data_inscricao", dataInscricao);
                    }

                    myCommand.Parameters.AddWithValue("@cod_curso", ddl_cursos.SelectedValue);
                    myCommand.Parameters.AddWithValue("@cod_user", codUser); // Passar o cod_user obtido para a stored procedure
                    myCommand.Parameters.AddWithValue("@nif", tb_nif.Text);
                    myCommand.Parameters.AddWithValue("@telefone", tb_telefone.Text);
                    myCommand.Parameters.AddWithValue("@morada", tb_morada.Text);
                    myCommand.Parameters.AddWithValue("@foto", imgBinaryData1);
                    myCommand.Parameters.AddWithValue("@documento", imgBinaryData2);

                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.CommandText = "inscricao";

                    myCommand.Connection = myConn;
                    myConn.Open();
                    SqlDataReader dr = myCommand.ExecuteReader();

                    //se tiver dados, manda para o ecrã os dados binários
                    if (dr.Read())
                    {
                        Response.BinaryWrite((byte[])dr["foto"]);
                        Response.BinaryWrite((byte[])dr["documento"]);
                    }

                    lbl_mensagem.Text = " Inscrição confirmada!";

                    myConn.Close();
                }
                else
                {                    
                    Response.Redirect("~/index.aspx");
                }
            }
            else
            {                
                Response.Redirect("~/index.aspx");
            }
        }

        private int ObterCodUserPeloNome(string nome)
        {
            int codUser = 0;

            // Consultar o banco de dados e obter o cod_user baseado no nome do usuário
            string query = $"SELECT cod_user FROM users WHERE nome = '{nome}'";

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, myConn);

                try
                {
                    myConn.Open();

                    // ExecuteScalar retorna um objeto, faz a conversão para int diretamente
                    object result = command.ExecuteScalar();
                    if (result != null && int.TryParse(result.ToString(), out codUser))
                    {
                        // Valor de codUser atualizado com sucesso
                    }
                    else
                    {
                        // Trate o caso em que não foi possível obter um cod_user
                        // Isso pode indicar que o usuário não foi encontrado no banco de dados
                        lbl_mensagem.Text = "Falha ao obter o código do usuário.";
                    }
                }
                catch (Exception ex)
                {
                    // Tratar a exceção
                    Console.WriteLine("Ocorreu um erro ao obter o código do usuário: " + ex.Message);
                }
            }
            return codUser;
        }
    }
}