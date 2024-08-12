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
    public partial class intranet : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
                {
                    string nome = Session["nome"].ToString();
                    //lbl_mensagem.Text = string.Format("Olá, {0}", nome);
                    lbl_mensagem.Text = string.Format("{0}", nome);

                    // Mostra os menus conforme as permissões do usuário
                    MostrarMenusConformePermissao(nome);
                }
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
        }
        public string ObterFuncoesUsuario(string nome)
        {
            // Conecte-se ao banco de dados
            using (SqlConnection conexao = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                conexao.Open();

                // Crie um comando para buscar as funções do usuário
                var comando = new SqlCommand("SELECT Secretaria, Formador, Formando, Candidato FROM users WHERE nome = @nome", conexao);
                comando.Parameters.AddWithValue("@nome", nome);

                // Execute o comando e obtenha os valores de secretaria, formador, formando e candidato
                using (SqlDataReader reader = comando.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Verifica cada função e retorna as que são iguais a 1
                        List<string> funcoes = new List<string>();
                        if (Convert.ToBoolean(reader["Secretaria"]))
                        {
                            funcoes.Add("secretaria");
                        }
                        if (Convert.ToBoolean(reader["Formador"]))
                        {
                            funcoes.Add("formador");
                        }
                        if (Convert.ToBoolean(reader["Formando"]))
                        {
                            funcoes.Add("formando");
                        }
                        if (Convert.ToBoolean(reader["Candidato"]))
                        {
                            funcoes.Add("candidato");
                        }

                        // Se não houver nenhuma função, retorna uma string vazia
                        if (funcoes.Count == 0)
                            return "";

                        // Se houver funções, retorna uma string com os nomes das funções separados por vírgula
                        return string.Join(",", funcoes);
                    }
                }
            }
            // Se não encontrar nenhuma função, retorna uma string vazia
            return "";
        }

        protected void MostrarMenusConformePermissao(string nome)
        {
            string funcoesUsuario = ObterFuncoesUsuario(nome);

            // Obtém todos os itens do menu
            var menus = new Dictionary<string, string>
            {
                {"secretaria", "menu-item secretaria"},
                {"formador", "menu-item formador"},
                {"formando", "menu-item formando"},
                {"candidato", "menu-item candidato"},
                {"logout", "menu-item logout"}
            };

            // Itera sobre os itens do menu
            foreach (var menu in menus)
            {
                // Verifica se o usuário possui a função correspondente ao item do menu
                if (funcoesUsuario.Contains(menu.Key))
                {
                    // Mostra o item do menu
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "show_" + menu.Value,
                        "<script>document.getElementsByClassName('" + menu.Value + "')[0].style.display = 'block';</script>");
                }
                else
                {
                    // Oculta o item do menu
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "hide_" + menu.Value,
                        "<script>document.getElementsByClassName('" + menu.Value + "')[0].style.display = 'none';</script>");
                }
            }
        }
        protected string ObterVisibilidadeMenu(string nome, string funcao)
        {
            string funcoesUsuario = ObterFuncoesUsuario(nome);

            // Se o usuário é um candidato, todos os menus devem ser visíveis, exceto o de logout
            if (funcoesUsuario.Contains("candidato") && funcao != "logout")
            {
                return ""; // Mostra o item do menu
            }

            // Verifique se o usuário possui a função correspondente ao item do menu
            if (funcoesUsuario.Contains(funcao))
            {
                return ""; // Mostra o item do menu
            }
            else
            {
                return "style=\"display: none;\""; // Oculta o item do menu
            }
        }
    }
}