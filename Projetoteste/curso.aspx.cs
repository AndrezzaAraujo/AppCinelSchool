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
    public partial class curso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void lbtn_previous_Click(object sender, EventArgs e)
        {
            //feito js no aspx
        }
        protected void lbtn_next_Click(object sender, EventArgs e)
        {
            //feito js no aspx
        }
        protected void rpt_cursos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
        //Classe
        public class listaCursos
        {
            public int cod_curso { get; set; }
            public string nome_curso { get; set; }
            public string horario { get; set; }
            public string local { get; set; }
            public string tipo { get; set; }
            public string area { get; set; }
            public string modalidade { get; set; }
            public string qtd_horas { get; set; }
            public string descricao { get; set; }
        }

        //evento pesquisar
        protected void img_lupa_Click(object sender, ImageClickEventArgs e)
        {
            string palavra = tb_search.Text.Trim(); // Remover espaços em branco extras
            if (!string.IsNullOrEmpty(palavra))
            {
                string query = "SELECT * FROM cursos WHERE nome_curso LIKE @palavra";
                // Use parameters to prevent SQL injection
                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand(query, myConn);
                    // Adiciona o parâmetro para a palavra-chave
                    myCommand.Parameters.AddWithValue("@palavra", "%" + palavra + "%");

                    SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
                    DataSet myDataSet = new DataSet();

                    // Preenche o DataSet com os dados do banco de dados
                    myAdapter.Fill(myDataSet, "cursos");

                    // Limpa os itens existentes no Repeater
                    rpt_cursos.Controls.Clear();


                    // Itera sobre cada linha do DataTable e cria manualmente os itens do card para adicionar ao Repeater
                    foreach (DataRow row in myDataSet.Tables["cursos"].Rows)
                    {
                        // elementos do card
                        Panel card = new Panel();
                        card.CssClass = "card";

                        Literal title = new Literal();
                        title.Text = string.Format("<h2 class='card-title'>{0}</h2>", row["nome_curso"]);

                        Literal horario = new Literal();
                        horario.Text = string.Format("<div class='card-meta'><strong>Horário: </strong>{0}</div>", row["horario"]);

                        Literal local = new Literal();
                        local.Text = string.Format("<div class='card-meta'><strong>Local: </strong>{0}</div>", row["local"]);

                        Literal tipo = new Literal();
                        tipo.Text = string.Format("<div class='card-meta'><strong>Tipo: </strong>{0}</div>", row["tipo"]);

                        Literal area = new Literal();
                        area.Text = string.Format("<div class='card-meta'><strong>Área: </strong>{0}</div>", row["area"]);

                        Literal modalidade = new Literal();
                        modalidade.Text = string.Format("<div class='card-meta'><strong>Modalidade: </strong>{0}</div>", row["modalidade"]);

                        Literal horas = new Literal();
                        horas.Text = string.Format("<div class='card-meta'>{0} <strong> horas</strong></div>", row["qtd_horas"]);

                        // botão de descrição Modal
                        Button btnDescricao = new Button();
                        btnDescricao.Text = "Descrição";
                        btnDescricao.CssClass = "btn-saibamais";
                        btnDescricao.CommandName = "SaibaMais"; // Nome do comando para identificar o clique do botão
                        btnDescricao.CommandArgument = row["descricao"].ToString(); // Argumento do comando, neste caso, a descrição do curso
                        btnDescricao.Click += BtnDescricao_Click; // Associe o evento de clique


                        // Adicione os elementos do card ao painel do card
                        card.Controls.Add(title);
                        card.Controls.Add(horario);
                        card.Controls.Add(local);
                        card.Controls.Add(tipo);
                        card.Controls.Add(area);
                        card.Controls.Add(modalidade);
                        card.Controls.Add(horas);
                        card.Controls.Add(btnDescricao); // Adicione o botão ao card

                        // Adicione o card ao Repeater
                        rpt_cursos.Controls.Add(card);
                    }
                    // teste para limpar textbox     Limpa o conteúdo da caixa de texto de pesquisa
                    tb_search.Text = string.Empty;
                }
            }
        }

        protected void BtnDescricao_Click(object sender, EventArgs e)
        {
            // Obtenha o botão clicado
            Button btn = (Button)sender;

            // Obtenha a descrição do curso do argumento do comando
            string descricao = btn.CommandArgument;
        }

        // evento limpar pesquisa
        protected void img_limpar_Click(object sender, ImageClickEventArgs e)
        {
            //// Limpe o texto do campo de pesquisa
            //tb_search.Text = "";

            //// Recarregue os dados originais no Repeater
            //BindData(); // Método que você deve criar para preencher o Repeater inicialmente
        }

        protected void btnDescricao_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string descricao = btn.CommandArgument;

            // Faça o que desejar com a descrição (exibir em um modal, redirecionar para outra página, etc.)
        }

        protected void img_retornar_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSource1.DataBind(); // Recarrega os dados do SqlDataSource
            Response.Redirect("curso.aspx");
        }

        protected void ddl_cursosADecorrer_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddl_cursosAIniciar_SelectedIndexChanged(object sender, EventArgs e)
        {
            string query = "SELECT c.nome_curso AS nome_curso, t.data_inicio, t.data_fim " +
                    "FROM cursos c " +
                    "INNER JOIN turmas t ON c.cod_curso = t.cod_curso " +
                    "WHERE t.data_inicio BETWEEN GETDATE() AND DATEADD(day, 60, GETDATE())";


            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal2ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand(query, myConn);

            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            DataSet myDataSet = new DataSet();

            // Preenche o DataSet com os dados do banco de dados
            myAdapter.Fill(myDataSet, "cursos");

            SqlDataSource1.SelectCommand = query;
            //rpt_colecaoCliente.DataSource = myDataSet.Tables["colecoes"];
            rpt_cursos.DataBind();
        }
    }
}