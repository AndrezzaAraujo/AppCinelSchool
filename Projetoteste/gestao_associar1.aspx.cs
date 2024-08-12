using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projetoteste
{
    public partial class gestao_associar1 : System.Web.UI.Page
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

        protected void btn_associar_Click(object sender, EventArgs e)
        {
            int horasTotaisCurso = ObterCargaHorariaDoCurso(int.Parse(ddl_escolher.SelectedValue));
            int duracaoSelecionadas = 0;
            List<int> codigosModulosSelecionados = new List<int>();

            foreach (ListItem item in lb_modulos.Items)
            {
                if (item.Selected)
                {
                    int cod_modulo = int.Parse(item.Value);
                    codigosModulosSelecionados.Add(cod_modulo);
                }
            }

            duracaoSelecionadas = ObterDuracaoDosModulos(codigosModulosSelecionados.ToArray());

            if (duracaoSelecionadas > horasTotaisCurso)
            {
                lbl_mensagem.Text = "A quantidade de horas selecionadas ultrapassa o total do curso. Não é possível adicionar mais módulos.";
                return;
            }

            lbl_horas_totais.Text = "Horas totais do curso: " + horasTotaisCurso;
            lbl_horas_selecionadas.Text = "Totais selecionadas: " + duracaoSelecionadas;

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                myConn.Open();

                // Chamar a Stored Procedure para associar o módulo ao curso
                SqlCommand myCommand = new SqlCommand("associar_moduloCurso", myConn);
                myCommand.CommandType = CommandType.StoredProcedure;

                // Adicionar parâmetros
                myCommand.Parameters.AddWithValue("@cod_curso", ddl_escolher.SelectedValue);
                SqlParameter retorno = new SqlParameter("@retorno", SqlDbType.Int);
                retorno.Direction = ParameterDirection.Output;
                myCommand.Parameters.Add(retorno);

                // Adicionar parâmetro @cod_modulo uma vez fora do loop
                SqlParameter paramCodModulo = myCommand.Parameters.Add("@cod_modulo", SqlDbType.Int);

                // Iterar sobre os itens da ListBox
                foreach (ListItem item in lb_modulos.Items)
                {
                    if (item.Selected)
                    {
                        paramCodModulo.Value = int.Parse(item.Value);

                        int rowsAffected = myCommand.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lbl_mensagem.Text = "Associação efetuada com sucesso!";
                        }
                        else
                        {
                            lbl_mensagem.Text = "Erro ao associar módulo. Tente novamente.";
                        }
                    }
                }

                int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

                if (respostaSP == 1)
                {
                    lbl_mensagem.Text = "Associação efetuada com sucesso!";
                }
                else
                {
                    lbl_mensagem.Text = "Associação já existe, não pode ser associado novamente.";
                }
            }
        }

        // Método para obter as horas de um módulo específico do banco de dados
        private int ObterCargaHorariaDoCurso(int cod_curso)
        {
            int horas = 0;

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                myConn.Open();

                // Consulta para obter a carga horária do curso
                SqlCommand cmdCargaHoraria = new SqlCommand("SELECT qtd_horas FROM cursos WHERE cod_curso = @cod_curso", myConn);
                cmdCargaHoraria.Parameters.AddWithValue("@cod_curso", cod_curso);

                // Obtém a carga horária do curso
                int qtd_horas = (int)cmdCargaHoraria.ExecuteScalar();

                horas = qtd_horas;
                // Remove todos os caracteres que não são dígitos
                //string horasString = new string(qtd_horas.Where(char.IsDigit).ToArray());

                // Converte a carga horária para um inteiro antes de retornar
                //horas = Convert.ToInt32();
            }
            return horas;
        }

        [System.Web.Services.WebMethod]
        public static int ObterDuracaoDosModulos(int[] cod_modulos)
        {
            // Criar uma lista para armazenar as durações dos módulos selecionados
            List<int> duracoes = new List<int>();

            // Consultar o banco de dados para obter as durações dos módulos
            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                myConn.Open();

                foreach (int cod_modulo in cod_modulos)
                {
                    SqlCommand cmdDuracao = new SqlCommand("SELECT duracao FROM modulos WHERE cod_modulo = @cod_modulo", myConn);
                    cmdDuracao.Parameters.AddWithValue("@cod_modulo", cod_modulo);

                    // Obtém a duração do módulo e adiciona à lista de durações
                    object duracaoObject = cmdDuracao.ExecuteScalar();
                    if (duracaoObject != DBNull.Value)
                    {
                        int duracaoModulo = (int)duracaoObject;
                        duracoes.Add(duracaoModulo);
                    }
                }
            }
            // Retorna a soma das durações dos módulos selecionados
            return duracoes.Sum();
        }

        protected void ddl_escolher_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Obter o código do curso selecionado na DropDownList
            int cod_curso = int.Parse(ddl_escolher.SelectedValue);

            // Obter a carga horária do curso selecionado
            int horasTotaisCurso = ObterCargaHorariaDoCurso(cod_curso);

            // Exibir o total de horas na Label
            lbl_horas_totais.Text = "Horas totais do curso: " + horasTotaisCurso;
        }
    }
}