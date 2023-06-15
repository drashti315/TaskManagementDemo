using System.Data;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;

namespace TaskManagementDemo.Repositories
{
    public abstract class BaseRepository
    {
        private readonly IConfiguration _configuration;

        protected BaseRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        protected IDbConnection CreateConnection()
        {
            return new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        } 
    }
}
