using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace Projetoteste
{
    public partial class dashboard1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT [area], COUNT(*) AS 'NumeroCursos' FROM [cursos] GROUP BY [area]", conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    int index = 0; // índice para acessar a lista de cores
                    List<string> cores = new List<string> { "#ad76c5", "#9ac297", "#fbf2a8" };

                    while (reader.Read())
                    {
                        string area = reader["area"].ToString();
                        int numCursos = Convert.ToInt32(reader["NumeroCursos"]);

                        // Verifica se a lista de cores já acabou, se sim, reinicia o índice
                        if (index >= cores.Count)
                            index = 0;

                        // Adicione os pontos de dados ao gráfico
                        DataPoint dataPoint = new DataPoint();
                        dataPoint.AxisLabel = area;
                        dataPoint.YValues = new double[] { numCursos };
                        dataPoint.Color = System.Drawing.ColorTranslator.FromHtml(cores[index]);
                        barChart.Series["Series1"].Points.Add(dataPoint);

                        index++; // Move para a próxima cor na lista
                    }

                }
            }
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand();

            //parameters de outpts, ou seja, que devolva coisas do SQL para o C# (página)
            SqlParameter valor1 = new SqlParameter();
            valor1.ParameterName = "@total_formandos";
            valor1.Direction = ParameterDirection.Output;
            valor1.SqlDbType = SqlDbType.Int;
            myCommand.Parameters.Add(valor1);

            //chamar a stored procedure
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "dashboard"; //nome da stored procedure

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery();//expulsão para a base de dados que não retorna dados, insert

            //instancia das variáveis
            int total_formandos = Convert.ToInt32(myCommand.Parameters["@total_formandos"].Value);

            //instancia das variáveis
            //int total_cursosDec = Convert.ToInt32(myCommand.Parameters["@total_cu"].Value);

            lbl_mensagem1.Text = $"Total de formandos a frequentar o curso é: {total_formandos}";
            lbl_mensagem1.Font.Size = FontUnit.Large; // Definindo o tamanho da fonte
            lbl_mensagem1.Font.Bold = true; // Tornando a fonte em negrito
        }
    }
}