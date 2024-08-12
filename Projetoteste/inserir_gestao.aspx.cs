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
    public partial class inserir_gestao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica se o usuário está autenticado
            if (Session["nome"] != null && !string.IsNullOrEmpty(Session["nome"].ToString()))
            {
                // Obtém o nome do usuário da sessão
                string nome = Session["nome"].ToString();

            }
            else
            {
                // Se não estiver autenticado, redireciona para a página de login
                Response.Redirect("index.aspx");
            }
        }
       
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string password = tb_password.Text;
            //tamanho mínimo e máximo da senha
            Regex regexSenha = new Regex(@"^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[^\da-zA-Z]).{8,20}$");
            bool senhaValida = regexSenha.IsMatch(tb_password.Text);

            //if (!senhaValida)
            //{
                //lbl_mensagem.Text = "A senha não atende aos critérios de complexidade.";
                //return; // Retorna para evitar continuar o processamento do registro
            //}

            //para apanhar o contenttype
            Stream imgStream1 = FileUpload_foto.PostedFile.InputStream;
            Stream imgStream2 = FileUpload_documento.PostedFile.InputStream;

            //para criar o array na dimensão do ficheiro que está sendo criado
            int tamanhoFicheiro1 = FileUpload_foto.PostedFile.ContentLength;
            int tamanhoFicheiro2 = FileUpload_documento.PostedFile.ContentLength;

            //para apanhar os dados binários necessita de array de byte
            byte[] imgBinaryData1 = new byte[tamanhoFicheiro1]; //temos que já definir a dimensão do ficheiro
            byte[] imgBinaryData2 = new byte[tamanhoFicheiro2]; //temos que já definir a dimensão do ficheiro

            imgStream1.Read(imgBinaryData1, 0, tamanhoFicheiro1);
            imgStream2.Read(imgBinaryData2, 0, tamanhoFicheiro2);

            // Capturando as seleções das checkboxes
            bool isCandidato = cbox_candidato.Checked;
            bool isFormando = cbox_formando.Checked;
            bool isFormador = cbox_formador.Checked;
            bool isSecretaria = cbox_secretaria.Checked;

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand();

            myCommand.Parameters.AddWithValue("@nome", tb_nome.Text);
            myCommand.Parameters.AddWithValue("@email", tb_email.Text);
            // Encripta a senha antes de passar para o banco de dados
            myCommand.Parameters.AddWithValue("@pw", EncryptString(tb_password.Text));
            myCommand.Parameters.AddWithValue("@nif", tb_nif.Text);
            myCommand.Parameters.AddWithValue("@telefone", tb_telefone.Text);
            myCommand.Parameters.AddWithValue("@morada", tb_morada.Text);
            myCommand.Parameters.AddWithValue("@foto", imgBinaryData1);
            myCommand.Parameters.AddWithValue("@documento", imgBinaryData2);
            // Define as colunas de perfil baseadas nas seleções das checkboxes
            myCommand.Parameters.AddWithValue("@secretaria", isSecretaria);
            myCommand.Parameters.AddWithValue("@formador", isFormador);
            myCommand.Parameters.AddWithValue("@formando", isFormando);
            myCommand.Parameters.AddWithValue("@candidato", isCandidato);
            myCommand.Parameters.AddWithValue("@ativo", 1); //assumindo que 1 indica "ativo"

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "registo_gestao";

            myCommand.Connection = myConn;
            myConn.Open();
            SqlDataReader dr = myCommand.ExecuteReader();

            //se tiver dados, manda para o ecrã os dados binários
            if (dr.Read())
            {
                Response.BinaryWrite((byte[])dr["foto"]);
                Response.BinaryWrite((byte[])dr["documento"]);
            }
            myConn.Close();

            if (true)
            {
                try
                {
                    // Obtém a senha criptografada
                    string encryptedPassword = EncryptString(tb_password.Text);
                    // Obtém a senha descriptografada
                    //string decryptedPassword = DecryptString(tb_password.Text);

                    // Gere o link de ativação e encripta o nome do user
                    string activationLink = $"https://localhost:44385/ativacao.aspx?user={EncryptString(tb_nome.Text)}";

                    // Código para enviar o e-mail
                    SmtpClient servidor = new SmtpClient();
                    MailMessage email1 = new MailMessage();

                    email1.From = new MailAddress(ConfigurationManager.AppSettings["SMTPMailUser"], "Escola Cinel");
                    email1.To.Add(new MailAddress(tb_email.Text));
                    email1.Subject = "Confirmação de Registo Colaborador Cinel";
                    email1.IsBodyHtml = true;
                    email1.Body = $" Caro(a) colaborador(a), aqui está a palavra-passe padrão: {tb_password.Text}, que poderá alterar após efetuar o primeiro login.";

                    servidor.Host = ConfigurationManager.AppSettings["SMTP_URL"];
                    servidor.Port = int.Parse(ConfigurationManager.AppSettings["SMTP_PORT"]);

                    string utilizador = ConfigurationManager.AppSettings["SMTPMailUser"];
                    string pw = ConfigurationManager.AppSettings["SMTP_PASSWORD"];

                    servidor.Credentials = new NetworkCredential(utilizador, pw);
                    servidor.EnableSsl = true;

                    servidor.Send(email1);

                    lbl_mensagem.Text = "Registo efetuado!";
                }
                catch (Exception ex)
                {
                    lbl_mensagem.Text = ex.Message;
                    return; // Retorna se ocorrer um erro no envio de e-mail para evitar a execução adicional do código
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
        public static string DecryptString(string Message)
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

            // Step 3. Setup the decoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]

            Message = Message.Replace("KKK", "+");
            Message = Message.Replace("JJJ", "/");
            Message = Message.Replace("III", "\\");

            byte[] DataToDecrypt = Convert.FromBase64String(Message);

            // Step 5. Attempt to decrypt the string
            if (DataToDecrypt.Length % 8 != 0)//aqui tamanho de 8 igual o tamanho da linha 27
            {
                return "Erro: Tamanho dos dados invÃ¡lido";
            }
            try
            {
                ICryptoTransform Decryptor = TDESAlgorithm.CreateDecryptor();
                Results = Decryptor.TransformFinalBlock(DataToDecrypt, 0, DataToDecrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }
            // Step 6. Return the decrypted string in UTF8 format
            return UTF8.GetString(Results);
        }        
    }
}