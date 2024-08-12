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
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            //parameters de inputs, ou seja, de passagem de conteúdo da página para o SQL
            myCommand.Parameters.AddWithValue("@nome", nome.Text);
            myCommand.Parameters.AddWithValue("@pw", EncryptString(password.Text));

            //parameters de outpts, ou seja, que devolva coisas do SQL para o C# (página)
            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "login"; //nome da stored procedure

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery();//expulsão para a base de dados que não retorna dados, insert

            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

            myConn.Close();//sempre fechar a conexão

            if (respostaSP == 1)
            {

                Session["nome"] = nome.Text;

                Response.Redirect("transition.aspx");
            }
            else if (respostaSP == 2)
            {
                lbl_mensagem1.Text = "Utilizador inativo, deverá ativar a conta via email!";
            }
            else
            {
                lbl_mensagem1.Text = "Utilizador e/ou palavra-passe errados!";
            }
            // Limpar as mensagens de validação
            RequiredFieldValidator6.ErrorMessage = "";
            RequiredFieldValidator7.ErrorMessage = "";
        }

        // registro
        protected void signup_Click(object sender, EventArgs e) //registo formandos
        {
            //Response.Redirect("registo.aspx");
            string password = tb_password.Text;

            if (password.Length != 8)
            {
                lbl_mensagem2.Text = "A palavra-passe deve ter pelo menos 8 caracteres.";
                return; // Retorna para evitar continuar o processamento do registro
            }
            //para evitar 26 ifs das maiúsculas
            Regex maiusculas = new Regex("[A-Z]");
            Regex minusculas = new Regex("[a-z]");
            Regex numeros = new Regex("[0-9]");
            Regex pelica = new Regex(" ' ");
            Regex especiais = new Regex("[^A-Za-z0-9]");//tudo que não estiver nos itens anteriores//o acento ^ é a negação em regex

            bool forte = true; //por defeito todas as palavras pass são fortes

            if (tb_password.Text.Length < 8)
            {
                forte = false; //true
            }
            else if (maiusculas.Matches(tb_password.Text).Count == 0)//não há maiúscula
            {
                forte = false;
            }
            else if (minusculas.Matches(tb_password.Text).Count == 0) //não há minuscula
            {
                forte = false;
            }
            else if (especiais.Matches(tb_password.Text).Count == 0) //não há carater especial
            {
                forte = false;
            }
            else if (pelica.Matches(tb_password.Text).Count > 0) //há pelica
            {
                forte = false;
            }
            else { lbl_mensagem2.Text = $"Forte:{forte}"; }

            if (!forte)
            {
                lbl_mensagem2.Text = "A palavra-passe não atende aos critérios de complexidade.";
                return; // Retorna para evitar continuar o processamento do registro
            }            

            using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
            {
                myConn.Open();

                using (SqlCommand myCommand = new SqlCommand())
                {
                    myCommand.Connection = myConn;
                    myCommand.CommandType = CommandType.StoredProcedure;

                    // Parâmetros de input- registar cliente
                    myCommand.CommandText = "registo_users";
                    myCommand.Parameters.AddWithValue("@nome", name.Text);
                    myCommand.Parameters.AddWithValue("@email", tb_email.Text);
                    myCommand.Parameters.AddWithValue("@pw", EncryptString(tb_password.Text));

                    //devolve a informação do SQL para a página
                    SqlParameter valor = new SqlParameter();
                    valor.ParameterName = "@retorno";
                    valor.Direction = ParameterDirection.Output;
                    valor.SqlDbType = SqlDbType.Int;// se inseriu devolve 1 , se não inseriu devolve 0

                    //busca o valor do SQL
                    myCommand.Parameters.Add(valor);

                    // Executar o comando SQL para inserir os dados na base de dados
                    myCommand.ExecuteNonQuery();

                    //para apanhar o parameter output do retorno
                    int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

                    myConn.Close();

                    if (respostaSP == 1) //
                    {
                        lbl_mensagem2.Text = "Por favor ative a conta em seu e-mail!";

                        try
                        {
                            // Gere o link de ativação e encripta o nome do user
                            string activationLink = $"https://localhost:44385/ativacao.aspx?user={EncryptString(name.Text)}";

                            // Código para enviar o e-mail
                            SmtpClient servidor = new SmtpClient();
                            MailMessage email1 = new MailMessage();

                            email1.From = new MailAddress(ConfigurationManager.AppSettings["SMTPMailUser"], "Escola Cinel");
                            email1.To.Add(new MailAddress(tb_email.Text));
                            email1.Subject = "Ativação de Conta";
                            email1.IsBodyHtml = true;
                            email1.Body = $"Por favor, clique no link para ativar a conta:      <a href='{activationLink}'>{activationLink}</a>";

                            servidor.Host = ConfigurationManager.AppSettings["SMTP_URL"];
                            servidor.Port = int.Parse(ConfigurationManager.AppSettings["SMTP_PORT"]);

                            string utilizador = ConfigurationManager.AppSettings["SMTPMailUser"];
                            string pw = ConfigurationManager.AppSettings["SMTP_PASSWORD"];

                            servidor.Credentials = new NetworkCredential(utilizador, pw);
                            servidor.EnableSsl = true;

                            servidor.Send(email1);
                        }
                        catch (Exception ex)
                        {
                            lbl_mensagem2.Text = ex.Message;
                            return; // Retorna se ocorrer um erro no envio de e-mail para evitar a execução adicional do código
                        }
                        lbl_mensagem2.Text = "Registo efetuado e email enviado para ativação da conta!";
                    }
                    else
                        lbl_mensagem2.Text = "Utilizador já existe";
                }
            }
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