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
//using iTextSharp.text; // para exportação pdf
//using iTextSharp.text.pdf; // para exportação pdf
//using iTextSharp.text.html.simpleparser; // para exportação pdf
using System.Net; // enviar e-mail
using System.Net.Mail; // enviar e-mail
using System.Drawing; // para usar com as imagens
using System.Text.RegularExpressions;

namespace Projetoteste
{
    public partial class alterarsenha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
            {

            }
            else
            {
                // se não estiver na sessão, volta ao login
                Response.Redirect("index.aspx");
            }
        }

        protected void btn_changePw_Click(object sender, EventArgs e)
        {
            // Obter o nome do usuário da sessão
            string nomeUser = Session["nome"].ToString();

            // Obter o ID do usuário baseado no nome de usuário
            int codUser = ObterCodUserPeloNome(nomeUser);

            if (codUser != 0) // Verificar se o código do usuário foi obtido com sucesso
            {
                string atualPassword = tb_atualPw.Text;
                string newPassword = tb_newPw.Text;
                string confirmPassword = tb_confNewPw.Text;

                if (newPassword != confirmPassword)
                {
                    lbl_mensagem.Text = "As senhas não coincidem.";
                    return; // Retorna para evitar continuar o processamento do registro
                }

                Regex regexSenha = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,20}$"); // Tamanho mínimo e máximo da senha
                bool senhaValida = regexSenha.IsMatch(newPassword);

                if (!senhaValida)
                {
                    lbl_mensagem.Text = "A senha não atende aos critérios de complexidade.";
                    return; // Retorna para evitar continuar o processamento do registro
                }

                // Chamar a base de dados para verificar se a senha atual está correta
                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand();

                    myCommand.Parameters.AddWithValue("@nome", Session["nome"].ToString());
                    myCommand.Parameters.AddWithValue("@atualPw", atualPassword);
                    myCommand.Parameters.AddWithValue("@newPw", EncryptString(newPassword));
                    myCommand.Parameters.AddWithValue("@confNewPw", EncryptString(confirmPassword));

                    // Parâmetro de saída (output) para a mensagem
                    SqlParameter mensagemParam = new SqlParameter("@mensagem", SqlDbType.NVarChar, -1);
                    mensagemParam.Direction = ParameterDirection.Output;
                    myCommand.Parameters.Add(mensagemParam);

                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.CommandText = "alterar_PW"; // Nome da stored procedure

                    myCommand.Connection = myConn;
                    myConn.Open();
                    myCommand.ExecuteNonQuery(); // Executar a stored procedure

                    // Obter a mensagem de saída
                    string mensagem = mensagemParam.Value.ToString();

                    // Exibir a mensagem na sua página
                    lbl_mensagem.Text = mensagem;
                }
            }
        }

        private int ObterCodUserPeloNome(string nome)
        {
            int codUser = 0;

            // Consultar o banco de dados e obter o cod_user baseado no nome do usuário
            string query = $"SELECT cod_user FROM users WHERE nome = '{nome}'";

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, myConn);

                try
                {
                    myConn.Open();

                    // ExecuteScalar retorna um objeto, faz a conversão para int diretamente
                    object result = command.ExecuteScalar();
                    if (result != null && int.TryParse(result.ToString(), out codUser))
                    {
                        // Valor de codUser atualizado com sucesso
                    }
                    else
                    {
                        // Trate o caso em que não foi possível obter um cod_user
                        // Isso pode indicar que o usuário não foi encontrado no banco de dados
                        lbl_mensagem.Text = "Falha ao obter o código do usuário.";
                    }
                }
                catch (Exception ex)
                {
                    // Tratar a exceção
                    lbl_mensagem.Text = "Ocorreu um erro ao obter o código do usuário: " + ex.Message;
                }
            }
            return codUser;
        }

        public static string EncryptString(string Message)
        {
            string Passphrase = "cinel";
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the encoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]
            byte[] DataToEncrypt = UTF8.GetBytes(Message);

            // Step 5. Attempt to encrypt the string
            try
            {
                ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
                Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the encrypted string as a base64 encoded string
            string enc = Convert.ToBase64String(Results);
            enc = enc.Replace("+", "KKK");
            enc = enc.Replace("/", "JJJ");
            enc = enc.Replace("\\", "III");
            return enc;
        }
    }
}