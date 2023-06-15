using System;
using System.Threading.Tasks;
using TaskManagementDemo.Services;
using Microsoft.AspNetCore.Mvc;
using TaskManagementDemo.Models;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace TaskManagementDemo.Controllers
{
    public class TaskController : Controller
    {
        private readonly ITaskService _taskService;
        private readonly ITaskStatusService _taskStatusService;

        public TaskController(ITaskService taskService, ITaskStatusService taskStatusService)
        {
            _taskService = taskService;
            _taskStatusService = taskStatusService;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _taskService.GetAllTaskAsync());
        }

        public async Task<IActionResult> Details(int id)
        {
            return View(await _taskService.GetTaskById(id));
        }

        public async Task<IActionResult> AddUpdateTask(int? id)
        {
            TaskDetail taskDetail = new TaskDetail();

            if (id != null && id > 0)
            {
                taskDetail = await _taskService.GetTaskById(Convert.ToInt32(id));
            }

            taskDetail.TaskStatus = await BindTaskStatusDetail();
            return View(taskDetail);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddUpdateTask(int id, TaskDetail taskDetail)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (id > 0)
                    {
                            await _taskService.UpdateTaskAsync(taskDetail);
                    }
                    else
                    {
                        await _taskService.CreateTaskAsync(taskDetail);
                    }
                    return RedirectToAction(nameof(Index));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Unable to save changes. " +
                                             "Try again, and if the problem persists " +
                                             "see your system administrator.");
            }

            taskDetail.TaskStatus = await BindTaskStatusDetail();
            return View(taskDetail);
        }

        [HttpGet]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                await _taskService.DeleteTaskAsync(id);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Unable to delete. " +
                                             "Try again, and if the problem persists " +
                                             "see your system administrator.");
            }

            return RedirectToAction(nameof(Index));
        }

        public async Task<List<SelectListItem>> BindTaskStatusDetail()
        {
            var taskList = (from item in await _taskStatusService.GetTaskStatusDetails()
                            select new SelectListItem()
                            {
                                Text = item.Status,
                                Value = Convert.ToString(item.Id),
                            }).ToList();

            taskList.Insert(0, new SelectListItem()
            {
                Text = "----Select----",
                Value = string.Empty
            });

            return taskList;
        }
    }
}
