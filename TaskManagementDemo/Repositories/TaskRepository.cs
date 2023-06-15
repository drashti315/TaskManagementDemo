using Dapper;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using TaskManagementDemo.Domain;
using TaskManagementDemo.Models;

namespace TaskManagementDemo.Repositories
{
    public class TaskRepository : BaseRepository, ITaskRepository,ITaskStatusRepository
    {
        public TaskRepository(IConfiguration configuration)
            : base(configuration)
        { }
         
        public async Task<List<TaskDetail>> GetAllAsync()
        {
            try
            {
                using (var connection = CreateConnection())
                {
                    return (await connection.QueryAsync<TaskDetail>(Consants.usp_GetAllTaskDetails,commandType: CommandType.StoredProcedure)).ToList();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public async Task<TaskDetail> GetByIdAsync(int id)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Id", id);

                using (var connection = CreateConnection())
                {
                    return (await connection.QueryFirstOrDefaultAsync<TaskDetail>(Consants.usp_GetTaskDetailsById, parameters, commandType: CommandType.StoredProcedure));
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public async Task<int> CreateAsync(TaskDetail entity)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Name", entity.Name);
                parameters.Add("@Description", entity.Description);
                parameters.Add("@Status", entity.Status);

                using (var connection = CreateConnection())
                {
                    return (await connection.ExecuteAsync(Consants.usp_AddTaskDetail, parameters, commandType: CommandType.StoredProcedure));
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public async Task<int> UpdateAsync(TaskDetail entity)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Id", entity.Id);
                parameters.Add("@Name", entity.Name);
                parameters.Add("@Description", entity.Description);
                parameters.Add("@Status", entity.Status);

                using (var connection = CreateConnection())
                {
                    return (await connection.ExecuteAsync(Consants.usp_UpdateTaskDetail, parameters, commandType: CommandType.StoredProcedure));
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public async Task<int> DeleteAsync(int id)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Id", id);

                using (var connection = CreateConnection())
                {
                    return (await connection.ExecuteAsync(Consants.usp_DeleteTaskDetail, parameters, commandType: CommandType.StoredProcedure));
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public async Task<List<TaskStatusDetail>> GetTaskStatusDetails()
        {
            try
            {
                using (var connection = CreateConnection())
                {
                    return (await connection.QueryAsync<TaskStatusDetail>(Consants.usp_GetTaskStatusDetails, commandType: CommandType.StoredProcedure)).ToList();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }
    }
}
