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
    public partial class inserir_curso : System.Web.UI.Page
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

        protected void btn_criarCurso_Click(object sender, EventArgs e)
        {           
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            myCommand.Parameters.AddWithValue("@nome_curso", tb_curso.Text);
            myCommand.Parameters.AddWithValue("@horario", tb_horario.Text);
            myCommand.Parameters.AddWithValue("@local", tb_local.Text);
            myCommand.Parameters.AddWithValue("@tipo", tb_tipo.Text); 
            myCommand.Parameters.AddWithValue("@area", tb_area.Text);
            myCommand.Parameters.AddWithValue("@modalidade", tb_modalidade.Text);
            myCommand.Parameters.AddWithValue("@qtd_horas", tb_qtdHoras.Text);
            myCommand.Parameters.AddWithValue("@descricao", tb_descricao.Text);

            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);

            myCommand.CommandType = CommandType.StoredProcedure; 
            myCommand.CommandText = "registo_cursos"; //nome da SP

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery(); // não retorna dados

            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

            if (respostaSP == 1)
            {
                lbl_mensagem.Text = "Curso inserido com sucesso!";
            }

            else
                lbl_mensagem.Text = "Curso já existe, não pode ser criado novamente.";
            myConn.Close(); //fecha a conexao
        }

        protected void btn_criarModulo_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            myCommand.Parameters.AddWithValue("@nome_modulo", tb_nomeModulo.Text);
            myCommand.Parameters.AddWithValue("@duracao", tb_qtdHoras2.Text);
            myCommand.Parameters.AddWithValue("@numero_modulo", tb_numModulo.Text); /*int*/
                               
            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "registo_modulos"; //nome da SP

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery(); // não retorna dados

            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

            if (respostaSP == 1)
            {
                lbl_mensagem2.Text = "Modulo inserido com sucesso!";
            }

            else
                lbl_mensagem2.Text = "Modulo já existe, não pode ser criado novamente.";
            myConn.Close(); //fecha a conexao
        }

        protected void btn_criarSala_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            myCommand.Parameters.AddWithValue("@nome", tb_nomeSala.Text);
           
            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "registo_salas"; //nome da SP

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery(); // não retorna dados

            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

            if (respostaSP == 1)
            {
                lbl_mensagem3.Text = "Sala inserida com sucesso!";
            }

            else
                lbl_mensagem3.Text = "Sala já existe, não pode ser criada novamente.";
            myConn.Close(); //fecha a conexao
        }

        protected void btn_retornar_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx");
        }
    }
}