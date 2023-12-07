namespace WorkDivision
{
    partial class fAddNormNastil
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
            this.tbVIDTK = new System.Windows.Forms.TextBox();
            this.tbNORMVR = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
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
            this.button1.Location = new System.Drawing.Point(523, 119);
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
            this.label2.Location = new System.Drawing.Point(100, 39);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(76, 16);
            this.label2.TabIndex = 22;
            this.label2.Text = "Вид ткани:";
            // 
            // tbVIDTK
            // 
            this.tbVIDTK.Location = new System.Drawing.Point(195, 36);
            this.tbVIDTK.Margin = new System.Windows.Forms.Padding(4);
            this.tbVIDTK.Name = "tbVIDTK";
            this.tbVIDTK.Size = new System.Drawing.Size(559, 22);
            this.tbVIDTK.TabIndex = 25;
            // 
            // tbNORMVR
            // 
            this.tbNORMVR.Location = new System.Drawing.Point(195, 75);
            this.tbNORMVR.Margin = new System.Windows.Forms.Padding(4);
            this.tbNORMVR.Name = "tbNORMVR";
            this.tbNORMVR.Size = new System.Drawing.Size(231, 22);
            this.tbNORMVR.TabIndex = 26;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 78);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(163, 16);
            this.label1.TabIndex = 27;
            this.label1.Text = "Затрата времени на 1м:";
            // 
            // fAddNormNastil
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(785, 177);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tbNORMVR);
            this.Controls.Add(this.tbVIDTK);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.lblID);
            this.Controls.Add(this.button1);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "fAddNormNastil";
            this.Text = "Добавить / Изменить запись";
            this.Load += new System.EventHandler(this.fAddNormNastil_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label lblID;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbVIDTK;
        private System.Windows.Forms.TextBox tbNORMVR;
        private System.Windows.Forms.Label label1;
    }
}