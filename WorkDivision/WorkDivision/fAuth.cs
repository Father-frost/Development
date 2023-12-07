using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WorkDivision
{
    public partial class fAuth : Form
    {
        public Form1 f1;
        private String dbFileName;
        private SQLiteConnection dblite;
        private SQLiteCommand m_sqlCmd;
        private SQLiteDataReader sqlReader;
        public fAuth()
        {
            InitializeComponent();
            f1 = new Form1();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Authentication();
        }

        private void fAuth_Load(object sender, EventArgs e)
        {

            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();

            textBox1.Focus();

            // загрузка списка Пользователей в список comboBox1
            SQLiteCommand getfio = new SQLiteCommand("SELECT * FROM Users ORDER by IdGroup", dblite);

            sqlReader = null;

            try
            {

                sqlReader = getfio.ExecuteReader();

                while (sqlReader.Read())
                {
                    comboBox1.Items.Add(sqlReader["Client"]);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 1.01", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }

            // загрузка последнего входящего пользователя
            //SqlCommand LoadInput;
            //SqlCommand LoadClient;
            //LoadInput = new SqlCommand("SELECT LastInput FROM Auth WHERE LastInput = 1", connUacc);
            //LoadClient = new SqlCommand("SELECT Client FROM Auth WHERE LastInput = 1", connUacc);

            comboBox1.Text = Convert.ToString(comboBox1.Items[0]);
            /*
            // получение ФИО пользователя
            int LastPerson = Convert.ToInt32(LoadInput.ExecuteScalar());
            if (LastPerson == 1)
            {
                comboBox1.Text = Convert.ToString(LoadClient.ExecuteScalar());
            }
            else
            {
                comboBox1.Text = Convert.ToString(comboBox1.Items[0]);
            }     
            */
        }

        public void Authentication()
        {
            SQLiteCommand getfio;

            sqlReader = null;

            getfio = new SQLiteCommand("SELECT * FROM Users", dblite);

            // узнать количество записей
            //SqlCommand getcount;
            //getcount = new SqlCommand("SELECT COUNT(*) FROM Auth", connUacc);
            //iCount = Convert.ToInt32(getcount.ExecuteScalar());

            // очищение параметра временного хранения
            // статуса последнего пользователя LastInput
            //SqlCommand UPnullInput;
            //UPnullInput = new SqlCommand("UPDATE Auth SET LastInput = 0", connUacc);
            //UPnullInput.ExecuteScalar();

            // добавление параметра временного хранения
            // статуса последнего пользователя LastInput
            //SqlCommand UPOut;
            //UPOut = new SqlCommand("UPDATE Auth SET LastInput = 1  WHERE Client ='" + comboBox1.Text + "'", connUacc);

            if (comboBox1.Text != "")
            {
                if (textBox1.Text != "")
                {
                    try
                    {
                        sqlReader = getfio.ExecuteReader();

                        while (sqlReader.Read())
                        {
                            string cl1 = Convert.ToString(sqlReader["Client"]);

                            string rs1 = Convert.ToString(sqlReader["Pass"]);

                            if (Convert.ToString(sqlReader["Client"]) == Convert.ToString(comboBox1.Text))
                            {
                                if (Convert.ToString(sqlReader["Pass"]) == textBox1.Text)
                                {
                                    Globals.pAuth = Convert.ToString(sqlReader["Client"]);
                                    Globals.Group = Convert.ToString(sqlReader["Group"]);

                                    //Globals.idGroup = Convert.ToString(sqlReader["IdGroup"]);

                                    if (Convert.ToInt32(sqlReader["IdGroup"]) == 1)
                                    {
                                        // Форма пользователя группы доступа 1 - Администратор
                                        f1.StartPosition = FormStartPosition.CenterParent;
                                        this.Hide();
                                        dblite.Close();
                                        f1.ShowDialog();
                                    }
                                    else if (Convert.ToInt32(sqlReader["IdGroup"]) == 2)
                                    {
                                        //MessageBox.Show("Мастер");
                                        // Форма пользователя группы доступа 2 - Мастер цеха
                                        f1.StartPosition = FormStartPosition.CenterParent;
                                        this.Hide();
                                        //dblite.Close();
                                        f1.ShowDialog();
                                    }
                                    else if (Convert.ToInt32(sqlReader["IdGroup"]) == 3)
                                    {
                                        // Форма пользователя группы доступа 3 - Пользователь
                                        f1.StartPosition = FormStartPosition.CenterParent;
                                        this.Hide();
                                        //dblite.Close();
                                        f1.ShowDialog();
                                    }
                                    else
                                        MessageBox.Show("Нет прав доступа!\nОбратитесь к администратору.", "Ошибка 1.02", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                }
                                else if (Convert.ToString(sqlReader["Pass"]) != textBox1.Text)
                                {
                                    MessageBox.Show("Пароль не верен!", "Авторизация", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                    textBox1.Text = "";
                                    textBox1.Focus();
                                    break;
                                }
                            }
                            else
                            {
                                continue;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message, "Ошибка 1.03", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    finally
                    {
                        if (sqlReader != null && !sqlReader.IsClosed)
                            sqlReader.Close();
                    }
                }
                else
                    MessageBox.Show("Не правильно введён пароль!", "Авторизация", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
                MessageBox.Show("Выберите пользователя!", "Авторизация", MessageBoxButtons.OK, MessageBoxIcon.Error);

            //  запись в таблицу
            //  UPOut.ExecuteScalar();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                Authentication();
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Focus();
        }
    }

    class Globals
    {
        public static string pAuth { get; set; }
        public static string Group { get; set; }
        public static string idGroup { get; set; }
    }
}
