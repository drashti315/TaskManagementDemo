using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using TaskManagementDemo.Domain;

namespace TaskManagementDemo.Models
{
    public class TaskDetail : BaseEntity
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Description { get; set; }
        public List<SelectListItem>  TaskStatus { get; set; }
        [Required]
        public int Status { get; set; }
        [Display(Name="Status")]
        public string StatusName { get; set; }
    }
}
