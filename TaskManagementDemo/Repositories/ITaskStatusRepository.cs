using System.Collections.Generic;
using System.Threading.Tasks;
using TaskManagementDemo.Models;

namespace TaskManagementDemo.Repositories
{
    public interface ITaskStatusRepository
    {
        public Task<List<TaskStatusDetail>> GetTaskStatusDetails();
    }
}
