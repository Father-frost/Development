using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SQLite;

namespace WorkDivision
{
    public partial class fCodesList : Form
    {
        private String dbFileName;
        private SQLiteConnection m_dbConn;
        private SQLiteCommand m_sqlCmd;
        private SQLiteDataReader sqlReader;

        public fCodesList()
        {
            InitializeComponent();
        }

        private async void fCodesList_Load(object sender, EventArgs e)
        {
            await GetCodeList();
            autoResizeColumns(listView1);
        }

        // асинхронный вывод списка кодов
        public async Task GetCodeList()
        {
            dbFileName = "marking.db";
            string query = @"SELECT Code FROM MarkingTasks WHERE dtOutput=" + Globals.datearr + @" AND KPR =" + Globals.kprarr + @" AND batch='" + Globals.batcharr + "'";

            listView1.Items.Clear();  //Чистим listview1
            listView1.Columns.Clear();
            // отрисовка заголовков ListView
            listView1.GridLines = true;
            listView1.FullRowSelect = true;
            listView1.View = View.Details;
            listView1.Columns.Add("Code");

            try
            {
                m_dbConn = new SQLiteConnection("Data Source=" + dbFileName + ";Version=3;");
                m_dbConn.Open();
                m_sqlCmd = new SQLiteCommand(query, m_dbConn);
                m_sqlCmd.Connection = m_dbConn;
                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["Code"]),
                    });
                    listView1.Items.Add(item);
                    if (!item.SubItems[0].Text.Contains(Globals.gtinarr))  // Если есть плохие коды
                    {
                        item.BackColor = Color.PaleVioletRed;
                    }
                }

            }
            catch (SQLiteException ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
        }

        // авторасширение колонок listView по размеру содержимого
        public static void autoResizeColumns(ListView lv)
        {
            lv.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);
            ListView.ColumnHeaderCollection cc = lv.Columns;
            for (int i = 0; i < cc.Count; i++)
            {
                int colWidth = TextRenderer.MeasureText(cc[i].Text, lv.Font).Width + 10;
                if (colWidth > cc[i].Width)
                {
                    cc[i].Width = colWidth;
                }
            }
        }
    }
}
