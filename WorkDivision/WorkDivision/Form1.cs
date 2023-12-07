using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.IO;
using Settings2Ini;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SQLite;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using ListView = System.Windows.Forms.ListView;

namespace WorkDivision
{
    public partial class Form1 : Form
    {
        private String dbFileName;
        private SQLiteConnection dblite;
        private SQLiteCommand m_sqlCmd;
        private SQLiteDataReader sqlReader;

        public fAddWorker fAddWorker;
        public fAddBrig fAddBrig;
        public fAddProf fAddProf;
        public fAddOper fAddOper;
        public fAddModel fAddModel;
        public fAddProd fAddProd;
        public fAddTarif fAddTarif;
        public fAddNormNastil fAddNormNastil;
        public fAddNormControl fAddNormControl;
        //public fAuth fAuth;

        IniFile MyIni = new IniFile("Settings.ini");

        public Form1()
        {
            InitializeComponent();

            fAddWorker = new fAddWorker();
            fAddBrig = new fAddBrig();
            fAddProf = new fAddProf();
            fAddOper = new fAddOper();
            fAddModel = new fAddModel();
            fAddProd = new fAddProd();
            fAddTarif = new fAddTarif();
            fAddNormNastil = new fAddNormNastil();
            fAddNormControl= new fAddNormControl();
            //fAuth = new fAuth();

        }
        

        // авторасширение колонок listView по размеру содержимого
        public static void autoResizeColumns(ListView lv)
        {
            lv.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);
            ListView.ColumnHeaderCollection cc = lv.Columns;
            for (int i = 0; i < cc.Count; i++)
            {
                
                int colWidth = TextRenderer.MeasureText(cc[i].Text, lv.Font).Width + 10;
                if (i>0)
                {
                    if (colWidth > cc[i].Width)
                    {
                        cc[i].Width = colWidth;
                    }
                }
                else
                {
                    cc[i].Width = 0;
                }
            }
        }


        private void listView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void SettingsToolStripMenuItem1_Click(object sender, EventArgs e)
        {

        }

        private void подключитьсяToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            int windowTop = this.Top;
            int windowLeft = this.Left;
            MessageBox.Show(windowTop.ToString() + " - " + windowLeft);
            this.Top = 500;
            this.Left = 500;
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
            dblite.Open();


            //Настройка даты
            dateTimePicker1.Format = DateTimePickerFormat.Short;
            dateTimePicker1.Value = DateTime.Now;


            // отрисовка заголовков ListView
            lvDirWorkers.GridLines = true;
            lvDirWorkers.FullRowSelect = true;
            lvDirWorkers.View = View.Details;
            lvDirWorkers.Font = new Font(lvDirWorkers.Font, FontStyle.Bold);

            lvDirWorkers.Columns.Add("ID");
            lvDirWorkers.Columns.Add("Таб.№");
            lvDirWorkers.Columns.Add("ФИО");
            lvDirWorkers.Columns.Add("Разряд");
            lvDirWorkers.Columns.Add("Профессия");
            lvDirWorkers.Columns.Add("KO");
            lvDirWorkers.Columns.Add("Номер бригады");
            lvDirWorkers.Columns.Add("Название бригады");

            lvDirBrigs.GridLines = true;
            lvDirBrigs.FullRowSelect = true;
            lvDirBrigs.View = View.Details;
            lvDirBrigs.Font = new Font(lvDirBrigs.Font, FontStyle.Bold);
            lvDirBrigs.Columns.Add("ID");
            lvDirBrigs.Columns.Add("Номер");
            lvDirBrigs.Columns.Add("Название бригады");
            lvDirBrigs.Columns.Add("NUMK");

            lvDirProfs.GridLines = true;
            lvDirProfs.FullRowSelect = true;
            lvDirProfs.View = View.Details;
            lvDirProfs.Font = new Font(lvDirProfs.Font, FontStyle.Bold);
            lvDirProfs.Columns.Add("ID");
            lvDirProfs.Columns.Add("Код профессии");
            lvDirProfs.Columns.Add("Наименование");
            lvDirProfs.Columns.Add("PR");

            lvDirOpers.GridLines = true;
            lvDirOpers.FullRowSelect = true;
            lvDirOpers.View = View.Details;
            lvDirOpers.Font = new Font(lvDirOpers.Font, FontStyle.Bold);
            lvDirOpers.Columns.Add("id");
            lvDirOpers.Columns.Add("Участок");
            lvDirOpers.Columns.Add("Переход");
            lvDirOpers.Columns.Add("Наименование");
            lvDirOpers.Columns.Add("Коэф.");
            lvDirOpers.Columns.Add("Норма времени, сек");
            
            lvDirProducts.GridLines = true;
            lvDirProducts.FullRowSelect = true;
            lvDirProducts.View = View.Details;
            lvDirProducts.Font = new Font(lvDirProducts.Font, FontStyle.Bold);
            lvDirProducts.Columns.Add("id");
            lvDirProducts.Columns.Add("Наименование");
            
            lvDirTarif.GridLines = true;
            lvDirTarif.FullRowSelect = true;
            lvDirTarif.View = View.Details;
            lvDirTarif.Font = new Font(lvDirTarif.Font, FontStyle.Bold);
            lvDirTarif.Columns.Add("id");
            lvDirTarif.Columns.Add("Разряд");
            lvDirTarif.Columns.Add("Тар.ставка");
            lvDirTarif.Columns.Add("Коэф.сдел."); 
            
            lvDirNormNastil.GridLines = true;
            lvDirNormNastil.FullRowSelect = true;
            lvDirNormNastil.View = View.Details;
            lvDirNormNastil.Font = new Font(lvDirNormNastil.Font, FontStyle.Bold);
            lvDirNormNastil.Columns.Add("id");
            lvDirNormNastil.Columns.Add("Вид ткани");
            lvDirNormNastil.Columns.Add("Затрата врем. на 1м, сек");
            
            lvDirNormControl.GridLines = true;
            lvDirNormControl.FullRowSelect = true;
            lvDirNormControl.View = View.Details;
            lvDirNormControl.Font = new Font(lvDirNormControl.Font, FontStyle.Bold);
            lvDirNormControl.Columns.Add("id");
            lvDirNormControl.Columns.Add("Вид ткани");
            lvDirNormControl.Columns.Add("Затрата врем. на 1м, сек");

            lvDirModels.GridLines = true;
            lvDirModels.FullRowSelect = true;
            lvDirModels.View = View.Details;
            lvDirModels.Font = new Font(lvDirModels.Font, FontStyle.Bold);
            lvDirModels.Columns.Add("id");
            lvDirModels.Columns.Add("КОД");
            lvDirModels.Columns.Add("Название модели");
            lvDirModels.Columns.Add("Ед.изм.");

            // отрисовка заголовков ListView
            listView2.GridLines = true;
            listView2.FullRowSelect = true;
            listView2.View = View.Details;

            listView2.Columns.Add("КПР");
            listView2.Columns.Add("Наименование");
            listView2.Columns.Add("Партия");
            listView2.Columns.Add("Кол-во кодов");
            listView2.Columns.Add("Срок годности, сут.");
            listView2.Columns.Add("Количество кодов другого продукта");
            listView2.Columns.Add("GTIN");
            autoResizeColumns(listView2);
            dateTimePicker1_ValueChanged(this, null);

            if (MyIni.Read("usePed") == "1")
            {
                //Обновление справочника продукции
                //UpdateProductsToolStripMenuItem_Click(this, null);
            }

            tabControl1.SelectedIndex = 0;
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        //Изменение даты
        private async void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {
            string date1 = Convert.ToString(dateTimePicker1.Value.Year * 10000 + dateTimePicker1.Value.Month * 100 + dateTimePicker1.Value.Day);
            date1 = date1.Substring(6, 2) + date1.Substring(4, 2) + date1.Substring(0, 4);
            //Globals.datearr = date1;

            //dblite = new SQLiteConnection();
            listView2.Items.Clear();  //Чистим listview2

            try
            {
              

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
            toolStripStatusLabel1.Text = "Кол-во строк: " + listView2.Items.Count;

        }

        //Выгрузить в файл
        private async void toolStripButton5_Click(object sender, EventArgs e)
        {
            if (listView2.SelectedItems.Count > 0)
            {
                //Globals.batcharr = Convert.ToString(listView2.SelectedItems[0].SubItems[2].Text);
                //Globals.kprarr = Convert.ToString(listView2.SelectedItems[0].SubItems[0].Text);
                //Globals.trmdaysarr = Convert.ToString(listView2.SelectedItems[0].SubItems[4].Text);
                //Globals.gtinarr = Convert.ToString(listView2.SelectedItems[0].SubItems[6].Text);
                //string query = @"SELECT Code FROM MarkingTasks WHERE SUBSTR(Code,4,13)='" + Globals.gtinarr + @"' AND dtOutput=" + Globals.datearr + @" AND KPR =" + Globals.kprarr + @" AND batch='" + Globals.batcharr + "'";
                //await Codes2File(query);
            }
            else
            {
                MessageBox.Show("Выберите запись для выгрузки!");
            }
        }

        //Выгрузка файла с кодами маркировки для 1С
        //public async Task Codes2File(string query)
        //{
        //    int i= 0;
        //    string flname = "\\kpr" + Globals.kprarr + "_p" + Globals.batcharr + "_dt" + dateTimePicker1.Value.ToString("ddMMyyyy") + "_" + DateTime.Now.ToString("HH_mm_ss") + ".txt";
        //    FileStream file1 = new FileStream(MyIni.Read("dir") + flname, FileMode.Create); //создаем файловый поток
        //    StreamWriter writer = new StreamWriter(file1); //создаем потоковый писатель и связываем его с файловым потоком

        //    int warranty = Convert.ToInt32(Globals.trmdaysarr); //Срок годности, суток
        //    if (warranty != 0)
        //    {
        //        writer.Write(Globals.kprarr + ";" + Globals.batcharr + ";" + dateTimePicker1.Value.ToString("dd.MM.yyyy") +";"+ dateTimePicker1.Value.AddDays(warranty).Date.ToString("dd.MM.yyyy")+"\n");
        //    }
        //    else
        //    {
        //        writer.Write(Globals.kprarr + ";" + Globals.batcharr + ";" + dateTimePicker1.Value.ToString("dd.MM.yyyy") + "\n");
        //    }

        //    dbFileName = "marking.db";
        //    //string query = @"SELECT Code FROM MarkingTasks WHERE SUBSTR(Code,4,13)='"+Globals.gtinarr+ @"' AND dtOutput=" + Globals.datearr + @" AND KPR =" + Globals.kprarr + @" AND batch='" + Globals.batcharr+"'";

        //    try
        //    {
        //        //dblite = new SQLiteConnection("Data Source=" + dbFileName + ";Version=3;");
        //        //dblite.Open();
        //        m_sqlCmd = new SQLiteCommand(query, dblite);
        //        m_sqlCmd.Connection = dblite;
        //        sqlReader = m_sqlCmd.ExecuteReader();

        //        while (await sqlReader.ReadAsync())
        //        {

        //           writer.Write(Convert.ToString(sqlReader["Code"])+"\n");  //Пишем коды маркировки в текстовый файл
        //            i++;

        //        }

        //        MessageBox.Show("Файл сохранен: " + MyIni.Read("dir") + flname+". Кол-во кодов: "+i);
        //    }
        //    catch (SQLiteException ex)
        //    {
        //        MessageBox.Show("Error: " + ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlReader != null && !sqlReader.IsClosed)
        //            sqlReader.Close();
        //        writer.Close();
        //    }
        //}

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tabControl1.SelectedTab == tpDivision)
            {
                dateTimePicker1_ValueChanged(this, null);
                if (listView2.Items.Count == 0)
                {
                    toolStripStatusLabel1.Text = "Нет маркировки за выбранную дату.";
                }
                else
                {
                    toolStripStatusLabel1.Text = "Кол-во маркировок: "+ listView2.Items.Count;
                }
            }
            if (tabControl1.SelectedTab == tpDirs)  //Если выбрана закладка справочники
            {
                if (tabControl2.SelectedTab == tpDirWorkers)
                {
                    LoadDirWorkers();
                }
            }

            
        }

        //private async void UploadWithoutGTINtsItem_Click(object sender, EventArgs e)
        //{
        //    if (listView2.SelectedItems.Count > 0)
        //    {
        //        Globals.batcharr = Convert.ToString(listView2.SelectedItems[0].SubItems[2].Text);
        //        Globals.kprarr = Convert.ToString(listView2.SelectedItems[0].SubItems[0].Text);
        //        Globals.trmdaysarr = Convert.ToString(listView2.SelectedItems[0].SubItems[4].Text);
        //        Globals.gtinarr = Convert.ToString(listView2.SelectedItems[0].SubItems[6].Text);
        //        string query = @"SELECT Code FROM MarkingTasks WHERE dtOutput=" + Globals.datearr + @" AND KPR =" + Globals.kprarr + @" AND batch='" + Globals.batcharr + "'";
        //        await Codes2File(query);
        //    }
        //    else
        //    {
        //        MessageBox.Show("Выберите запись для выгрузки!");
        //    }
        //}

        private async void tabControl2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tabControl2.SelectedTab == tpDirWorkers)
            {
                LoadDirWorkers();
            }
            if (tabControl2.SelectedTab == tpDirBrigs)
            {
                LoadDirBrigs();
            }
            if (tabControl2.SelectedTab == tpDirProfs)
            {
                LoadDirProfs();
            }
            if (tabControl2.SelectedTab == tpDirOpers)
            {
                LoadDirOpers();
            }
            if (tabControl2.SelectedTab == tpDirModels)
            {
                LoadDirModels();
            }
            if (tabControl2.SelectedTab == tpDirProducts)
            {
                LoadDirProducts();
            }
            if (tabControl2.SelectedTab == tpDirTarif)
            {
                LoadDirTarif();
            }            
            if (tabControl2.SelectedTab == tpDirNormNastil)
            {
                LoadDirNormNastil();
            }            
            if (tabControl2.SelectedTab == tpDirNormControl)
            {
                LoadDirNormControl();
            }

        }
        public async void LoadDirWorkers()
        {
            lvDirWorkers.Items.Clear();  //Чистим listview2

            try
            {
                //dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
                //dblite.Open();
                string query = @"SELECT dw.id,dw.tab_nom,dw.FIO,dw.rank,dw.KO,dbr.KODBR,dbr.Name,pr.Name as prof
                            FROM DirWorkers as dw
                            LEFT JOIN DirBrigs as dbr on dw.brig_id = dbr.id
                            LEFT JOIN DirProfs as pr on pr.kprof = dw.kprof

                            ORDER BY FIO";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["Tab_nom"]),
                    Convert.ToString(sqlReader["FIO"]),
                    Convert.ToString(sqlReader["rank"]),
                    Convert.ToString(sqlReader["prof"]),
                    Convert.ToString(sqlReader["KO"]),
                    Convert.ToString(sqlReader["KODBR"]),
                    Convert.ToString(sqlReader["Name"])
                    });
                    item.Font = new Font(lvDirWorkers.Font, FontStyle.Regular);
                    lvDirWorkers.Items.Add(item);
                }

                autoResizeColumns(lvDirWorkers);

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
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirWorkers.Items.Count;
        }       
        

        private void lvDirWorkers_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirWorkers.SelectedItems.Count > 0)
            {
                fAddWorker.id_rec = Convert.ToString(lvDirWorkers.SelectedItems[0].SubItems[0].Text);
                fAddWorker.StartPosition = FormStartPosition.CenterParent;
                fAddWorker.Text = "Изменить";
                fAddWorker.ShowDialog();
                lvDirWorkers.Items.Clear();
                LoadDirWorkers();
            }
        }

        private void tsBtnAddWorker_Click(object sender, EventArgs e)
        {
            fAddWorker.id_rec = "";
            fAddWorker.StartPosition = FormStartPosition.CenterParent;
            fAddWorker.Text = "Добавить";
            fAddWorker.ShowDialog();
            lvDirWorkers.Items.Clear();
            LoadDirWorkers();
        }

        private void tsBtnEditWorker_Click(object sender, EventArgs e)
        {
            if (lvDirWorkers.SelectedItems.Count > 0)
            {
                lvDirWorkers_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.00.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }

        private async void tsBtnDelWorker_Click(object sender, EventArgs e)
        {
            if (lvDirWorkers.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        //dblite = new SQLiteConnection("Data Source=divisionDB.db;Version=3;");
                        //dblite.Open();
                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirWorkers WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirWorkers.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.00.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirWorkers();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.00.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirBrigs()
        {
            lvDirBrigs.Items.Clear();  //Чистим listview2

            try
            {
                string query = @"SELECT id,KODBR,Name,Numk
                            FROM DirBrigs ORDER BY KODBR";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["KODBR"]),
                    Convert.ToString(sqlReader["Name"]),
                    Convert.ToString(sqlReader["Numk"])
                    });
                    item.Font = new Font(lvDirBrigs.Font, FontStyle.Regular);
                    lvDirBrigs.Items.Add(item);
                }

                autoResizeColumns(lvDirBrigs);

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
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirBrigs.Items.Count;
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            dblite.Close();
            //fAuth.Close();
        }

        private void lvDirBrigs_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirBrigs.SelectedItems.Count > 0)
            {
                fAddBrig.id_rec = Convert.ToString(lvDirBrigs.SelectedItems[0].SubItems[0].Text);
                fAddBrig.StartPosition = FormStartPosition.CenterParent;
                fAddBrig.Text = "Изменить";
                fAddBrig.ShowDialog();
                lvDirBrigs.Items.Clear();
                LoadDirBrigs();
            }
        }

        private void tsBtnAddBrig_Click(object sender, EventArgs e)
        {
            fAddBrig.id_rec = "";
            fAddBrig.StartPosition = FormStartPosition.CenterParent;
            fAddBrig.Text = "Добавить";
            fAddBrig.ShowDialog();
            lvDirBrigs.Items.Clear();
            LoadDirBrigs();
        }

        private void tsBtnEditBrig_Click(object sender, EventArgs e)
        {
            if (lvDirBrigs.SelectedItems.Count > 0)
            {
                lvDirBrigs_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.01.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelBrig_Click(object sender, EventArgs e)
        {
            if (lvDirBrigs.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirBrigs WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirBrigs.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.01.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirBrigs();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.00.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirProfs()
        {
            lvDirProfs.Items.Clear();  //Чистим listview2

            try
            {
                string query = @"SELECT * FROM DirProfs ORDER BY kprof";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["kprof"]),
                    Convert.ToString(sqlReader["Name"]),
                    Convert.ToString(sqlReader["PR"])
                    });
                    item.Font = new Font(lvDirProfs.Font, FontStyle.Regular);
                    lvDirProfs.Items.Add(item);
                }

                autoResizeColumns(lvDirProfs);

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
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirProfs.Items.Count;
        }

        private void lvDirProfs_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirProfs.SelectedItems.Count > 0)
            {
                fAddProf.id_rec = Convert.ToString(lvDirProfs.SelectedItems[0].SubItems[0].Text);
                fAddProf.StartPosition = FormStartPosition.CenterParent;
                fAddProf.Text = "Изменить";
                fAddProf.ShowDialog();
                lvDirProfs.Items.Clear();
                LoadDirProfs();
            }
        }

        private void tsBtnAddProf_Click(object sender, EventArgs e)
        {
            fAddProf.id_rec = "";
            fAddProf.StartPosition = FormStartPosition.CenterParent;
            fAddProf.Text = "Добавить";
            fAddProf.ShowDialog();
            lvDirProfs.Items.Clear();
            LoadDirProfs();
        }

        private void tsBtnEditProf_Click(object sender, EventArgs e)
        {
            if (lvDirProfs.SelectedItems.Count > 0)
            {
                lvDirProfs_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.02.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelProf_Click(object sender, EventArgs e)
        {
            if (lvDirProfs.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirProfs WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirProfs.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.02.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirProfs();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.02.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void lvDirOpers_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirOpers.SelectedItems.Count > 0)
            {
                fAddOper.id_rec = Convert.ToString(lvDirOpers.SelectedItems[0].SubItems[0].Text);
                fAddOper.StartPosition = FormStartPosition.CenterParent;
                fAddOper.Text = "Изменить";
                fAddOper.ShowDialog();
                lvDirOpers.Items.Clear();
                LoadDirOpers();
            }
        }

        public async void LoadDirOpers()
        {
            lvDirOpers.Items.Clear();  //Чистим listview

            try
            {
                string query = @"SELECT * FROM DirOpers ORDER BY UCH,PER";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["UCH"]),
                    Convert.ToString(sqlReader["PER"]),
                    Convert.ToString(sqlReader["Name"]),
                    Convert.ToString(sqlReader["KOEF"]),
                    Convert.ToString(sqlReader["NVR"])
                    });
                    item.Font = new Font(lvDirOpers.Font, FontStyle.Regular);
                    lvDirOpers.Items.Add(item);
                }

                autoResizeColumns(lvDirOpers);

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
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirOpers.Items.Count;
        }

        private void tsBtnAddOper_Click(object sender, EventArgs e)
        {
            fAddOper.id_rec = "";
            fAddOper.StartPosition = FormStartPosition.CenterParent;
            fAddOper.Text = "Добавить";
            fAddOper.ShowDialog();
            lvDirOpers.Items.Clear();
            LoadDirOpers();
        }

        private void tsBtnEditOper_Click(object sender, EventArgs e)
        {
            if (lvDirOpers.SelectedItems.Count > 0)
            {
                lvDirOpers_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.05.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelOper_Click(object sender, EventArgs e)
        {
            if (lvDirOpers.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirOpers WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirOpers.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.05.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirOpers();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.05.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirModels()
        {
            lvDirModels.Items.Clear();  //Чистим listview

            try
            {
                string query = @"SELECT * FROM DirModels ORDER BY KMOD";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["KMOD"]),
                    Convert.ToString(sqlReader["Name"]),
                    Convert.ToString(sqlReader["EI"])
                    });
                    item.Font = new Font(lvDirModels.Font, FontStyle.Regular);
                    lvDirModels.Items.Add(item);
                }

                autoResizeColumns(lvDirModels);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.06.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirModels.Items.Count;
        }

        private void lvDirModels_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirModels.SelectedItems.Count > 0)
            {
                fAddModel.id_rec = Convert.ToString(lvDirModels.SelectedItems[0].SubItems[0].Text);
                fAddModel.StartPosition = FormStartPosition.CenterParent;
                fAddModel.Text = "Изменить";
                fAddModel.ShowDialog();
                lvDirModels.Items.Clear();
                LoadDirModels();
            }
        }

        private void tsBtnAddMod_Click(object sender, EventArgs e)
        {
            fAddModel.id_rec = "";
            fAddModel.StartPosition = FormStartPosition.CenterParent;
            fAddModel.Text = "Добавить";
            fAddModel.ShowDialog();
            lvDirModels.Items.Clear();
            LoadDirModels();
        }

        private void tsBtnEditMod_Click(object sender, EventArgs e)
        {
            if (lvDirModels.SelectedItems.Count > 0)
            {
                lvDirModels_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.06.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelMod_Click(object sender, EventArgs e)
        {
            if (lvDirModels.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirModels WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirModels.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.06.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirModels();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.06.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirProducts()
        {
            lvDirProducts.Items.Clear();  //Чистим listview

            try
            {
                string query = @"SELECT * FROM DirProducts ORDER BY id";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["Name"])
                    });
                    item.Font = new Font(lvDirProducts.Font, FontStyle.Regular);
                    lvDirProducts.Items.Add(item);
                }

                autoResizeColumns(lvDirProducts);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.07.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirProducts.Items.Count;
        }

        private void lvDirProducts_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirProducts.SelectedItems.Count > 0)
            {
                fAddProd.id_rec = Convert.ToString(lvDirProducts.SelectedItems[0].SubItems[0].Text);
                fAddProd.StartPosition = FormStartPosition.CenterParent;
                fAddProd.Text = "Изменить";
                fAddProd.ShowDialog();
                lvDirProducts.Items.Clear();
                LoadDirProducts();
            }
        }

        private void tsBtnAddProd_Click(object sender, EventArgs e)
        {
            fAddProd.id_rec = "";
            fAddProd.StartPosition = FormStartPosition.CenterParent;
            fAddProd.Text = "Добавить";
            fAddProd.ShowDialog();
            lvDirProducts.Items.Clear();
            LoadDirProducts();
        }

        private void tsBtnEditProd_Click(object sender, EventArgs e)
        {
            if (lvDirProducts.SelectedItems.Count > 0)
            {
                lvDirProducts_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.07.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelProd_Click(object sender, EventArgs e)
        {
            if (lvDirProducts.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirProducts WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirProducts.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.07.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirProducts();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.07.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirTarif()
        {
            lvDirTarif.Items.Clear();  //Чистим listview

            try
            {
                string query = @"SELECT * FROM DirTarif ORDER BY rank";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["rank"]),
                    Convert.ToString(sqlReader["TAR_VR"]),
                    Convert.ToString(sqlReader["K_SD"])
                    });
                    item.Font = new Font(lvDirTarif.Font, FontStyle.Regular);
                    lvDirTarif.Items.Add(item);
                }

                autoResizeColumns(lvDirTarif);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.08.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirTarif.Items.Count;
        }

        private void lvDirTarif_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirTarif.SelectedItems.Count > 0)
            {
                fAddTarif.id_rec = Convert.ToString(lvDirTarif.SelectedItems[0].SubItems[0].Text);
                fAddTarif.StartPosition = FormStartPosition.CenterParent;
                fAddTarif.Text = "Изменить";
                fAddTarif.ShowDialog();
                lvDirTarif.Items.Clear();
                LoadDirTarif();
            }
        }

        private void tsBtnAddTarif_Click(object sender, EventArgs e)
        {
            fAddTarif.id_rec = "";
            fAddTarif.StartPosition = FormStartPosition.CenterParent;
            fAddTarif.Text = "Добавить";
            fAddTarif.ShowDialog();
            lvDirTarif.Items.Clear();
            LoadDirTarif();
        }

        private void tsBtnEditTarif_Click(object sender, EventArgs e)
        {
            if (lvDirTarif.SelectedItems.Count > 0)
            {
                lvDirTarif_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.08.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelTarif_Click(object sender, EventArgs e)
        {
            if (lvDirTarif.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirTarif WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirTarif.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.08.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirTarif();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.08.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirNormNastil()
        {
            lvDirNormNastil.Items.Clear();  //Чистим listview

            try
            {
                string query = @"SELECT * FROM DirNormNastil ORDER BY id";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["VIDTK"]),
                    Convert.ToString(sqlReader["NORMVR"])
                    });
                    item.Font = new Font(lvDirNormNastil.Font, FontStyle.Regular);
                    lvDirNormNastil.Items.Add(item);
                }

                autoResizeColumns(lvDirNormNastil);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.09.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirNormNastil.Items.Count;
        }

        private void lvDirNormNastil_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirNormNastil.SelectedItems.Count > 0)
            {
                fAddNormNastil.id_rec = Convert.ToString(lvDirNormNastil.SelectedItems[0].SubItems[0].Text);
                fAddNormNastil.StartPosition = FormStartPosition.CenterParent;
                fAddNormNastil.Text = "Изменить";
                fAddNormNastil.ShowDialog();
                lvDirNormNastil.Items.Clear();
                LoadDirNormNastil();
            }
        }

        private void tsBtnAddNormNastil_Click(object sender, EventArgs e)
        {
            fAddNormNastil.id_rec = "";
            fAddNormNastil.StartPosition = FormStartPosition.CenterParent;
            fAddNormNastil.Text = "Добавить";
            fAddNormNastil.ShowDialog();
            lvDirNormNastil.Items.Clear();
            LoadDirNormNastil();
        }

        private void tsBtnEditNormNastil_Click(object sender, EventArgs e)
        {
            if (lvDirNormNastil.SelectedItems.Count > 0)
            {
                lvDirNormNastil_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.09.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelNormNastil_Click(object sender, EventArgs e)
        {
            if (lvDirNormNastil.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirNormNastil WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirNormNastil.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.09.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirNormNastil();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.09.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public async void LoadDirNormControl()
        {
            lvDirNormControl.Items.Clear();  //Чистим listview

            try
            {
                string query = @"SELECT * FROM DirNormControl ORDER BY id";

                m_sqlCmd = new SQLiteCommand(query, dblite);
                m_sqlCmd.Connection = dblite;

                sqlReader = m_sqlCmd.ExecuteReader();

                while (await sqlReader.ReadAsync())
                {
                    ListViewItem item = new ListViewItem(new string[] {
                    Convert.ToString(sqlReader["id"]),
                    Convert.ToString(sqlReader["VIDTK"]),
                    Convert.ToString(sqlReader["NORMVR"])
                    });
                    item.Font = new Font(lvDirNormControl.Font, FontStyle.Regular);
                    lvDirNormControl.Items.Add(item);
                }

                autoResizeColumns(lvDirNormControl);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка 5.09.07", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                    sqlReader.Close();
            }
            toolStripStatusLabel1.Text = "Кол-во строк: " + lvDirNormControl.Items.Count;
        }

        private void lvDirNormControl_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (lvDirNormControl.SelectedItems.Count > 0)
            {
                fAddNormControl.id_rec = Convert.ToString(lvDirNormControl.SelectedItems[0].SubItems[0].Text);
                fAddNormControl.StartPosition = FormStartPosition.CenterParent;
                fAddNormControl.Text = "Изменить";
                fAddNormControl.ShowDialog();
                lvDirNormControl.Items.Clear();
                LoadDirNormControl();
            }
        }

        private void tsBtnAddNormControl_Click(object sender, EventArgs e)
        {
            fAddNormControl.id_rec = "";
            fAddNormControl.StartPosition = FormStartPosition.CenterParent;
            fAddNormControl.Text = "Добавить";
            fAddNormControl.ShowDialog();
            lvDirNormControl.Items.Clear();
            LoadDirNormControl();
        }

        private void tsBtnEditNormControl_Click(object sender, EventArgs e)
        {
            if (lvDirNormControl.SelectedItems.Count > 0)
            {
                lvDirNormControl_MouseDoubleClick(this, null);
            }
            else
            {
                MessageBox.Show("Выберите строку для редактирования.", "Ошибка 5.09.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private async void tsBtnDelNormControl_Click(object sender, EventArgs e)
        {
            if (lvDirNormControl.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление...", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        SQLiteCommand delArrCommand = new SQLiteCommand("DELETE FROM DirNormControl WHERE id=@id", dblite);

                        delArrCommand.Parameters.AddWithValue("id", Convert.ToString(lvDirNormControl.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            await delArrCommand.ExecuteNonQueryAsync();
                        }
                        catch (SQLiteException ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка 5.10.04", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        // автообновление после удаления
                        LoadDirNormControl();

                        break;
                }
            }
            else
            {
                MessageBox.Show("Выберите строку для удаления.", "Ошибка 5.10.05", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

    }
}
