using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data.SQLite;

namespace WorkDivision
{
    class PEDDB
    {
        public SqlConnectionStringBuilder PedConn;

        public PEDDB()
        {
            PedConn = new SqlConnectionStringBuilder();

            PedConn.DataSource = "serverv";
            PedConn.InitialCatalog = "PED";
            PedConn.IntegratedSecurity = true;
            PedConn.UserID = "sa";
            PedConn.Password = "sapass";
            PedConn.MultipleActiveResultSets = true;

        }

        private string isNull(SqlDataReader dr, int col)
        {
            return dr.IsDBNull(dr.GetOrdinal(Convert.ToString(col))) ? null : dr.GetString(col);
        }

        public bool Execute(string query, List<SqlParameter> col)
        {

            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = PedConn.ConnectionString;
                SqlCommand com = new SqlCommand(query, con);
                com.Parameters.AddRange(col.ToArray());
                try
                {
                    con.Open();
                    var result = com.ExecuteNonQuery();
                    if (result == 1) return true;
                    else return false;
                }
                catch (Exception)
                {
                    return false;
                }
                finally
                {
                    con.Close();

                }
            }
        }

        public SqlConnection GetConnection()
        {
            return new SqlConnection(PedConn.ConnectionString);

        }
    }

}
