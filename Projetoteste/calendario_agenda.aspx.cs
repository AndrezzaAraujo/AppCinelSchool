using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projetoteste
{
    public partial class calendario_agenda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
            {
                CodUsuario = GetCodigoUser(Session["nome"].ToString());
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        // Esta classe define a estrutura de um evento do calendário.
        public class CalendarEvents
        {            
            public DateTime data_inicio { get; set; }
            public DateTime data_fim { get; set; }
            public int status { get; set; }
            public int cod_user { get; set; }
        }

        // Esta propriedade estática é usada para armazenar o código do usuário atualmente logado.
        public static int CodUsuario { get; set; }
               
        [WebMethod(EnableSession = true)]
        public static List<object> CarregarEventosIndisponiveis()
        {
            //Cria uma lista para armazenar os eventos indisponíveis recuperados do banco de dados
            List<object> eventosIndisponiveis = new List<object>();

            string query = "SELECT cod_indisponibilidade, data_inicio, data_fim FROM formadores_indisponibilidade WHERE cod_user = @cod_user";
            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, myConn);
                command.Parameters.AddWithValue("@cod_user", CodUsuario);

                try
                {
                    myConn.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        int codIndisponibilidade = Convert.ToInt32(reader["cod_indisponibilidade"]);
                        DateTime dataInicio = Convert.ToDateTime(reader["data_inicio"]);
                        DateTime dataFim = Convert.ToDateTime(reader["data_fim"]);

                        //cria um novo objeto anônimo e o adiciona à lista
                        eventosIndisponiveis.Add(new
                        {
                            id = codIndisponibilidade,
                            title = $"{dataInicio.ToString("HH:mm")} a {dataFim.ToString("HH:mm")} - Indisponível",
                            start = dataInicio.ToString("yyyy-MM-ddTHH:mm:ss"),
                            end = dataFim.ToString("yyyy-MM-ddTHH:mm:ss"),
                            icon = "trash"
                        });
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Trate a exceção conforme necessário
                }
            }
            return eventosIndisponiveis;
        }

        [WebMethod(EnableSession = true)]
        public static string excluirEvento(int eventId)
        {
            try
            {
                string constring = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
                using (SqlConnection myConn = new SqlConnection(constring))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM formadores_indisponibilidade WHERE cod_indisponibilidade = @eventId", myConn))
                    {
                        cmd.CommandType = CommandType.Text;
                        myConn.Open();
                        cmd.Parameters.AddWithValue("@eventId", eventId);
                        cmd.ExecuteNonQuery();
                        myConn.Close();
                    }
                }
                return "Sucesso";
            }
            catch (Exception ex)
            {
                return "failure";
            }
        }

        // Método que bloqueia um dia específico para um usuário
        [WebMethod(EnableSession = true)]
        public static string bloquearDia(string selectedDate, string startTime, string endTime)
        {
            try
            {
                // Verifica se o horário de término é posterior ao horário de início
                if (DateTime.Parse(endTime) <= DateTime.Parse(startTime))
                {
                    return "O horário de término deve ser posterior ao horário de início.";
                }

                string constring = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
                using (SqlConnection myConn = new SqlConnection(constring))
                {
                    string query = "SELECT COUNT(*) FROM formadores_indisponibilidade WHERE (@data_inicio BETWEEN data_inicio AND data_fim OR @data_fim BETWEEN data_inicio AND data_fim) OR (data_inicio BETWEEN @data_inicio AND @data_fim OR data_fim BETWEEN @data_inicio AND @data_fim)";
                    using (SqlCommand checkCmd = new SqlCommand(query, myConn))
                    {
                        // Define os parâmetros da consulta
                        checkCmd.Parameters.AddWithValue("@data_inicio", DateTime.Parse(selectedDate + " " + startTime));
                        checkCmd.Parameters.AddWithValue("@data_fim", DateTime.Parse(selectedDate + " " + endTime));

                        myConn.Open();
                        // Executa a consulta e obtém o número de eventos conflitantes
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            return "Já existe um evento dentro deste intervalo de tempo.";
                        }
                    }

                    // Cria um novo evento de calendário
                    var newEvent = new CalendarEvents();
                    newEvent.data_inicio = DateTime.Parse(selectedDate + " " + startTime);
                    newEvent.data_fim = DateTime.Parse(selectedDate + " " + endTime);
                    newEvent.cod_user = CodUsuario;
                    newEvent.status = 1;

                    using (SqlCommand cmd = new SqlCommand("INSERT INTO formadores_indisponibilidade (data_inicio, data_fim, status, cod_user) VALUES (@data_inicio, @data_fim, @status, @cod_user)", myConn))
                    {
                        cmd.Parameters.AddWithValue("@data_inicio", newEvent.data_inicio);
                        cmd.Parameters.AddWithValue("@data_fim", newEvent.data_fim);
                        cmd.Parameters.AddWithValue("@status", newEvent.status);
                        cmd.Parameters.AddWithValue("@cod_user", newEvent.cod_user);

                        cmd.ExecuteNonQuery();
                    }
                }
                return "Sucesso";
            }
            catch (Exception ex)
            {
                return "Erro ao bloquear dia: " + ex.Message;
            }
        }

        // Método privado que retorna o código do usuário com base no nome do usuário
        private int GetCodigoUser(string nomeUser)
        {
            int codUser = 0;
            string query = "SELECT cod_user FROM users WHERE nome = @nome";

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, myConn);
                command.Parameters.AddWithValue("@nome", nomeUser);

                try
                {
                    myConn.Open();
                    codUser = Convert.ToInt32(command.ExecuteScalar());
                }
                catch (Exception ex)
                {
                    // Trate a exceção conforme necessário
                }
            }
            return codUser;
        }
    }
}