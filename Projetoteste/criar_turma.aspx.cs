using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projetoteste
{
    public partial class criar_turma : System.Web.UI.Page
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

        protected void btn_criarTurma_Click(object sender, EventArgs e)
        {
            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                // Início da transação
                myConn.Open();
                SqlTransaction transaction = myConn.BeginTransaction();

                try
                {
                    // Inserção na tabela turmas
                    SqlCommand turmaCommand = new SqlCommand("INSERT INTO turmas (nome_turma, data_inicio, data_fim, cod_curso) OUTPUT INSERTED.cod_turma VALUES (@nome_turma, @data_inicio, @data_fim, @cod_curso)", myConn, transaction);
                    turmaCommand.Parameters.AddWithValue("@nome_turma", tb_turma.Text);
                    turmaCommand.Parameters.AddWithValue("@data_inicio", tb_dataInicio.Text);
                    turmaCommand.Parameters.AddWithValue("@data_fim", tb_dataFim.Text);
                    turmaCommand.Parameters.AddWithValue("@cod_curso", ddl_cursos.SelectedValue);
                    int codTurma = (int)turmaCommand.ExecuteScalar();

                    if (codTurma > 0)
                    {
                        lbl_mensagem1.Text = "Turma criada com sucesso!";

                        // Inserção na tabela formandos_turma
                        foreach (System.Web.UI.WebControls.ListItem item in lb_alunos.Items)
                        {
                            if (item.Selected)
                            {
                                SqlCommand formandoCommand = new SqlCommand("INSERT INTO formandos_turma (cod_user, cod_turma) VALUES (@cod_user, @cod_turma)", myConn, transaction);
                                formandoCommand.Parameters.AddWithValue("@cod_user", item.Value);
                                formandoCommand.Parameters.AddWithValue("@cod_turma", codTurma);
                                formandoCommand.ExecuteNonQuery();
                            }
                        }
                        transaction.Commit(); // Confirma a transação
                    }
                    else
                    {
                        lbl_mensagem1.Text = "Não foi possível criar a turma.";
                        transaction.Rollback(); // Reverte a transação se algo der errado
                    }
                }
                catch (Exception ex)
                {
                    lbl_mensagem1.Text = "Erro: " + ex.Message;
                    transaction.Rollback();
                }
                finally
                {
                    myConn.Close(); // Fecha a conexão
                }
            }
        }
    }
}