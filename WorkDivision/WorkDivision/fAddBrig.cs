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
    public partial class fAddBrig : Form
    {
        private SQLiteConnection dblite;
        private SQLiteDataReader sqlReader;
        SQLiteCommand m_sqlCmd = null;
        

        public fAddBrig()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            if (id_rec == "")  //Если  id записи не передан (новая запись) 
            {
                string querySQLite = @"INSERT INTO DirBrigs (KODBR, Name, Numk) VALUES (@KODBR, @Name, @Numk)";
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@KODBR", tbKODBR.Text);
                m_sqlCmd.Parameters.AddWithValue("@Name", tbName.Text);
                m_sqlCmd.Parameters.AddWithValue("@Numk", tbNumk.Text);
            }
            else
            {
                string querySQLite = @"UPDATE DirBrigs SET KODBR=@KODBR, Name=@Name, Numk=@Numk WHERE id=" + id_rec;
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@KODBR", tbKODBR.Text);
                m_sqlCmd.Parameters.AddWithValue("@Name", tbName.Text);
                m_sqlCmd.Parameters.AddWithValue("@Numk", tbNumk.Text);
            }
            try
            {
                m_sqlCmd.Prepare();
                m_sqlCmd.ExecuteNonQuery();
                this.Close();
            }
            catch (SQLiteException ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.21.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public string id_rec { get; set; }

        private void fAddBrig_Load(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            //Если выбран существующий интервал, загружаем параметры
            if (id_rec != "")
                {
                    //MessageBox.Show(id_rec.ToString());
                    GetBrig();
                }
                else
                {
                    tbKODBR.Text = "";
                    tbName.Text = "";
                    tbNumk.Text = "";
                }
        }

        public async void GetBrig()
        {
            try
            {
                //dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
                //dblite.Open();
                string query = @"SELECT * FROM DirBrigs WHERE id =" + id_rec;

                m_sqlCmd = new SQLiteCommand(query, dblite);
                //m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {

                    tbKODBR.Text = Convert.ToString(sqlReader["KODBR"]);
                    tbName.Text = Convert.ToString(sqlReader["Name"]);
                    tbNumk.Text = Convert.ToString(sqlReader["Numk"]);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.01.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
        }

    }
}
