using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projetoteste
{
    public partial class disponibilidade : System.Web.UI.Page
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
        public static List<CalendarEvents> GetCalendarData()
        {
            //-- this is the webmethod that you will require to create to fetch data from database
            return GetCalendarDataFromDatabase();
        }
        [WebMethod]
        public static string SaveEvent(CalendarEvents newEvent)
        {
            try
            {
                // Validate and save the event in the database
                // Example: DbContext.Events.Add(newEvent); DbContext.SaveChanges();

                string constring = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
                using (SqlConnection myConn = new SqlConnection(constring))               
                {
                    using (SqlCommand myCommand = new SqlCommand("Insert into SlotMaster(SlotStatus,SlotStartTime,SlotEndTime,SlotDate)VALUES(@SlotStatus,@SlotStartTime,@SlotEndTime,@SlotDate)", myConn))
                    {
                        myCommand.CommandType = CommandType.Text;
                        myConn.Open();
                        myCommand.Parameters.AddWithValue("@SlotStatus", "Active");
                        myCommand.Parameters.AddWithValue("@SlotStartTime", newEvent.slotStartTime);
                        myCommand.Parameters.AddWithValue("@SlotEndTime", newEvent.slotEndTime);
                        myCommand.Parameters.AddWithValue("@SlotDate", newEvent.slotDate);
                        myCommand.ExecuteNonQuery();
                        myConn.Close();
                    }
                }
                return "success";
            }
            catch (Exception ex)
            {
                return "failure";
            }
        }
        private static List<CalendarEvents> GetCalendarDataFromDatabase()
        {
            List<CalendarEvents> CalendarList = new List<CalendarEvents>();
            string constring = ConfigurationManager.ConnectionStrings["ProjetoFinal1ConnectionString"].ConnectionString;
            using (SqlConnection myConn = new SqlConnection(constring))
            {
                string query = "Select * FROM SlotMaster where slotStatus='ACTIVE' ";

                using (SqlCommand myCommand = new SqlCommand(query, myConn))
                {
                    myCommand.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(myCommand))
                    {

                        DataSet ds = new DataSet();
                        // ds = ClsDAL.QueryEngine(strQuery, "SlotMaster");
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        //dt = ds.Tables[0];
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            CalendarEvents Calendar = new CalendarEvents();
                            Calendar.slotID = Convert.ToInt32(dt.Rows[i]["slotID"]);
                            Calendar.slotDate = Convert.ToDateTime(dt.Rows[i]["slotDate"]);
                            Calendar.slotStatus = dt.Rows[i]["slotStatus"].ToString();
                            Calendar.slotStartTime = Convert.ToDateTime(dt.Rows[i]["slotStartTime"]);
                            Calendar.slotEndTime = Convert.ToDateTime(dt.Rows[i]["slotEndTime"]);

                            if (Calendar.slotStatus == "ACTIVE")
                            {
                                Calendar.color = "green";
                            }
                            else
                            {
                                // Calendar.color = "white";
                            }

                            CalendarList.Add(Calendar);
                        }
                    }
                }
            }
            return CalendarList;
        }

        public class CalendarEvents
        {
            public int slotID { get; set; }

            public DateTime slotStartTime { get; set; }

            public DateTime slotEndTime { get; set; }
            public DateTime slotDate { get; set; }
            public string EventDescription { get; set; }

            public string Title { get; set; }
            public string slotStatus { get; set; }

            public int bookingID { get; set; }
            public bool AllDayEvent { get; set; }
            public string color { get; set; }
        }

    }
}