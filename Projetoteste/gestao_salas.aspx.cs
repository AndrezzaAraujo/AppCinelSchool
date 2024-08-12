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
    public partial class gestao_salas : System.Web.UI.Page
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

        protected void btn_goPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx"); /*??*/
        }

        protected void rpt_salas_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = e.Item.DataItem as DataRowView;
                if (dr != null)
                {
                    Label lbl_cod = e.Item.FindControl("lbl_cod") as Label;
                    TextBox tb_nomeSala = e.Item.FindControl("tb_nomeSala") as TextBox;

                    ImageButton imgBtnEditar = e.Item.FindControl("imgBtnEditar") as ImageButton;

                    if (lbl_cod != null)
                        lbl_cod.Text = dr["cod_sala"].ToString();
                    if (tb_nomeSala != null)
                        tb_nomeSala.Text = dr["nome"].ToString();
                    if (imgBtnEditar != null)
                        imgBtnEditar.CommandArgument = dr["cod_sala"].ToString();
                }
            }            
        }
        protected void rpt_salas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("imgBtnEditar"))
            {
                string query = "UPDATE salas SET ";

                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    // Construindo a parte SET da consulta
                    query += "nome=@nome ";

                    // Adicionando o espaço em branco antes de SET
                    query += " WHERE cod_sala=@cod_sala"; 
                
                    using (SqlCommand myCommand = new SqlCommand(query, myConn))
                    {
                        myCommand.Parameters.AddWithValue("nome", ((TextBox)e.Item.FindControl("tb_nomeSala")).Text.Replace(",", "."));
                        myCommand.Parameters.AddWithValue("cod_sala", ((Label)e.Item.FindControl("lbl_cod")).Text);

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

            if (e.CommandName.Equals("imgBtnDeletar"))
            {
                string query1 = "DELETE FROM salas WHERE ";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                myConn.Open();

                query1 += "cod_sala = " + ((Label)e.Item.FindControl("lbl_cod")).Text;

                SqlCommand myCommand = new SqlCommand(query1, myConn);
                myCommand.ExecuteNonQuery();
                myConn.Close();

                rpt_salas.DataBind(); // está instruindo o controle a se atualizar com os dados da fonte de dados associada  
            }
        }

        protected void imgBtn_pesquisa_Click(object sender, ImageClickEventArgs e)
        {
            string palavra = tb_pesquisar.Text.Trim(); // Remover espaços em branco extras

            if (!string.IsNullOrEmpty(palavra))
            {
                string query = "SELECT * FROM salas WHERE nome LIKE '%" + palavra + "%'";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                SqlCommand myCommand = new SqlCommand(query, myConn);

                SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
                DataSet myDataSet = new DataSet();

                // Preenche o DataSet com os dados do banco de dados
                myAdapter.Fill(myDataSet, "salas");

                // Filtra os dados com base na palavra-chave
                DataTable dtFiltered = myDataSet.Tables["salas"].Clone(); // Cria uma cópia da estrutura da tabela
                foreach (DataRow row in myDataSet.Tables["salas"].Rows)
                {
                    if (row["nome"].ToString().IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        dtFiltered.ImportRow(row); // Adiciona a linha à tabela filtrada se o título corresponder à palavra-chave
                    }
                }

                // Armazena os resultados da pesquisa na variável de sessão
                Session["SearchResults"] = dtFiltered;

                // Itera sobre as linhas do Repeater e define a visibilidade com base nos resultados da pesquisa
                foreach (RepeaterItem item in rpt_salas.Items)
                {
                    // Obtém o Label com o nome
                    TextBox txtNome = (TextBox)item.FindControl("tb_nomeSala");

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
                foreach (RepeaterItem item in rpt_salas.Items)
                {
                    item.Visible = true;
                }
            }
        }

        protected void imgBtn_limpar_Click(object sender, ImageClickEventArgs e)
        {
            // Limpa o conteúdo da caixa de pesquisa
            tb_pesquisar.Text = "";

            // Limpa a variável de sessão
            Session["SearchResults"] = null;

            // Recarrega os dados originais do banco de dados
            BindRepeaterData();
        }

        private void BindRepeaterData()
        {
            // Consulta SQL para selecionar todos os registros da tabela users
            string query = "SELECT * FROM salas";

            // Lista para armazenar os resultados da consulta
            List<Sala> salas = new List<Sala>();

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
                                Sala sala = new Sala();
                                sala.Cod_sala = Convert.ToInt32(reader["cod_sala"]);
                                sala.Nome = reader["nome"].ToString();
                                // Preencha os outros campos conforme necessário...
                                // Adiciona o curso à lista
                                salas.Add(sala);
                            }
                        }
                    }
                }
                // Fecha a conexão
                myConn.Close();
            }
            // Chama o método DataBind para associar os dados ao Repeater
            rpt_salas.DataBind();
        }
        public class Sala
        {
            // Propriedades da classe User
            public int Cod_sala { get; set; }
            public string Nome { get; set; }            
        }

        protected void lbtn_previous_Click(object sender, EventArgs e)
        {
            // feito em JS
        }

        protected void lbtn_next_Click(object sender, EventArgs e)
        {
            // feito em JS
        }
    }
}