using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Projetoteste.gestao_modulos;

namespace Projetoteste
{
    public partial class calendario : System.Web.UI.Page
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

        [WebMethod]
        public static string carregarTurma()
        {
            string query = $@"
                SELECT[cod_turma],[nome_turma] FROM [turmas]
               ";

            DataTable dt = new calendario().GetData(query);
            List<object> modulos = new List<object>();
            foreach (DataRow row in dt.Rows)
            {
                modulos.Add(new { Value = row["cod_turma"].ToString(), Text = row["nome_turma"].ToString() });
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(modulos);
        }

        [WebMethod(EnableSession = true)]
        public static string CarregarCalendario(int codTurma)
        {
            List<object> eventos = new List<object>();
            string query = @"
                           SELECT
                            ma.cod_marcacao_aula,
                            ma.data_inicio,
                            ma.data_fim,
                            t.nome_turma,
                            s.nome as nome_sala,
                            m.nome_modulo,
				            u.nome as nome_professor
                        FROM
                            marcacao_aulas ma
                            JOIN turmas t ON ma.cod_turma = t.cod_turma
                            JOIN salas s ON ma.cod_sala = s.cod_sala
                            JOIN modulos m ON ma.cod_modulo = m.cod_modulo
				            JOIN users u ON u.cod_user = ma.cod_user
                        WHERE
                            ma.cod_turma = @codTurma;
                ;
                ";

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, myConn);
                command.Parameters.AddWithValue("@codTurma", codTurma);

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
                            modulo = reader["nome_modulo"],
                            professor = reader["nome_professor"]
                        });
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    return new JavaScriptSerializer().Serialize(new { error = ex.Message });
                }
                finally
                {
                    myConn.Close();
                }
            }
            return new JavaScriptSerializer().Serialize(eventos);
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
    }
}