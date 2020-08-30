using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlEmployee : IEmployeeDao
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["MyMvcDbConnection"].ConnectionString;
        //static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyMvcDbConnection"].ToString());

        public static bool UserIsValid(string username, string password)
        {
            bool authentication = false;
            string query = string.Format("Select * FROM [Employee] WHERE Username = '{0}' AND Password = '{1}'", username, password);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                authentication = sdr.HasRows;
                connection.Close();
                return (authentication);
            }

        }
        public static bool GetUserNames(string UserName)
        {
            bool check = false;
            string query = string.Format("Select Username FROM [Employee] WHERE REPLACE(Username, ' ', '') = '{0}'", UserName);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                check = sdr.HasRows;
                connection.Close();
                return (check);
            }
        }

        public static bool GetIdCard(string Idcard)
        {
            bool check = false;
            string query = string.Format("Select Idcard FROM [Employee] WHERE REPLACE(Idcard, ' ', '') = '{0}'", Idcard);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                check = sdr.HasRows;
                connection.Close();
                return (check);
            }
        }

        public bool InsertEmployee(EmployeeEntity employee)
        {
            throw new NotImplementedException();
        }

        public bool InsertEmpAndPhone(EmployeeEntity employee, ICollection<EMPLOYEE_PHONE> list, string UPDATEDATA)
        {
            string sql = @"sp_employee_INSERT";
            string sql_phone = @"sp_empAndPhone_INSERT";
            string retID = "";
            if (UPDATEDATA.Equals("INSERT"))
            {
                using (TransactionScope ts = new TransactionScope())
                {
                    retID = Db.InsertReturnID(sql, Take(employee));
                    if (retID != null)
                    {
                        if (list.Count() == 0)
                        {
                            object[] obj = { "@PhoneNumber", "XXXXXXXXXX" };
                            Db.Insert(sql_phone, obj);
                        }
                        else
                        {
                            foreach (var ls in list)
                            {
                                object[] obj = { "@EmpID", retID, "@PhoneNumber", ls.Phone };
                                try
                                {
                                    Db.Insert(sql_phone, obj);
                                }
                                catch
                                {
                                    return false;
                                }
                            }
                        }
                        ts.Complete();
                        return true;
                    }
                    else { return false; }
                }
            }
            else if (UPDATEDATA.Equals("UPDATE"))
            {
                string sql_emp = @"sp_employee_UPDATE";
                string sql_upd = @"sp_empAndPhone_UPDATE";
                string sql_del = @"sp_empAndPhone_DELETE";


                using (TransactionScope ts = new TransactionScope())
                {// UPDATE พนักงาน
                    Db.Update(sql_emp, Take2(employee));
                    // ลบ และ สร้าง เบอร์ใหม่ เพื่อ อัพเดท
                    object[] del = { "@EmpID", employee.EmpID };
                    Db.Delete(sql_del, del);
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@EmpID", employee.EmpID, "@Phone", ls.Phone };
                            try { Db.Insert(sql_upd, obj); }
                            catch { return false; }
                        }
                        ts.Complete();
                        return true;
                    }
                }
            }
            return false;
        }
        public bool UpdateEmployee(EmployeeEntity employee)
        {
            throw new NotImplementedException();
        }

        public bool DeleteEmployee(string empID)
        {
            string sql = @"sp_employee_DELETE";
            object[] obj = { "@EmpID", empID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<EmpPosDetial> ListEmployee()
        {
            string sql = @"SELECT [EmpID]
	                              ,e.PosID
	                              ,p.PosName
                                  ,[Idcard]
                                  ,[Email]
                                  ,[Fname]
                                  ,[Lname]
                                  ,[Address]
                                  ,[Sex]
                                  ,[Salary]
                                  ,[Username]
                                  ,[Password]
                                  ,[EStatus]
                                  FROM [dbo].[EMPLOYEE] as e , dbo.POSITION as p where p.PosID = e.PosID and EStatus = 0
                                  order by e.PosID asc";
            return Db.ReadList(sql, Make);

        }

        public List<EmployeeEntity> ListEmployee(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public EmployeeEntity GetEmployee(string empID)
        {
            throw new NotImplementedException();
        }
        protected object[] Take(EmployeeEntity employee)
        {
            return new object[]{
                            "@PosID",employee.PosID,
                            "@Idcard",employee.Idcard,
                            "@Email",employee.Email,
                            "@Fname",employee.Fname,
                            "@Lname",employee.Lname,
                            "@Address",employee.Address,
                            "@Sex", employee.Sex,
                            "@Salary",employee.Salary,
                            "@Username",employee.UserName,
                            "@Password", employee.Password,
            };
        }

        protected object[] Take2(EmployeeEntity employee)
        {
            return new object[]{
                            "@EmpID",employee.EmpID,
                            "@PosID",employee.PosID,
                            "@Idcard",employee.Idcard,
                            "@Email",employee.Email,
                            "@Fname",employee.Fname,
                            "@Lname",employee.Lname,
                            "@Address",employee.Address,
                            "@Sex", employee.Sex,
                            "@Salary",employee.Salary,
                            "@Username",employee.UserName,
                            "@Password", employee.Password,
            };
        }

        protected Func<IDataReader, EmpPosDetial> Make = reader =>
        {
            return new EmpPosDetial
            {
                EmpID = reader["EmpID"].ToString(),
                PosID = reader["PosID"].ToString(),
                PosName = reader["PosName"].ToString(),
                Idcard = reader["Idcard"].ToString(),
                Email = reader["Email"].ToString(),
                Fname = reader["Fname"].ToString(),
                Lname = reader["Lname"].ToString(),
                Address = reader["Address"].ToString(),
                Sex = reader["Sex"].ToString(),
                Salary = reader["Salary"].ToString(),
                Username = reader["Username"].ToString(),
                Password = reader["Password"].ToString(),
                EStatus = reader["EStatus"].ToString(),
            };
        };
    }
}