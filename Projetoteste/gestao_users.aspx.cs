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
using System.Drawing; // adicionado

namespace Projetoteste
{
    public partial class gestao_users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica se o nome do usuário está na sessão
            if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
            {
                if (!IsPostBack)
                {
                    // Verifica se há dados na variável de sessão e, se houver, vincula-os ao Repeater
                    if (Session["SearchResults"] != null)
                    {
                        rpt_gestaoUsers.DataSource = (DataTable)Session["SearchResults"];
                        rpt_gestaoUsers.DataBind();
                    }
                }
            }
            else
            {
                // Se não estiver na sessão, volta ao index
                Response.Redirect("index.aspx");
            }            
        }

        protected void rpt_gestaoUsers_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //obtém os dados dos users
                DataRowView dr = (DataRowView)e.Item.DataItem;

                //procura no repeater o objeto label e textbox, convertendo o que vem no dr (DataRowView)
                ((Label)e.Item.FindControl("lbl_cod")).Text = dr["cod_user"].ToString();
                ((TextBox)e.Item.FindControl("tb_nome")).Text = dr["nome"].ToString();
                ((TextBox)e.Item.FindControl("tb_email")).Text = dr["email"].ToString();
                ((TextBox)e.Item.FindControl("tb_nif")).Text = dr["nif"].ToString();
                ((TextBox)e.Item.FindControl("tb_telefone")).Text = dr["telefone"].ToString();
                ((TextBox)e.Item.FindControl("tb_morada")).Text = dr["morada"].ToString();
                ((CheckBox)e.Item.FindControl("ckb_secretaria")).Checked = Convert.ToBoolean(dr["secretaria"]);
                ((CheckBox)e.Item.FindControl("ckb_formador")).Checked = Convert.ToBoolean(dr["formador"]);
                ((CheckBox)e.Item.FindControl("ckb_formando")).Checked = Convert.ToBoolean(dr["formando"]);
                ((CheckBox)e.Item.FindControl("ckb_candidato")).Checked = Convert.ToBoolean(dr["candidato"]);
                ((CheckBox)e.Item.FindControl("ckb_ativo")).Checked = Convert.ToBoolean(dr["ativo"]);
                
                if (!(dr["foto"] is DBNull))
                {
                    byte[] fotoBytes = (byte[])dr["foto"];

                    // Redimensiona a imagem para o tamanho desejado
                    using (MemoryStream ms = new MemoryStream(fotoBytes))
                    {
                        try
                        {
                            using (System.Drawing.Image imagemOriginal = System.Drawing.Image.FromStream(ms))
                            {
                                int larguraDesejada = 100; // Defina a largura desejada
                                int alturaDesejada = 100; // Defina a altura desejada

                                using (System.Drawing.Image imagemRedimensionada = RedimensionarImagem(imagemOriginal, larguraDesejada, alturaDesejada))
                                {
                                    // Converte a imagem redimensionada para Base64
                                    using (MemoryStream msRedimensionada = new MemoryStream())
                                    {
                                        imagemRedimensionada.Save(msRedimensionada, System.Drawing.Imaging.ImageFormat.Jpeg);
                                        byte[] fotoRedimensionadaBytes = msRedimensionada.ToArray();
                                        string fotoRedimensionadaBase64 = Convert.ToBase64String(fotoRedimensionadaBytes);

                                        // Define a URL da imagem redimensionada
                                        ((System.Web.UI.WebControls.Image)e.Item.FindControl("img_foto")).ImageUrl = $"data:image/jpeg;base64,{fotoRedimensionadaBase64}";
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            // Lidar com a exceção
                            Console.WriteLine("Erro ao carregar imagem: " + ex.Message);
                        }
                    }
                }
                else
                {
                    // Se o campo de foto for nulo, define a imagem padrão
                    string caminhoImagemPadrao = Server.MapPath("~/img/imagem_padrao.png"); // Obtém o caminho completo da imagem padrão
                    using (System.Drawing.Image imagemOriginal = System.Drawing.Image.FromFile(caminhoImagemPadrao))
                    {
                        int larguraDesejada = 100; // Defina a largura desejada
                        int alturaDesejada = 100; // Defina a altura desejada

                        using (System.Drawing.Image imagemRedimensionada = RedimensionarImagem(imagemOriginal, larguraDesejada, alturaDesejada))
                        {
                            // Converte a imagem redimensionada para Base64
                            using (MemoryStream msRedimensionada = new MemoryStream())
                            {
                                imagemRedimensionada.Save(msRedimensionada, System.Drawing.Imaging.ImageFormat.Png);
                                byte[] fotoRedimensionadaBytes = msRedimensionada.ToArray();
                                string fotoRedimensionadaBase64 = Convert.ToBase64String(fotoRedimensionadaBytes);

                                // Define a URL da imagem padrão redimensionada
                                ((System.Web.UI.WebControls.Image)e.Item.FindControl("img_foto")).ImageUrl = $"data:image/png;base64,{fotoRedimensionadaBase64}";
                            }
                        }
                    }
                }                
                ((ImageButton)e.Item.FindControl("imgBtn_editar")).CommandArgument = dr["cod_user"].ToString();
                ((ImageButton)e.Item.FindControl("imgBtn_deletar")).CommandArgument = dr["cod_user"].ToString();
            }
        }

        protected void rpt_gestaoUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName.Equals("imgBtn_editar"))
            {
                string query = "UPDATE users SET ";

                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    query += "nome = @nome, ";
                    query += "email = @email, ";
                    query += "nif = @nif, ";
                    query += "telefone = @telefone, ";
                    query += "morada = @morada, ";
                    query += "foto = @foto, ";
                    query += "secretaria = @secretaria, ";
                    query += "formador = @formador, ";
                    query += "formando = @formando, ";
                    query += "candidato = @candidato, ";
                    query += "ativo = @ativo ";
                    query += "WHERE cod_user = @codUser";

                    using (SqlCommand myCommand = new SqlCommand(query, myConn))
                    {
                        myCommand.Parameters.AddWithValue("@nome", ((TextBox)e.Item.FindControl("tb_nome")).Text);
                        myCommand.Parameters.AddWithValue("@email", ((TextBox)e.Item.FindControl("tb_email")).Text);
                        myCommand.Parameters.AddWithValue("@nif", ((TextBox)e.Item.FindControl("tb_nif")).Text);
                        myCommand.Parameters.AddWithValue("@telefone", ((TextBox)e.Item.FindControl("tb_telefone")).Text);
                        myCommand.Parameters.AddWithValue("@morada", ((TextBox)e.Item.FindControl("tb_morada")).Text.Replace(",", "."));

                        string fotoBase64 = ((System.Web.UI.WebControls.Image)e.Item.FindControl("img_foto")).ImageUrl;
                        if (!string.IsNullOrEmpty(fotoBase64) && fotoBase64.Contains(","))
                        {
                            fotoBase64 = fotoBase64.Split(',')[1];
                        }
                        else
                        {
                            string caminhoImagemPadrao = Server.MapPath("~/img/imagem_padrao.png");
                            using (System.Drawing.Image imagemPadrao = System.Drawing.Image.FromFile(caminhoImagemPadrao))
                            {
                                int larguraDesejada = 100;
                                int alturaDesejada = 100;

                                using (System.Drawing.Image imagemRedimensionada = RedimensionarImagem(imagemPadrao, larguraDesejada, alturaDesejada))
                                {
                                    using (MemoryStream msRedimensionada = new MemoryStream())
                                    {
                                        imagemRedimensionada.Save(msRedimensionada, System.Drawing.Imaging.ImageFormat.Png);
                                        byte[] fotoRedimensionadaBytes = msRedimensionada.ToArray();
                                        fotoBase64 = Convert.ToBase64String(fotoRedimensionadaBytes);
                                    }
                                }
                            }
                        }

                        ((System.Web.UI.WebControls.Image)e.Item.FindControl("img_foto")).ImageUrl = $"data:image/png;base64,{fotoBase64}";

                        byte[] fotoBytes = Convert.FromBase64String(fotoBase64);
                        myCommand.Parameters.AddWithValue("@foto", fotoBytes);

                        myCommand.Parameters.AddWithValue("@secretaria", ((CheckBox)e.Item.FindControl("ckb_secretaria")).Checked ? 1 : 0);
                        myCommand.Parameters.AddWithValue("@formador", ((CheckBox)e.Item.FindControl("ckb_formador")).Checked ? 1 : 0);
                        myCommand.Parameters.AddWithValue("@formando", ((CheckBox)e.Item.FindControl("ckb_formando")).Checked ? 1 : 0);
                        myCommand.Parameters.AddWithValue("@candidato", ((CheckBox)e.Item.FindControl("ckb_candidato")).Checked ? 1 : 0);
                        myCommand.Parameters.AddWithValue("@ativo", ((CheckBox)e.Item.FindControl("ckb_ativo")).Checked ? 1 : 0);

                        myCommand.Parameters.AddWithValue("@codUser", ((ImageButton)e.Item.FindControl("imgBtn_editar")).CommandArgument);

                        try
                        {
                            myConn.Open();
                            int rowsAffected = myCommand.ExecuteNonQuery();

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
                        finally
                        {
                            myConn.Close();
                        }
                    }
                }
            }
                if (e.CommandName.Equals("imgBtn_deletar"))
                {
                    string query1 = "DELETE FROM users WHERE ";

                    SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                    myConn.Open();

                    query1 += "cod_user=" + ((Label)e.Item.FindControl("lbl_cod")).Text;

                    SqlCommand MyCommand = new SqlCommand(query1, myConn);
                    MyCommand.ExecuteNonQuery();

                    myConn.Close();
                    rpt_gestaoUsers.DataBind();
                }
            
        }

        // Método para redimensionar a imagem
        private System.Drawing.Image RedimensionarImagem(System.Drawing.Image imagemOriginal, int largura, int altura)
        {
            var ret = new Bitmap(largura, altura);
            using (var graphics = Graphics.FromImage(ret))
            {
                graphics.DrawImage(imagemOriginal, 0, 0, largura, altura);
            }
            return ret;
        }
        protected void img_lupa_Click(object sender, ImageClickEventArgs e)
        {
            string palavra = tb_search.Text.Trim(); // Remover espaços em branco extras

            if (!string.IsNullOrEmpty(palavra))
            {
                string query = "SELECT * FROM users WHERE nome LIKE '%" + palavra + "%'";

                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

                SqlCommand myCommand = new SqlCommand(query, myConn);

                SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
                DataSet myDataSet = new DataSet();

                // Preenche o DataSet com os dados do banco de dados
                myAdapter.Fill(myDataSet, "users");

                // Filtra os dados com base na palavra-chave
                DataTable dtFiltered = myDataSet.Tables["users"].Clone(); // Cria uma cópia da estrutura da tabela
                foreach (DataRow row in myDataSet.Tables["users"].Rows)
                {
                    if (row["nome"].ToString().IndexOf(palavra, StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        dtFiltered.ImportRow(row); // Adiciona a linha à tabela filtrada se o título corresponder à palavra-chave
                    }
                }
                // Armazena os resultados da pesquisa na variável de sessão
                Session["SearchResults"] = dtFiltered;

                // Itera sobre as linhas do Repeater e define a visibilidade com base nos resultados da pesquisa
                foreach (RepeaterItem item in rpt_gestaoUsers.Items)
                {
                    // Obtém o Label com o nome
                    TextBox txtNome = (TextBox)item.FindControl("tb_nome");

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
                foreach (RepeaterItem item in rpt_gestaoUsers.Items)
                {
                    item.Visible = true;
                }
            }
        }
        private void BindRepeaterData()
        {
            // Consulta SQL para selecionar todos os registros da tabela users
            string query = "SELECT * FROM users";

            // Lista para armazenar os resultados da consulta
            List<User> users = new List<User>();

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
                                User user = new User();
                                user.Cod_user = Convert.ToInt32(reader["cod_user"]);
                                user.Nome = reader["nome"].ToString();
                                // Preencha os outros campos conforme necessário...

                                // Adiciona o usuário à lista
                                users.Add(user);
                            }
                        }
                    }
                }
                // Fecha a conexão
                myConn.Close();
            }
            // Chama o método DataBind para associar os dados ao Repeater
            rpt_gestaoUsers.DataBind();
        }

        public class User
        {
            // Propriedades da classe User
            public int Cod_user { get; set; }
            public string Nome { get; set; }
            public string Email { get; set; }
            public string Nif { get; set; }
            public string Telefone { get; set; }
            public string Morada { get; set; }
            public byte[] Foto { get; set; }
            public bool Secretaria { get; set; }
            public bool Formador { get; set; }
            public bool Formando { get; set; }
            public bool Candidato { get; set; }
            public bool Ativo { get; set; }
        }

        protected void ddl_perfil_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Inicializa a parte da query que traz todos os registros
            string query = "SELECT * FROM users WHERE 1 = 1";

            // Verifica se o perfil "Secretaria" deve ser incluído na consulta
            if (ddl_perfil.SelectedIndex == 0)
            {
                query += " AND secretaria = 1";
            }

            // Verifica se o perfil "Formador" deve ser incluído na consulta
            if (ddl_perfil.SelectedIndex == 1)
            {
                query += " AND formador = 1";
            }

            // Verifica se o perfil "Formando" deve ser incluído na consulta
            if (ddl_perfil.SelectedIndex == 2)
            {
                query += " AND formando = 1";
            }

            // Verifica se o perfil "Candidato" deve ser incluído na consulta
            if (ddl_perfil.SelectedIndex == 3)
            {
                query += " AND candidato = 1";
            }

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand(query, myConn);

            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            DataSet myDataSet = new DataSet();

            // Preenche o DataSet com os dados do banco de dados
            myAdapter.Fill(myDataSet, "users");

            SqlDataSource1.SelectCommand = query;
            rpt_gestaoUsers.DataBind();
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

        protected void btn_retornar_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx");
        }

        protected void lbtn_previous_Click(object sender, EventArgs e)
        {
            // código em JS
        }

        protected void lbtn_next_Click(object sender, EventArgs e)
        {
            // código em JS
        }
    }
}