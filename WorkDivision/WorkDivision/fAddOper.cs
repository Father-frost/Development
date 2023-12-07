﻿using System;
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
using System.Globalization;

namespace WorkDivision
{
    public partial class fAddOper : Form
    {
        private SQLiteConnection dblite;
        private SQLiteDataReader sqlReader;
        SQLiteCommand m_sqlCmd = null;
        

        public fAddOper()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            if (id_rec == "")  //Если  id записи не передан (новая запись) 
            {
                
                string querySQLite = @"INSERT INTO DirOpers (Name,UCH,PER,NST,KOEF,NVR) VALUES (@Name,@UCH,@PER,@NST,@KOEF,'@NVR')";
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@Name", tbName.Text);
                m_sqlCmd.Parameters.AddWithValue("@UCH", tbUCH.Text);
                m_sqlCmd.Parameters.AddWithValue("@PER", tbPER.Text);
                m_sqlCmd.Parameters.AddWithValue("@NST", tbNST.Text);
                m_sqlCmd.Parameters.AddWithValue("@KOEF", tbKOEF.Text.Replace(",", "."));
                m_sqlCmd.Parameters.AddWithValue("@NVR", tbNVR.Text.Replace(",", "."));
            }
            else
            {
                string querySQLite = @"UPDATE DirOpers SET Name=@Name, UCH=@UCH, PER=@PER, NST=@NST, KOEF=@KOEF, NVR=@NVR WHERE id=" + id_rec;
                m_sqlCmd = new SQLiteCommand(querySQLite, dblite);
                m_sqlCmd.Parameters.AddWithValue("@Name", tbName.Text);
                m_sqlCmd.Parameters.AddWithValue("@UCH", tbUCH.Text);
                m_sqlCmd.Parameters.AddWithValue("@PER", tbPER.Text);
                m_sqlCmd.Parameters.AddWithValue("@NST", tbNST.Text);
                m_sqlCmd.Parameters.AddWithValue("@KOEF", tbKOEF.Text.Replace(",", "."));
                m_sqlCmd.Parameters.AddWithValue("@NVR", tbNVR.Text.Replace(",","."));
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

        private void fAddOper_Load(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();
            //Если выбран существующий интервал, загружаем параметры
            if (id_rec != "")
            {
                    //MessageBox.Show(id_rec.ToString());
                GetOper();
            }
            else
            {
                tbName.Text = "";
                tbUCH.Text = "";
                tbPER.Text = "";
                tbNST.Text = "";
                tbKOEF.Text = "";
                tbNVR.Text = "";
            }
        }

        public async void GetOper()
        {
            try
            {
                //dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
                //dblite.Open();
                string query = @"SELECT * FROM DirOpers WHERE id =" + id_rec;

                m_sqlCmd = new SQLiteCommand(query, dblite);
                //m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    tbName.Text = Convert.ToString(sqlReader["Name"]);
                    tbUCH.Text = Convert.ToString(sqlReader["UCH"]);
                    tbPER.Text = Convert.ToString(sqlReader["PER"]);
                    tbNST.Text = Convert.ToString(sqlReader["NST"]);
                    tbKOEF.Text = Convert.ToString(sqlReader["KOEF"]);
                    tbNVR.Text = Convert.ToString(sqlReader["NVR"]);

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
