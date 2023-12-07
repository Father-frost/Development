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
    public partial class fAddWorker : Form
    {
        private SQLiteConnection dblite;
        private SQLiteDataReader sqlReader;
        SQLiteCommand m_sqlCmd = null;
        

        public fAddWorker()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            if (id_rec == "")  //Если  id записи не передан (новая запись) 
            {
                string querySQLite = @"INSERT INTO DirWorkers (Tab_nom, FIO, rank, kprof, KO, brig_id) VALUES (@Tab_nom,@FIO,@rank,@kprof,@KO,@brig_id)";
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@tab_nom", tbTabnom.Text);
                m_sqlCmd.Parameters.AddWithValue("@FIO", tbFIO.Text);
                m_sqlCmd.Parameters.AddWithValue("@rank", tbRank.Text);
                m_sqlCmd.Parameters.AddWithValue("@kprof", cbProf.SelectedValue);
                m_sqlCmd.Parameters.AddWithValue("@KO", tbKO.Text.Replace(",", "."));
                m_sqlCmd.Parameters.AddWithValue("@brig_id", cbBrig.SelectedValue);
            }
            else
            {
                string querySQLite = @"UPDATE DirWorkers SET Tab_nom=@Tab_nom, FIO=@FIO, rank=@rank, kprof=@kprof, KO=@KO, brig_id=@brig_id WHERE id="+id_rec;
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@tab_nom", tbTabnom.Text);
                m_sqlCmd.Parameters.AddWithValue("@FIO", tbFIO.Text);
                m_sqlCmd.Parameters.AddWithValue("@rank", tbRank.Text);
                m_sqlCmd.Parameters.AddWithValue("@kprof", cbProf.SelectedValue);
                m_sqlCmd.Parameters.AddWithValue("@KO", tbKO.Text.Replace(",", "."));
                m_sqlCmd.Parameters.AddWithValue("@brig_id", cbBrig.SelectedValue);
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

        private void fAddWorker_Load(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            DataTable dt = new DataTable();
            DataTable dtp = new DataTable();
            string query = @"SELECT id,(KODBR ||' '|| Name) as lName FROM DirBrigs";
            string query1 = @"SELECT id,Name as pName FROM DirProfs";

            try
            {
                SQLiteCommand m_sqlCmd = new SQLiteCommand(query, dblite);
                SQLiteDataAdapter da = new SQLiteDataAdapter(m_sqlCmd);
                DataSet ds = new DataSet();

                da.Fill(ds);
                dt = ds.Tables[0];

                m_sqlCmd = new SQLiteCommand(query1, dblite);
                da = new SQLiteDataAdapter(m_sqlCmd);

                DataSet ds1 = new DataSet();
                da.Fill(ds1);
                dtp = ds1.Tables[0];

                cbBrig.DataSource = dt.AsDataView();
                cbBrig.DisplayMember = "lName";
                cbBrig.ValueMember = "id";
                
                cbProf.DataSource = dtp.AsDataView();
                cbProf.DisplayMember = "pName";
                cbProf.ValueMember = "id";

                //Если выбран существующий интервал, загружаем параметры
                if (id_rec != "")
                {
                    //MessageBox.Show(id_rec.ToString());
                    GetWorker();
                }
                else
                {
                    tbTabnom.Text = "";
                    tbFIO.Text = "";
                    tbRank.Text = "";
                    tbKO.Text = "";
                }



            }
            catch (SQLiteException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }


        }

        public async void GetWorker()
        {
            try
            {
                dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
                dblite.Open();
                string query = @"SELECT dw.*,dbr.id,dbr.KODBR,dbr.Name,pr.Name as pName 
                            FROM DirWorkers as dw
                            LEFT JOIN DirProfs as pr on pr.id = dw.kprof
                            LEFT JOIN DirBrigs as dbr on dw.brig_id = dbr.id WHERE dw.id =" + id_rec;

                m_sqlCmd = new SQLiteCommand(query, dblite);
                //m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {

                    tbTabnom.Text = Convert.ToString(sqlReader["Tab_nom"]);
                    tbFIO.Text = Convert.ToString(sqlReader["FIO"]);
                    tbRank.Text = Convert.ToString(sqlReader["rank"]);
                    cbProf.Text =  Convert.ToString(sqlReader["pName"]);
                    tbKO.Text =  Convert.ToString(sqlReader["KO"]);
                    cbBrig.Text = Convert.ToString(sqlReader["KODBR"])+" "+Convert.ToString(sqlReader["Name"]);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.00.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
        }

    }
}
