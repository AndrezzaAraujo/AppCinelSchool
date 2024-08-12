using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Linq;

namespace Projetoteste
{
    public partial class marcacao_aulas : Page
    {
        public class ProfessorCalendario
        {
            public int cod_marcacao_aula { get; set; }
            public int cod_user { get; set; }
            public int cod_turma { get; set; }
            public int cod_sala { get; set; }
            public int cod_modulo { get; set; }
            public DateTime data_inicio { get; set; }
            public DateTime data_fim { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
                {
                    BindProfessorDropdown();
                    BindTurmaDropdown();
                    BindSalaDropdown();
                    BindModuloDropdown();
                }
                else
                {
                    Response.Redirect("index.aspx");
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string CarregarCalendario(int codProfessor)
        {
            List<object> eventos = new List<object>();
            string query = @"
        SELECT
            ma.cod_marcacao_aula,
            ma.data_inicio,
            ma.data_fim,
            t.nome_turma,
            s.nome as nome_sala,
            m.nome_modulo
        FROM
            marcacao_aulas ma
            JOIN turmas t ON ma.cod_turma = t.cod_turma
            JOIN salas s ON ma.cod_sala = s.cod_sala
            JOIN modulos m ON ma.cod_modulo = m.cod_modulo
        WHERE
            ma.cod_user = @cod_user;
            ";

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, myConn);
                command.Parameters.AddWithValue("@cod_user", codProfessor);

                try
                {
                    myConn.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        eventos.Add(new
                        {
                            id = reader["cod_marcacao_aula"],
                            title = $"{reader["nome_turma"]} - {reader["nome_modulo"]} sala {reader["nome_sala"]}",
                            start = Convert.ToDateTime(reader["data_inicio"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                            end = Convert.ToDateTime(reader["data_fim"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                            turma = reader["nome_turma"],
                            sala = reader["nome_sala"],
                            modulo = reader["nome_modulo"]
                        });
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Handle exception
                    return new JavaScriptSerializer().Serialize(new { error = ex.Message });
                }
                finally
                {
                    myConn.Close();
                }
            }
            return new JavaScriptSerializer().Serialize(eventos);
        }

        [WebMethod(EnableSession = true)]
        public static List<HorarioDisponivel> CarregarEventosDatasIndispolivel(int codProfessor, string data)
        {
            List<HorarioDisponivel> horariosIndisponiveis = new List<HorarioDisponivel>();
            DateTime dataSelecionada = DateTime.Parse(data);
            DateTime inicioDia = new DateTime(dataSelecionada.Year, dataSelecionada.Month, dataSelecionada.Day, 0, 0, 0);
            DateTime fimDia = new DateTime(dataSelecionada.Year, dataSelecionada.Month, dataSelecionada.Day, 23, 59, 59);

            string connectionString = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string queryIndisponibilidades = @"
                SELECT data_inicio, data_fim
                FROM formadores_indisponibilidade
                WHERE cod_user = @cod_user AND data_inicio >= @inicioDia AND data_fim <= @fimDia
                ORDER BY data_inicio";

                SqlCommand cmd = new SqlCommand(queryIndisponibilidades, con);
                cmd.Parameters.AddWithValue("@cod_user", codProfessor);
                cmd.Parameters.AddWithValue("@inicioDia", inicioDia);
                cmd.Parameters.AddWithValue("@fimDia", fimDia);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        DateTime start = Convert.ToDateTime(reader["data_inicio"]);
                        DateTime end = Convert.ToDateTime(reader["data_fim"]);

                        horariosIndisponiveis.Add(new HorarioDisponivel
                        {
                            Start = start.ToString("HH:mm"),
                            End = end.ToString("HH:mm")
                        });
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Erro ao acessar o banco de dados: " + ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }
            return horariosIndisponiveis;
        }

        public class HorarioDisponivel
        {
            public string Start { get; set; }
            public string End { get; set; }
        }

        private void BindProfessorDropdown()
        {
            string query = "SELECT cod_user, nome FROM users WHERE formador = 1 AND ativo = 1";
            professorDropdown.DataSource = GetData(query);
            professorDropdown.DataTextField = "nome";
            professorDropdown.DataValueField = "cod_user";
            professorDropdown.DataBind();

            professorDropdown.Items.Insert(0, new ListItem("Nenhum", "0"));

            professorDropdown.Items[0].Selected = true;
        }
        private void BindTurmaDropdown()
        {
            string query = "SELECT cod_turma, nome_turma FROM turmas";
            turmaDropdown.DataSource = GetData(query);
            turmaDropdown.DataTextField = "nome_turma";
            turmaDropdown.DataValueField = "cod_turma";
            turmaDropdown.DataBind();
        }

        private void BindSalaDropdown()
        {
            string query = "SELECT cod_sala, nome FROM salas";
            salaDropdown.DataSource = GetData(query);
            salaDropdown.DataTextField = "nome";
            salaDropdown.DataValueField = "cod_sala";
            salaDropdown.DataBind();
        }

        private void BindModuloDropdown()
        {
            if (!string.IsNullOrEmpty(turmaDropdown.SelectedValue))
            {
                string codCurso = turmaDropdown.SelectedValue;
                string query = $@"
                   SELECT DISTINCT  m.nome_modulo
                    FROM modulos_cursos AS mc
                    JOIN modulos AS m ON mc.cod_modulo = m.cod_modulo
                    JOIN turmas AS t ON mc.cod_curso = t.cod_curso
                    WHERE t.cod_turma = {codCurso}";

                moduloDropdown.DataSource = GetData(query);
                moduloDropdown.DataTextField = "nome_modulo";
                moduloDropdown.DataValueField = "cod_moduloCurso";
                moduloDropdown.DataBind();
            }
        }

        [WebMethod]
        public static string GetModulos(string codTurma)
        {
            string query = $@"
        SELECT DISTINCT mc.cod_modulo, m.nome_modulo
        FROM modulos_cursos AS mc
        JOIN modulos AS m ON mc.cod_modulo = m.cod_modulo
        JOIN turmas AS t ON mc.cod_curso = t.cod_curso
        WHERE t.cod_turma = {codTurma}";

            DataTable dt = new marcacao_aulas().GetData(query);
            List<object> modulos = new List<object>();
            foreach (DataRow row in dt.Rows)
            {
                modulos.Add(new { Value = row["cod_modulo"].ToString(), Text = row["nome_modulo"].ToString() });
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(modulos);

            //string query = $@"
            //    SELECT DISTINCT mc.cod_moduloCurso, m.nome_modulo
            //    FROM modulos_cursos AS mc
            //    JOIN modulos AS m ON mc.cod_modulo = m.cod_modulo
            //    JOIN turmas AS t ON mc.cod_curso = t.cod_curso
            //    WHERE t.cod_turma = {codTurma}";

            //DataTable dt = new marcacao_aulas().GetData(query);
            //List<object> modulos = new List<object>();
            //foreach (DataRow row in dt.Rows)
            //{
            //    modulos.Add(new { Value = row["cod_moduloCurso"].ToString(), Text = row["nome_modulo"].ToString() });
            //}

            //JavaScriptSerializer serializer = new JavaScriptSerializer();
            //return serializer.Serialize(modulos);
        }

        protected DataTable GetData(string query)
        {
            string connString = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        private static bool IsHorarioDisponivel(int codProfessor, DateTime dataInicio, DateTime dataFim)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                        SELECT COUNT(*) FROM formadores_indisponibilidade
                        WHERE cod_user = @codUser AND (
                            (data_inicio <= @dataInicio AND data_fim > @dataInicio) OR
                            (data_inicio < @dataFim AND data_fim >= @dataFim) OR
                            (data_inicio >= @dataInicio AND data_fim <= @dataFim)
                        )";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@codUser", codProfessor);
                cmd.Parameters.AddWithValue("@dataInicio", dataInicio);
                cmd.Parameters.AddWithValue("@dataFim", dataFim);

                try
                {
                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count == 0;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Erro ao verificar disponibilidade: " + ex.Message);
                    return false;
                }
                finally
                {
                    con.Close();
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string SalvarMarcacaoAula(int codUser, int codTurma, int codSala, int codModulo, DateTime dataInicio, DateTime dataFim)
        {
            if (!IsHorarioDisponivel(codUser, dataInicio, dataFim))
            {
                return "Horário não disponível para marcação.";
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            INSERT INTO marcacao_aulas (cod_user, cod_turma, cod_sala, cod_modulo, data_inicio, data_fim)
            VALUES (@codUser, @codTurma, @codSala, @codModulo, @dataInicio, @dataFim)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@codUser", codUser);
                cmd.Parameters.AddWithValue("@codTurma", codTurma);
                cmd.Parameters.AddWithValue("@codSala", codSala);
                cmd.Parameters.AddWithValue("@codModulo", codModulo);
                cmd.Parameters.AddWithValue("@dataInicio", dataInicio);
                cmd.Parameters.AddWithValue("@dataFim", dataFim);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    return "Marcação salva com sucesso!";
                }
                catch (Exception ex)
                {
                    return "Erro ao salvar a marcação: " + ex.Message;
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}
