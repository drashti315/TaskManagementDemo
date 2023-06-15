using System.Collections.Generic;
using System.Threading.Tasks;
using TaskManagementDemo.Models;

namespace TaskManagementDemo.Services
{
    public interface ITaskService
    {
        public Task<List<TaskDetail>> GetAllTaskAsync();
        public Task<TaskDetail> GetTaskById(int id);
        public Task<int> CreateTaskAsync(TaskDetail taskDetail);
        public Task<int> UpdateTaskAsync(TaskDetail taskDetail);
        public Task<int> DeleteTaskAsync(int id);
    }
}
