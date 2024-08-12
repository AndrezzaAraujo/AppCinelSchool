using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO; // adicionado
using System.Data; // permite conexao à base de dados
using System.Data.SqlClient; // permite conexao à base de dados
using System.Configuration; // permite ir na web config buscar a conexao a base de dados

namespace Projetoteste
{
    public partial class documentacao : System.Web.UI.Page
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

        protected void img_lupa_Click(object sender, ImageClickEventArgs e)
        {
            //string palavra = tb_search.Text.Trim(); // Remover espaços em branco extras

            //if (!string.IsNullOrEmpty(palavra))
            //{
            //    string query = "SELECT * FROM documentos WHERE titulo LIKE '%" + palavra + "%'";

            //    SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            //    SqlCommand myCommand = new SqlCommand(query, myConn);

            //    SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            //    DataSet myDataSet = new DataSet();

            //    // Preenche o DataSet com os dados do banco de dados
            //    myAdapter.Fill(myDataSet, "documentos");

            //    // Filtra os dados com base na palavra-chave
            //    DataTable dtFiltered = myDataSet.Tables["documentos"].Clone(); // Cria uma cópia da estrutura da tabela
            //    foreach (DataRow row in myDataSet.Tables["documentos"].Rows)
            //    {
            //        if (row["titulo"].ToString().IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
            //        {
            //            dtFiltered.ImportRow(row); // Adiciona a linha à tabela filtrada se o título corresponder à palavra-chave
            //        }
            //    }

            //    // Armazena os resultados da pesquisa na variável de sessão
            //    Session["SearchResults"] = dtFiltered;

            //    // Itera sobre as linhas do Repeater e define a visibilidade com base nos resultados da pesquisa
            //    foreach (RepeaterItem item in rpt_documentacao.Items)
            //    {
            //        // Obtém o Label com o nome
            //        TextBox txtNome = (TextBox)item.FindControl("tb_nomeCurso");

            //        // Verifica se o nome corresponde à palavra-chave
            //        if (txtNome.Text.IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
            //        {
            //            // Se corresponder, mostra a linha
            //            item.Visible = true;
            //        }
            //        else
            //        {
            //            // Se não corresponder, esconde a linha
            //            item.Visible = false;
            //        }
            //    }
            //}
            //else
            //{
            //    // Se a pesquisa estiver vazia, limpe a variável de sessão e mostre todas as linhas do Repeater
            //    Session["SearchResults"] = null;
            //    foreach (RepeaterItem item in rpt_documentacao.Items)
            //    {
            //        item.Visible = true;
            //    }
            //}
        }

        protected void img_limpar_Click(object sender, ImageClickEventArgs e)
        {
            //// Limpa o conteúdo da caixa de pesquisa
            //tb_search.Text = "";

            //// Limpa a variável de sessão
            //Session["SearchResults"] = null;

            //// Recarrega os dados originais do banco de dados
            //BindRepeaterData();
        }

        //private void BindRepeaterData()
        //{
        //    // Consulta SQL para selecionar todos os registros da tabela users
        //    string query = "SELECT * FROM documentos";

        //    // Lista para armazenar os resultados da consulta
        //    List<Documento> documentos = new List<Documento>();

        //    // Conexão com o banco de dados
        //    using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
        //    {
        //        // Abre a conexão
        //        myConn.Open();

        //        // Comando SQL
        //        using (SqlCommand myCommand = new SqlCommand(query, myConn))
        //        {
        //            // Executa o comando e obtém o leitor de dados
        //            using (SqlDataReader reader = myCommand.ExecuteReader())
        //            {
        //                // Verifica se existem linhas no leitor de dados
        //                if (reader.HasRows)
        //                {
        //                    // Itera sobre as linhas do leitor de dados
        //                    while (reader.Read())
        //                    {
        //                        // Cria um objeto User e popula com os dados do leitor de dados
        //                        Documento documento = new Documento();
        //                        curso.Cod_documento = Convert.ToInt32(reader["cod_documento"]);
        //                        curso.Nome_documento = reader["titulo"].ToString();
        //                        // Preencha os outros campos conforme necessário...
        //                        // Adiciona o curso à lista
        //                        documentos.Add(documento);
        //                    }
        //                }
        //            }
        //        }
        //        // Fecha a conexão
        //        myConn.Close();
        //    }
        //    // Chama o método DataBind para associar os dados ao Repeater
        //    rpt_documentacao.DataBind();
        //}

        public class Documento
        {
            public int Cod_documento { get; set; }
            public string Titulo { get; set; }
            public string Tipo_documento { get; set; }
            public int Cod_user { get; set; }
        }

        // visualizar documento
        protected void btn_visualizar_Click(object sender, EventArgs e)
        {

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();

            // input | passagem de dados para SQL
            //myCommand.Parameters.AddWithValue("@cod_documento", lbl_cod.Text);

            // chamar a stored procedure
            myCommand.CommandType = CommandType.StoredProcedure; // conecta com a store procedure
            myCommand.CommandText = "ler_imagem"; // nome da store procedure

            myCommand.Connection = myConn;
            myConn.Open();

            SqlDataReader dr = myCommand.ExecuteReader(); // dr = dataReader (é um array bidimensional, uma matriz)| vai ler, executar a imagem e deixar guardada aqui

            try
            {
                if (dr.Read())
                {
                    Response.ContentType = dr["tipo_documento"].ToString();
                    Response.BinaryWrite((byte[])dr["documento"]);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erro ao ler imagem: " + ex.Message);
            }
            finally
            {
                myConn.Close();
            }
        }

        protected void rpt_documentacao_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                if (dr != null)
                {
                    ((Label)e.Item.FindControl("lbl_cod")).Text = dr["cod_documento"].ToString();
                    ((TextBox)e.Item.FindControl("tb_titulo")).Text = dr["titulo"].ToString();
                    ((Label)e.Item.FindControl("lbl_tipoDoc")).Text = dr["tipo_documento"].ToString();
                    ((Label)e.Item.FindControl("lbl_codUser")).Text = dr["cod_user"].ToString();

                    ((Button)e.Item.FindControl("btn_visualizar")).CommandArgument = dr["cod_documento"].ToString();
                    ((ImageButton)e.Item.FindControl("btn_editar")).CommandArgument = dr["cod_documento"].ToString();
                }
            }
        }


        // deletar documento
        protected void rpt_documentacao_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("btn_visualizar"))
            {
                int cod_documento = Convert.ToInt32(e.CommandArgument);

                string query = @"
        SELECT 
            cod_documento,
            titulo,
            tipo_documento,
            documento,
            cod_user 
        FROM documentos 
        WHERE cod_documento = @cod_documento";

                using (SqlConnection myCon = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    SqlCommand command = new SqlCommand(query, myCon);
                    command.Parameters.AddWithValue("@cod_documento", cod_documento);

                    try
                    {
                        myCon.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            byte[] documentoBytes = (byte[])reader["documento"];
                            string tipo_documento = reader["tipo_documento"].ToString();

                            if (documentoBytes != null && documentoBytes.Length > 0)
                            {
                                // Defina o tipo MIME com base no tipo do documento
                                string contentType;
                                switch (tipo_documento)
                                {
                                    case "application/pdf":
                                        contentType = "pdf";
                                        break;                                                                     
                                    case "image/jpeg":
                                        contentType = "jpeg";
                                        break;
                                    default:
                                        contentType = "application/octet-stream";
                                        break;
                                }

                                // Defina o nome do arquivo com base no tipo do documento
                                string fileName = $"{reader["titulo"]}.{contentType}";

                                // Configurar a resposta HTTP
                                Response.Clear();
                                Response.ContentType = reader["tipo_documento"].ToString();
                                Response.AddHeader("Content-Disposition", $"inline; filename={fileName}");
                                Response.BinaryWrite(documentoBytes);
                                Response.Flush();
                                Response.End();
                            }
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Trate a exceção conforme necessário
                        Console.WriteLine(ex.Message);
                    }
                }
            }

            if (e.CommandName.Equals("btn_editar"))
            {
                string query = "UPDATE documentos SET ";

                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    // Construindo a parte SET da consulta
                    query += "titulo=@titulo ";

                    query += " WHERE cod_documento=@cod_documento";

                    using (SqlCommand myCommand = new SqlCommand(query, myConn))
                    {
                        myCommand.Parameters.AddWithValue("titulo", ((TextBox)e.Item.FindControl("tb_titulo")).Text.Replace(",", "."));
                        myCommand.Parameters.AddWithValue("cod_documento", ((Label)e.Item.FindControl("lbl_cod")).Text);

                        try
                        {
                            myConn.Open();
                            int rowsAffected = myCommand.ExecuteNonQuery();
                            myConn.Close();
                            // Verifique se a atualização foi bem-sucedida
                            if (rowsAffected > 0)
                            {
                                // Atualização bem-sucedida
                            }
                            else
                            {
                                // Nenhum registro atualizado
                            }
                        }
                        catch (Exception ex)
                        {
                            // Lidar com exceções
                            Console.WriteLine("Erro: " + ex.Message);
                        }
                    }
                }
            }

            if (e.CommandName.Equals("btn_deletar"))
            {
                string query = "DELETE FROM documentos WHERE cod_documento = @cod_documento";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                myConn.Open();

                SqlCommand myCommand = new SqlCommand(query, myConn);
                myCommand.Parameters.AddWithValue("@cod_documento", ((Label)e.Item.FindControl("lbl_cod")).Text);

                myCommand.ExecuteNonQuery();
                myConn.Close();

                rpt_documentacao.DataBind(); // está instruindo o controle a se atualizar com os dados da fonte de dados associada
            }
        }     

        protected void btn_retornar_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx"); 
        }               

        protected void lbtn_previous_Click1(object sender, EventArgs e)
        {
            // Feito em JS
        }

        protected void lbtn_next_Click1(object sender, EventArgs e)
        {
            // Feito em JS
        }
    }
}