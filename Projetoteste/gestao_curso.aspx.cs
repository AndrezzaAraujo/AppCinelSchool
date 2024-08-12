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
    public partial class gestao_curso : System.Web.UI.Page
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

        //ItemDataBound lista os dados que estão no Repeater
        protected void rpt_cursos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem; // para apanhar um texto que está escrito dentro do item

                ((Label)e.Item.FindControl("lbl_cod")).Text = dr["cod_curso"].ToString();
                ((TextBox)e.Item.FindControl("tb_nomeCurso")).Text = dr["nome_curso"].ToString();
                ((TextBox)e.Item.FindControl("tb_horario")).Text = dr["horario"].ToString();
                ((TextBox)e.Item.FindControl("tb_local")).Text = dr["local"].ToString();
                ((TextBox)e.Item.FindControl("tb_tipo")).Text = dr["tipo"].ToString();
                ((TextBox)e.Item.FindControl("tb_area")).Text = dr["area"].ToString();
                ((TextBox)e.Item.FindControl("tb_modalidade")).Text = dr["modalidade"].ToString();
                ((TextBox)e.Item.FindControl("tb_qtdHoras")).Text = dr["qtd_horas"].ToString();
                ((TextBox)e.Item.FindControl("tb_descricao")).Text = dr["descricao"].ToString();                

                ((ImageButton)e.Item.FindControl("imgBtnEditar")).CommandArgument = dr["cod_curso"].ToString();
                //((ImageButton)e.Item.FindControl("imgBtnDeletar")).CommandArgument = dr["cod_curso"].ToString();
            }
        }

        protected void rpt_cursos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("imgBtnEditar"))
            {
                string query = "UPDATE cursos SET ";

                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    // Construindo a parte SET da consulta
                    query += "nome_curso=@nome_curso, ";
                    query += "horario=@horario, ";
                    query += "local=@local, ";
                    query += "tipo=@tipo, ";
                    query += "area=@area, ";
                    query += "modalidade=@modalidade, ";
                    query += "qtd_horas=@qtd_horas, ";
                    query += "descricao=@descricao ";

                    // Adicionando o espaço em branco antes de SET
                    query += " WHERE cod_curso=@cod_curso";

                    using (SqlCommand myCommand = new SqlCommand(query, myConn))
                    {
                        // Adicionando parâmetros
                        myCommand.Parameters.AddWithValue("@nome_curso", ((TextBox)e.Item.FindControl("tb_nomeCurso")).Text);
                        myCommand.Parameters.AddWithValue("@horario", ((TextBox)e.Item.FindControl("tb_horario")).Text);
                        myCommand.Parameters.AddWithValue("@local", ((TextBox)e.Item.FindControl("tb_local")).Text);
                        myCommand.Parameters.AddWithValue("@tipo", ((TextBox)e.Item.FindControl("tb_tipo")).Text);
                        myCommand.Parameters.AddWithValue("@area", ((TextBox)e.Item.FindControl("tb_area")).Text);
                        myCommand.Parameters.AddWithValue("@modalidade", ((TextBox)e.Item.FindControl("tb_modalidade")).Text);
                        myCommand.Parameters.AddWithValue("@qtd_horas", ((TextBox)e.Item.FindControl("tb_qtdHoras")).Text);
                        myCommand.Parameters.AddWithValue("@descricao", ((TextBox)e.Item.FindControl("tb_descricao")).Text.Replace(",", "."));

                        myCommand.Parameters.AddWithValue("@cod_curso", ((Label)e.Item.FindControl("lbl_cod")).Text);

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
                string query1 = "DELETE FROM cursos WHERE ";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                myConn.Open();

                query1 += "cod_curso = " + ((Label)e.Item.FindControl("lbl_cod")).Text;

                SqlCommand myCommand = new SqlCommand(query1, myConn);
                myCommand.ExecuteNonQuery();
                myConn.Close();

                rpt_cursos.DataBind(); // está instruindo o controle a se atualizar com os dados da fonte de dados associada
            }
        }        

        protected void img_lupa_Click(object sender, ImageClickEventArgs e)
        {
            string palavra = tb_search.Text.Trim(); // Remover espaços em branco extras

            if (!string.IsNullOrEmpty(palavra))
            {
                string query = "SELECT * FROM cursos WHERE nome_curso LIKE '%" + palavra + "%'";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                SqlCommand myCommand = new SqlCommand(query, myConn);

                SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
                DataSet myDataSet = new DataSet();

                // Preenche o DataSet com os dados do banco de dados
                myAdapter.Fill(myDataSet, "cursos");

                // Filtra os dados com base na palavra-chave
                DataTable dtFiltered = myDataSet.Tables["cursos"].Clone(); // Cria uma cópia da estrutura da tabela
                foreach (DataRow row in myDataSet.Tables["cursos"].Rows)
                {
                    if (row["nome_curso"].ToString().IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        dtFiltered.ImportRow(row); // Adiciona a linha à tabela filtrada se o título corresponder à palavra-chave
                    }
                }

                // Armazena os resultados da pesquisa na variável de sessão
                Session["SearchResults"] = dtFiltered;

                // Itera sobre as linhas do Repeater e define a visibilidade com base nos resultados da pesquisa
                foreach (RepeaterItem item in rpt_cursos.Items)
                {
                    // Obtém o Label com o nome
                    TextBox txtNome = (TextBox)item.FindControl("tb_nomeCurso");

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
                foreach (RepeaterItem item in rpt_cursos.Items)
                {
                    item.Visible = true;
                }
            }
        }

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
            string query = "SELECT * FROM cursos";

            // Lista para armazenar os resultados da consulta
            List<Curso> cursos = new List<Curso>();

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
                                Curso curso = new Curso();
                                curso.Cod_curso = Convert.ToInt32(reader["cod_curso"]);
                                curso.Nome_Curso = reader["nome_curso"].ToString();
                                // Preencha os outros campos conforme necessário...
                                // Adiciona o curso à lista
                                cursos.Add(curso);
                            }
                        }
                    }
                }
                // Fecha a conexão
                myConn.Close();
            }
            // Chama o método DataBind para associar os dados ao Repeater
            rpt_cursos.DataBind();
        }
        public class Curso
        {
            // Propriedades da classe User
            public int Cod_curso { get; set; }
            public string Nome_Curso { get; set; }
            public string Horario { get; set; }
            public string Local { get; set; }
            public string Tipo { get; set; }
            public string Area { get; set; }
            public string Modalidade { get; set; }
            public string Qtd_Horas { get; set; }
            public string Descricao { get; set; }
        }
        protected void btn_goPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx"); /*??*/
        }

        protected void lbtn_previous_Click(object sender, EventArgs e)
        {

        }

        protected void lbtn_next_Click(object sender, EventArgs e)
        {

        }
    }
}