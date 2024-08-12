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

namespace Projetoteste
{
    public partial class recuperar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_recuperar_Click(object sender, EventArgs e)
        {
            //para passar para a base de dados encriptado
            //string novaPasse = GenerateToken(6); 1º opção

            String novaPasse = ""; //2ª opção
            //String possíveisCaracteres = "12345678"; //para ficar mais fácil a senha ao testar            
            String possíveisCaracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()"; // caracteres possíveis para uma senha mais forte | teste

            Random aleatorio = new Random();            

            int tamanhoMaximoSenha = 8; // ou o tamanho máximo permitido na coluna pw

            for (int i = 0; i < tamanhoMaximoSenha; i++)
            {
                int num_gerado = aleatorio.Next(possíveisCaracteres.Length); // Gera um número aleatório correspondente a um índice na string possíveisCaracteres
                novaPasse += possíveisCaracteres[num_gerado]; // Adiciona o caractere correspondente ao número gerado à senha
            }

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            //parameters de inputs, ou seja, de passagem de conteúdo da página para o SQL
            myCommand.Parameters.AddWithValue("@email", tb_email.Text);
            myCommand.Parameters.AddWithValue("@novaPasse", EncryptString(novaPasse));

            //parameters de outpts, ou seja, que devolva coisas do SQL para o C# (página)
            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "recuperar"; //nome da stored procedure

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery();//expulsão para a base de dados que não retorna dados, insert

            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

            myConn.Close();//sempre fechar a conexão

            if (respostaSP == 1)
            {
                try
                {
                    SmtpClient servidor = new SmtpClient();// que trata do servidor//envelope-pacote do email
                    MailMessage email = new MailMessage();//envelope-pacote do email

                    email.From = new MailAddress(ConfigurationManager.AppSettings["SMTPMailUser"], "Escola XPTO"); //devemos criar uma key no webconfig para o email ser chamado aqui
                    email.To.Add(new MailAddress(tb_email.Text));//add porque podemos ter vários destinatários-- o Add é um método do email//da mesma maneira que colocamos o TO podemos colocar o BCC ou o CC
                    email.Subject = "Nova Palavra Passe";

                    email.IsBodyHtml = true;// significa que posso escrever código HTML, se escrever falso vai escrever como um bloco de notas onde não tem fonte, nem tamanho etc.
                    email.Body = $"Aqui está a nova Palavra-Passe:{novaPasse}";
                    //o httpss está a ser passado por url

                    //para tratar do servidor, devemos passar os campos para o WebConfig criando as keys que são: SMTP_URL, SMTP_PORT e SMTP_PASSWORD
                    servidor.Host = ConfigurationManager.AppSettings["SMTP_URL"];
                    servidor.Port = int.Parse(ConfigurationManager.AppSettings["SMTP_PORT"]);

                    string utilizador = ConfigurationManager.AppSettings["SMTPMailUser"];
                    string pw = ConfigurationManager.AppSettings["SMTP_PASSWORD"];

                    //para dizer que vou me autenticar com o utilizador e palavra passe
                    servidor.Credentials = new NetworkCredential(utilizador, pw);

                    //para dizer que usa protocolo SSL (segurança)
                    servidor.EnableSsl = true;

                    //o obejto servidor vai enviar o email
                    servidor.Send(email);

                    lbl_mensagem.Text = "Nova palavra-passe enviado para o e-mail!";


                }
                //se ocorrer o erro tratar do erro e mostra a mensagem
                catch (Exception ex)
                {
                    lbl_mensagem.Text = ex.Message;
                }
            }
            else if (respostaSP == 0)
            {
                lbl_mensagem.Text = "Conta inativa, deverá primeiro ativar a conta em seu e-mail!";
            }
            else
            {
                lbl_mensagem.Text = "O e-mail não está associado a qualquer conta!";
            }
        }

        //continuação da 1ª opção de gerar nova palavra passe que está na linha 27 
        //public string GenerateToken(int length)
        //{
        //    using (RNGCryptoServiceProvider cryptRNG = new RNGCryptoServiceProvider())
        //    {
        //        byte[] tokenBuffer = new byte[length];
        //        cryptRNG.GetBytes(tokenBuffer);
        //        return Convert.ToBase64String(tokenBuffer);


        //    }
        //}

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

