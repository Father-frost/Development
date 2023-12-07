namespace WorkDivision
{
    partial class fAddTarif
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblID = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.tbRank = new System.Windows.Forms.TextBox();
            this.tbTAR_VR = new System.Windows.Forms.TextBox();
            this.tbK_SD = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblID
            // 
            this.lblID.AutoSize = true;
            this.lblID.Location = new System.Drawing.Point(35, 36);
            this.lblID.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lblID.Name = "lblID";
            this.lblID.Size = new System.Drawing.Size(0, 16);
            this.lblID.TabIndex = 16;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(135, 176);
            this.button1.Margin = new System.Windows.Forms.Padding(4);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(231, 28);
            this.button1.TabIndex = 15;
            this.button1.Text = "Сохранить";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(43, 39);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(58, 16);
            this.label2.TabIndex = 22;
            this.label2.Text = "Разряд:";
            // 
            // tbRank
            // 
            this.tbRank.Location = new System.Drawing.Point(135, 36);
            this.tbRank.Margin = new System.Windows.Forms.Padding(4);
            this.tbRank.Name = "tbRank";
            this.tbRank.Size = new System.Drawing.Size(231, 22);
            this.tbRank.TabIndex = 25;
            // 
            // tbTAR_VR
            // 
            this.tbTAR_VR.Location = new System.Drawing.Point(135, 83);
            this.tbTAR_VR.Margin = new System.Windows.Forms.Padding(4);
            this.tbTAR_VR.Name = "tbTAR_VR";
            this.tbTAR_VR.Size = new System.Drawing.Size(231, 22);
            this.tbTAR_VR.TabIndex = 26;
            // 
            // tbK_SD
            // 
            this.tbK_SD.Location = new System.Drawing.Point(135, 125);
            this.tbK_SD.Margin = new System.Windows.Forms.Padding(4);
            this.tbK_SD.Name = "tbK_SD";
            this.tbK_SD.Size = new System.Drawing.Size(231, 22);
            this.tbK_SD.TabIndex = 27;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 86);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(86, 16);
            this.label1.TabIndex = 28;
            this.label1.Text = "Тар. ставка:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 128);
            this.label3.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(85, 16);
            this.label3.TabIndex = 29;
            this.label3.Text = "Коэф. сдел.:";
            // 
            // fAddTarif
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(415, 233);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tbK_SD);
            this.Controls.Add(this.tbTAR_VR);
            this.Controls.Add(this.tbRank);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.lblID);
            this.Controls.Add(this.button1);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "fAddTarif";
            this.Text = "Добавить / Изменить запись";
            this.Load += new System.EventHandler(this.fAddTarif_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label lblID;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbRank;
        private System.Windows.Forms.TextBox tbTAR_VR;
        private System.Windows.Forms.TextBox tbK_SD;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
    }
}