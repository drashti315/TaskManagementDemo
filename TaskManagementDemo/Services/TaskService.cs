using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using TaskManagementDemo.Models;
using TaskManagementDemo.Repositories;

namespace TaskManagementDemo.Services
{
    public class TaskService : ITaskService, ITaskStatusService
    {
        private readonly ITaskRepository _taskRepository;
        private readonly ITaskStatusRepository _taskStatusRepository;

        public TaskService(ITaskRepository taskRepository, ITaskStatusRepository taskStatusRepository)
        {
            _taskRepository = taskRepository;
            _taskStatusRepository = taskStatusRepository;
        }

        public async Task<List<TaskDetail>> GetAllTaskAsync()
        {
            return await _taskRepository.GetAllAsync();
        }

        public async Task<TaskDetail> GetTaskById(int id)
        {
            return await _taskRepository.GetByIdAsync(id);
        }

        public async Task<int> CreateTaskAsync(TaskDetail taskDetail)
        {
            Null(taskDetail, nameof(CreateTaskAsync));
            return await _taskRepository.CreateAsync(taskDetail);
        }

        public async Task<int> UpdateTaskAsync(TaskDetail taskDetail)
        {
            Null(taskDetail, nameof(UpdateTaskAsync));
            return await _taskRepository.UpdateAsync(taskDetail);
        }

        public async Task<int> DeleteTaskAsync(int id)
        {
            return await _taskRepository.DeleteAsync(id);
        }

        public static void Null(object input, string parameterName)
        {
            if (input == null)
            {
                throw new ArgumentNullException(parameterName);
            }
        }

        public async Task<List<TaskStatusDetail>> GetTaskStatusDetails()
        {
            return await _taskStatusRepository.GetTaskStatusDetails();
        }

    }
}
