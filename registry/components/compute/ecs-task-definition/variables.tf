variable "project_name" {
  type        = string
  description = "Project name for resources names."
}

variable "container_name" {
  type        = string
  description = "Container name inside the task def."
}

variable "image_uri" {
  type        = string
  description = "Image URI."
}

variable "container_port" {
  type        = number
  description = "Container port."
  default     = 80
}

variable "host_port" {
  type        = number
  description = "Host port. If 0, the port is random so multiple tasks can run on the same host."
  default     = 0
}

variable "task_cpu" {
  type        = number
  description = "Number of CPU units. 256 = 0.25vCPU, 512 = 0.5vCPU etc."
  default     = 512
}

variable "task_mem" {
  type        = number
  description = "Number of Mem in MB. "
  default     = 1024
}

variable "cpu_arch" {
  type        = string
  description = "Compatible CPU architecture."
  default     = "X86_64"
  validation {
    error_message = "cpu_arch must be X86_64 or ARM64."
    condition     = contains(["X86_64", "ARM64"], var.cpu_arch)
  }
}

variable "os_family" {
  type        = string
  description = "Target OS family."
  default     = "LINUX"
  validation {
    error_message = "os_family must be one of LINUX, WINDOWS_SERVER_2025_FULL, WINDOWS_SERVER_2025_CORE, WINDOWS_SERVER_2022_FULL, WINDOWS_SERVER_2022_CORE, WINDOWS_SERVER_2019_FULL, or WINDOWS_SERVER_2019_CORE."
    condition     = contains(["LINUX", "WINDOWS_SERVER_2025_FULL", "WINDOWS_SERVER_2025_CORE", "WINDOWS_SERVER_2022_FULL", "WINDOWS_SERVER_2022_CORE", "WINDOWS_SERVER_2019_FULL", " WINDOWS_SERVER_2019_CORE"], var.os_family)
  }
}

variable "healthcheck_command" {
  type        = list(string)
  description = "Command (in list of string) as healthcheck."
  default     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
