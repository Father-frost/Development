using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SQLite;
using System.Xml;

namespace WorkDivision
{
    public partial class fAddTarif : Form
    {
        private SQLiteConnection dblite;
        private SQLiteDataReader sqlReader;
        SQLiteCommand m_sqlCmd = null;
        

        public fAddTarif()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            if (id_rec == "")  //Если  id записи не передан (новая запись) 
            {
                string querySQLite = @"INSERT INTO DirTarif (rank,TAR_VR,K_SD) VALUES (@rank,@TAR_VR,@K_SD)";
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@rank", tbRank.Text);
                m_sqlCmd.Parameters.AddWithValue("@TAR_VR", tbTAR_VR.Text.Replace(",", "."));
                m_sqlCmd.Parameters.AddWithValue("@K_SD", tbK_SD.Text.Replace(",", "."));
            }
            else
            {
                string querySQLite = @"UPDATE DirTarif SET Name=@Name WHERE id=" + id_rec;
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@rank", tbRank.Text);
                m_sqlCmd.Parameters.AddWithValue("@TAR_VR", tbTAR_VR.Text.Replace(",", "."));
                m_sqlCmd.Parameters.AddWithValue("@K_SD", tbK_SD.Text.Replace(",", "."));
            }
            try
            {
                m_sqlCmd.Prepare();
                m_sqlCmd.ExecuteNonQuery();
                this.Close();
            }
            catch (SQLiteException ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.22.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public string id_rec { get; set; }

        private void fAddTarif_Load(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            //Если выбран существующий интервал, загружаем параметры
            if (id_rec != "")
                {
                    //MessageBox.Show(id_rec.ToString());
                    GetTarif();
                }
                else
                {
                    tbRank.Text = "";
                    tbTAR_VR.Text = "";
                    tbK_SD.Text = "";
                }
        }

        public async void GetTarif()
        {
            try
            {
                //dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
                //dblite.Open();
                string query = @"SELECT * FROM DirTarif WHERE id =" + id_rec;

                m_sqlCmd = new SQLiteCommand(query, dblite);
                //m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    tbRank.Text = Convert.ToString(sqlReader["rank"]);
                    tbTAR_VR.Text = Convert.ToString(sqlReader["TAR_VR"]);
                    tbK_SD.Text = Convert.ToString(sqlReader["K_SD"]);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.03.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
        }

    }
}
