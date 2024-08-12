using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO; // adicionado
using System.Data; // permite conexao à base de dados
using System.Data.SqlClient; // permite conexao à base de dados
using System.Configuration; // permite ir na web config buscar a conexao a base de dados
using System.Security.Cryptography; // para encriptar a senha do user
using System.Net; // enviar e-mail
using System.Net.Mail; // enviar e-mail
using System.Text.RegularExpressions; //regex

namespace Projetoteste
{
    public partial class gestao_modulos : System.Web.UI.Page
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
        
        protected void rpt_modulos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;

                ((Label)e.Item.FindControl("lbl_cod")).Text = dr["cod_modulo"].ToString();
                ((TextBox)e.Item.FindControl("tb_numModulo")).Text = dr["numero_modulo"].ToString();
                ((TextBox)e.Item.FindControl("tb_nomeModulo")).Text = dr["nome_modulo"].ToString();
                ((TextBox)e.Item.FindControl("tb_duracao")).Text = dr["duracao"].ToString();
                
                ((ImageButton)e.Item.FindControl("imgBtnEditar")).CommandArgument = dr["cod_modulo"].ToString();
            }
        }
        protected void rpt_modulos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            if (e.CommandName == "imgBtnEditar") // Verifica o CommandName em vez do CommandArgument
            {
                string query = "UPDATE modulos SET ";

                query += "nome_modulo=@nome_modulo, ";
                query += "duracao=@duracao, ";
                query += "numero_modulo=@numero_modulo ";

                // Adicionando o espaço em branco antes de SET
                query += " WHERE cod_modulo=@cod_modulo";

                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    using (SqlCommand myCommand = new SqlCommand(query, myConn))
                    {
                        // Adicionando parâmetros                        
                        myCommand.Parameters.AddWithValue("@nome_modulo", ((TextBox)e.Item.FindControl("tb_nomeModulo")).Text);
                        myCommand.Parameters.AddWithValue("@duracao", ((TextBox)e.Item.FindControl("tb_duracao")).Text);
                        myCommand.Parameters.AddWithValue("@numero_modulo", ((TextBox)e.Item.FindControl("tb_numModulo")).Text.Replace(",", "."));
                        myCommand.Parameters.AddWithValue("@cod_modulo", ((Label)e.Item.FindControl("lbl_cod")).Text);

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
            //if (e.CommandArgument.Equals("imgBtnEditar"))
            //{
            //    string query = "UPDATE modulos SET ";

            //    using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            //    {
            //        query += "nome_modulo=@nome_modulo, ";
            //        query += "duracao=@duracao, ";
            //        query += "numero_modulo=@numero_modulo ";

            //        // Adicionando o espaço em branco antes de SET
            //        query += " WHERE cod_modulo=@cod_modulo";

            //        using (SqlCommand myCommand = new SqlCommand(query, myConn))
            //        {
            //            // Adicionando parâmetros                        
            //            myCommand.Parameters.AddWithValue("@nome_modulo", ((TextBox)e.Item.FindControl("tb_nomeModulo")).Text);
            //            myCommand.Parameters.AddWithValue("@duracao", ((TextBox)e.Item.FindControl("tb_duracao")).Text);
            //            myCommand.Parameters.AddWithValue("@numero_modulo", ((TextBox)e.Item.FindControl("tb_numModulo")).Text.Replace(",", "."));

            //            myCommand.Parameters.AddWithValue("@cod_modulo", ((Label)e.Item.FindControl("lbl_cod")).Text);

            //            try
            //            {
            //                myConn.Open();
            //                int rowsAffected = myCommand.ExecuteNonQuery();
            //                myConn.Close();
            //                // Verifique se a atualização foi bem-sucedida
            //                if (rowsAffected > 0)
            //                {
            //                    // Atualização bem-sucedida
            //                }
            //                else
            //                {
            //                    // Nenhum registro atualizado
            //                }
            //            }
            //            catch (Exception ex)
            //            {
            //                // Lidar com exceções
            //                Console.WriteLine("Erro: " + ex.Message);
            //            }
            //        }
            //    }
            //}

            if (e.CommandName.Equals("imgBtnDeletar"))
            {
                string query1 = "DELETE FROM modulos WHERE ";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                myConn.Open();

                query1 += "cod_modulo = " + ((Label)e.Item.FindControl("lbl_cod")).Text;

                SqlCommand myCommand = new SqlCommand(query1, myConn);
                myCommand.ExecuteNonQuery();
                myConn.Close();

                rpt_modulos.DataBind(); // está instruindo o controle a se atualizar com os dados da fonte de dados associada
            }
        }

        // evento pesquisar
        protected void img_lupa_Click(object sender, ImageClickEventArgs e)
        {
            string palavra = tb_search.Text.Trim(); // Remover espaços em branco extras

            if (!string.IsNullOrEmpty(palavra))
            {
                string query = "SELECT * FROM modulos WHERE nome_modulo LIKE '%" + palavra + "%'";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                SqlCommand myCommand = new SqlCommand(query, myConn);

                SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
                DataSet myDataSet = new DataSet();

                // Preenche o DataSet com os dados do banco de dados
                myAdapter.Fill(myDataSet, "modulos");

                // Filtra os dados com base na palavra-chave
                DataTable dtFiltered = myDataSet.Tables["modulos"].Clone(); // Cria uma cópia da estrutura da tabela
                foreach (DataRow row in myDataSet.Tables["modulos"].Rows)
                {
                    if (row["nome_modulo"].ToString().IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        dtFiltered.ImportRow(row); // Adiciona a linha à tabela filtrada se o título corresponder à palavra-chave
                    }
                }

                // Armazena os resultados da pesquisa na variável de sessão
                Session["SearchResults"] = dtFiltered;

                // Itera sobre as linhas do Repeater e define a visibilidade com base nos resultados da pesquisa
                foreach (RepeaterItem item in rpt_modulos.Items)
                {
                    // Obtém o Label com o nome
                    TextBox txtNome = (TextBox)item.FindControl("tb_nomeModulo");

                    // Verifica se o nome corresponde à palavra-chave
                    if (txtNome.Text.IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        // Se corresponder, mostra a linha
                        item.Visible = true;
                    }
                    else
                    {
                        // Se não corresponder, esconde a linha
                        item.Visible = false;
                    }
                }
            }
            else
            {
                // Se a pesquisa estiver vazia, limpe a variável de sessão e mostre todas as linhas do Repeater
                Session["SearchResults"] = null;
                foreach (RepeaterItem item in rpt_modulos.Items)
                {
                    item.Visible = true;
                }
            }
        }

        // evento apagar pesquisa e voltar lista ao estado original
        protected void img_limpar_Click(object sender, ImageClickEventArgs e)
        {
            // Limpa o conteúdo da caixa de pesquisa
            tb_search.Text = "";

            // Limpa a variável de sessão
            Session["SearchResults"] = null;

            // Recarrega os dados originais do banco de dados
            BindRepeaterData();
        }        
        
        private void BindRepeaterData()
        {
            // Consulta SQL para selecionar todos os registros da tabela users
            string query = "SELECT * FROM modulos";

            // Lista para armazenar os resultados da consulta
            List<Modulo> modulos = new List<Modulo>();

            // Conexão com o banco de dados
            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                // Abre a conexão
                myConn.Open();

                // Comando SQL
                using (SqlCommand myCommand = new SqlCommand(query, myConn))
                {
                    // Executa o comando e obtém o leitor de dados
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        // Verifica se existem linhas no leitor de dados
                        if (reader.HasRows)
                        {
                            // Itera sobre as linhas do leitor de dados
                            while (reader.Read())
                            {
                                // Cria um objeto User e popula com os dados do leitor de dados
                                Modulo modulo = new Modulo();
                                modulo.Cod_modulo = Convert.ToInt32(reader["cod_modulo"]);
                                modulo.Nome_Modulo = reader["nome_modulo"].ToString();
                                // Preencha os outros campos conforme necessário...

                                // Adiciona o curso à lista
                                modulos.Add(modulo);
                            }
                        }
                    }
                }
                // Fecha a conexão
                myConn.Close();
            }
            // Chama o método DataBind para associar os dados ao Repeater
            rpt_modulos.DataBind();
        }
        public class Modulo
        {
            // Propriedades da classe User
            public int Cod_modulo { get; set; }
            public string Nome_Modulo { get; set; }
            public string Duracao { get; set; }
            public int Numero_Modulo { get; set; }
        }        

        protected void lbtn_next_Click(object sender, EventArgs e)
        {
            //feito em js na page .aspx
        }

        protected void lbtn_previous_Click(object sender, EventArgs e)
        {
            //feito em js na page .aspx
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx");
        }
    }
}