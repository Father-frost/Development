namespace WorkDivision
{
    partial class fAddOper
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tbNVR = new System.Windows.Forms.TextBox();
            this.tbName = new System.Windows.Forms.TextBox();
            this.tbUCH = new System.Windows.Forms.TextBox();
            this.tbPER = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.tbNST = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.tbKOEF = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblID
            // 
            this.lblID.AutoSize = true;
            this.lblID.Location = new System.Drawing.Point(26, 29);
            this.lblID.Name = "lblID";
            this.lblID.Size = new System.Drawing.Size(0, 13);
            this.lblID.TabIndex = 16;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(449, 137);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(185, 23);
            this.button1.TabIndex = 15;
            this.button1.Text = "Сохранить";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(181, 102);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(33, 13);
            this.label1.TabIndex = 21;
            this.label1.Text = "NVR:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(26, 30);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(60, 13);
            this.label2.TabIndex = 22;
            this.label2.Text = "Операция:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(53, 65);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(33, 13);
            this.label4.TabIndex = 23;
            this.label4.Text = "UCH:";
            // 
            // tbNVR
            // 
            this.tbNVR.Location = new System.Drawing.Point(224, 99);
            this.tbNVR.Name = "tbNVR";
            this.tbNVR.Size = new System.Drawing.Size(73, 20);
            this.tbNVR.TabIndex = 24;
            // 
            // tbName
            // 
            this.tbName.Location = new System.Drawing.Point(95, 30);
            this.tbName.Name = "tbName";
            this.tbName.Size = new System.Drawing.Size(539, 20);
            this.tbName.TabIndex = 25;
            // 
            // tbUCH
            // 
            this.tbUCH.Location = new System.Drawing.Point(95, 62);
            this.tbUCH.Name = "tbUCH";
            this.tbUCH.Size = new System.Drawing.Size(73, 20);
            this.tbUCH.TabIndex = 26;
            // 
            // tbPER
            // 
            this.tbPER.Location = new System.Drawing.Point(224, 62);
            this.tbPER.Name = "tbPER";
            this.tbPER.Size = new System.Drawing.Size(73, 20);
            this.tbPER.TabIndex = 28;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(182, 65);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(32, 13);
            this.label3.TabIndex = 27;
            this.label3.Text = "PER:";
            // 
            // tbNST
            // 
            this.tbNST.Location = new System.Drawing.Point(383, 65);
            this.tbNST.Name = "tbNST";
            this.tbNST.Size = new System.Drawing.Size(73, 20);
            this.tbNST.TabIndex = 30;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(341, 68);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(32, 13);
            this.label5.TabIndex = 29;
            this.label5.Text = "NST:";
            // 
            // tbKOEF
            // 
            this.tbKOEF.Location = new System.Drawing.Point(95, 99);
            this.tbKOEF.Name = "tbKOEF";
            this.tbKOEF.Size = new System.Drawing.Size(73, 20);
            this.tbKOEF.TabIndex = 32;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(48, 102);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(38, 13);
            this.label6.TabIndex = 31;
            this.label6.Text = "KOEF:";
            // 
            // fAddOper
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(665, 192);
            this.Controls.Add(this.tbKOEF);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.tbNST);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.tbPER);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.tbUCH);
            this.Controls.Add(this.tbName);
            this.Controls.Add(this.tbNVR);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.lblID);
            this.Controls.Add(this.button1);
            this.Name = "fAddOper";
            this.Text = "Добавить / Изменить запись";
            this.Load += new System.EventHandler(this.fAddOper_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label lblID;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tbNVR;
        private System.Windows.Forms.TextBox tbName;
        private System.Windows.Forms.TextBox tbUCH;
        private System.Windows.Forms.TextBox tbPER;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbNST;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tbKOEF;
        private System.Windows.Forms.Label label6;
    }
}