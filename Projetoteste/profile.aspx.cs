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
using iTextSharp.text.pdf;

namespace Projetoteste
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["nome"] != null)
            {
                // Obter o nome do usuário da sessão
                string nomeUser = Session["nome"].ToString();

                // Obter o ID do usuário baseado no nome de usuário
                int codUser = ObterCodUserPeloNome(nomeUser);

                if (codUser != 0) // Verificar se o código do usuário foi obtido com sucesso
                {
                    string query = "SELECT nome, email, nif, telefone, morada, foto FROM users WHERE cod_user = @cod_user";

                    using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString))
                    {
                        SqlCommand myCommand = new SqlCommand(query, myConn);
                        myCommand.Parameters.AddWithValue("@cod_user", codUser);

                        myConn.Open();

                        SqlDataReader reader = myCommand.ExecuteReader();

                        if (reader.Read())
                        {
                            // Preencher as labels com os valores dos campos do banco de dados
                            lbl_nome.Text = reader["nome"].ToString();
                            lbl_email.Text = reader["email"].ToString();
                            lbl_nif.Text = reader["nif"].ToString();
                            lbl_telefone.Text = reader["telefone"].ToString();
                            lbl_morada.Text = reader["morada"].ToString();

                            // Define a largura e a altura desejadas para a imagem
                            int larguraDesejada = 120;
                            int alturaDesejada = 150;

                            // Verifica se o campo 'foto' não é nulo no banco de dados
                            if (!reader.IsDBNull(reader.GetOrdinal("foto")))
                            {
                                // Obtém os dados da imagem do banco de dados
                                byte[] imgData = (byte[])reader["foto"];

                                // Converte os dados da imagem para uma string base64
                                string base64String = Convert.ToBase64String(imgData);

                                // Define a URL da imagem como uma string base64
                                img_foto.ImageUrl = "data:image/jpeg;base64," + base64String;

                                // Define a largura e a altura da imagem usando os atributos HTML
                                img_foto.Width = larguraDesejada;
                                img_foto.Height = alturaDesejada;
                            }
                        }
                        else
                        {
                            // Se não houver dados encontrados para o cod_user, você pode exibir uma mensagem ou fazer o que for apropriado para sua aplicação
                        }
                        reader.Close();
                    }
                }
                else
                {
                    // Se o cod_user não estiver na sessão, redirecione para a página de login
                    Response.Redirect("index.aspx");
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
                        /* lbl_mensagem.Text = "Falha ao obter o código do usuário."*/
                        ;
                    }
                }
                catch (Exception ex)
                {
                    // Tratar a exceção
                    Console.WriteLine("Ocorreu um erro ao obter o código do usuário: " + ex.Message);
                }
            }
            return codUser;
        }

        protected void btn_changePassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("alterarsenha.aspx");
        }

        protected void btn_retornar_Click(object sender, EventArgs e)
        {
            Response.Redirect("transition.aspx");
        }
              //*****************
        protected void btn_salvar_Click(object sender, EventArgs e)
        {
            if (Session["nome"] != null)
            {
                // Obter o nome do usuário da sessão
                string nomeUser = Session["nome"].ToString();

                // Obter o ID do usuário baseado no nome de usuário
                int codUser = ObterCodUserPeloNome(nomeUser);

                // Verificar se o código do usuário foi obtido com sucesso
                if (codUser != 0)
                {
                    if (flUp_doc.HasFiles)
                    {
                        foreach (HttpPostedFile postedFile in flUp_doc.PostedFiles)
                        {
                            Stream imgStream = postedFile.InputStream;

                            // tb_titulo

                            // ct = contentType (string usada para passar dado para o SQL)
                            string ct = flUp_doc.PostedFile.ContentType;

                            //para criar o array na dimensão do ficheiro que está sendo criado                
                            int tamanhoFicheiro = postedFile.ContentLength;

                            //para apanhar os dados binários necessita de array de byte                
                            byte[] imgBinaryData = new byte[tamanhoFicheiro]; //temos que já definir a dimensão do ficheiro

                            //leitura do tamanho do array
                            imgStream.Read(imgBinaryData, 0, tamanhoFicheiro);

                            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString);
                            SqlCommand myCommand = new SqlCommand();

                            myCommand.Parameters.AddWithValue("@cod_user", codUser); // Passar o cod_user obtido para a stored procedure
                            myCommand.Parameters.AddWithValue("@titulo", tb_titulo.Text);
                            myCommand.Parameters.AddWithValue("@tipo_documento", ct);
                            myCommand.Parameters.AddWithValue("@documento", imgBinaryData);

                            myCommand.CommandType = CommandType.StoredProcedure;
                            myCommand.CommandText = "documento_perfil";

                            myCommand.Connection = myConn;
                            myConn.Open();

                            myCommand.ExecuteNonQuery();
                            myConn.Close();
                        }

                        lbl_mensagem.Text = "Documento(s) salvo(s).";
                    }
                    else
                    {
                        lbl_mensagem.Text = "Nenhum arquivo selecionado.";
                    }
                }
                else
                {
                    Response.Redirect("~/index.aspx");
                }
            }
            else
            {
                Response.Redirect("~/index.aspx");
            }
        }

        //protected void lbtn_fichaPDF_Click(object sender, EventArgs e)
        //{

        //}

        protected void lbtn_fichaPDF_Click1(object sender, EventArgs e)
        {
            string caminhoPDFs = ConfigurationManager.AppSettings["PathPDFs"]; // caminho está no webconfig

            string siteURL = ConfigurationManager.AppSettings["SiteURL"]; // url para abrir o PDF gerado

            //nome do arquivo (data) e (data + nome) PDF
            //string nomePDF = EncryptString(DateTime.Now.ToString().Replace("/", "").Replace(" ", "").Replace(":", "")) + ".pdf";
            string nomePDF = $"{EncryptString(DateTime.Now.ToString().Replace("/", "").Replace(" ", "").Replace(":", ""))}" + $"{EncryptString(Session["nome"].ToString())}" + ".pdf";
            //Response.Write(nomePDF);
            //Response.End();

            string pdfTemplate = caminhoPDFs + "template\\Ficha.pdf"; //lembrar de colocar duas barras invertidas para o caminho ser reconhecido

            string novoficheiro = caminhoPDFs + "gerados\\" + nomePDF;

            // Abrir o PDF template e o PDF final
            PdfReader preader = new PdfReader(pdfTemplate);
            PdfStamper pdfStamper = new PdfStamper(preader, new FileStream(novoficheiro, FileMode.Create));

            // Preencher os campos do PDF
            AcroFields pdfFields = pdfStamper.AcroFields;

            //pdfFields.SetField("image_foto", img);
            pdfFields.SetField("nome", lbl_nome.Text); // nome do campo no PDF | lbl ou textbox
            pdfFields.SetField("email", lbl_email.Text);
            pdfFields.SetField("nif", lbl_nif.Text);
            pdfFields.SetField("telefone", lbl_telefone.Text);
            pdfFields.SetField("morada", lbl_morada.Text);

            //byte[] imageData = Convert.FromBase64String();

            //iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(imageData);

            //// Scale the image if necessary
            //image.ScaleToFit(100f, 100f); // Adjust width and height as needed

            //image.SetAbsolutePosition(100, 250);
            //// Add the image to the document
            //PdfContentByte pdfContentByte = pdfStamper.GetOverContent(1); // Page number to add the image to
            //pdfContentByte.AddImage(image);

            // Fechar o PDF
            pdfStamper.Close();

            Response.Redirect(siteURL + "PDFs/Gerados/" + nomePDF);

            //// Converter a imagem em um array de bytes
            //byte[] imagemBytes;
            //using (MemoryStream ms = new MemoryStream())
            //{
            //    // Salvar a imagem do controle img_foto na MemoryStream
            //    img_foto.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            //    imagemBytes = ms.ToArray();
            //}

            //// Converter o array de bytes em um objeto Image do iTextSharp
            //iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(imagemBytes);

            //// Definir a posição e o tamanho da imagem no PDF (ajuste conforme necessário)
            //img.SetAbsolutePosition(x, y); // Defina as coordenadas x e y
            //img.ScaleToFit(width, height); // Defina a largura e a altura

            //Response.Write(novoficheiro); // teste do caminho

            //PdfContentByte pdfContentByte = pstamper.GetOverContent(1); // 1 é a página onde você deseja adicionar a imagem
            //pdfContentByte.AddImage(img);      

            //itextsharp.text.Image coinImage = itextsharp.text.Image.GetInstance(photo);
            //coinImage.ScaleAbsolute(50, 50);      
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