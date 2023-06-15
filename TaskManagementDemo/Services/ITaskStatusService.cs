using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TaskManagementDemo.Models;

namespace TaskManagementDemo.Services
{
    public interface ITaskStatusService
    {
        public Task<List<TaskStatusDetail>> GetTaskStatusDetails();
    }
}
