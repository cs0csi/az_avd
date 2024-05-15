variable "resource_group_name" {
  type    = string
  default = "MyAVDResourceGroup"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "host_pool_name" {
  type    = string
  default = "MyHostPool"
}

variable "host_pool_type" {
  type    = string
  default = "Pooled"
}

variable "load_balancer_type" {
  type    = string
  default = "DepthFirst"
}

variable "max_session_limit" {
  type    = number
  default = 10
}

variable "host_pool_registration_info" {
  type    = string
  default = "WVD Terraform Sample Host Pool"
}

variable "personal_desktop_assignment_type" {
  type    = string
  default = "Automatic"
}

variable "custom_rdp_properties" {
  type = list(object({
    key   = string
    value = string
  }))
  default = [
    {
      key   = "audiocapturemode"
      value = "0"
    },
    {
      key   = "audiomode"
      value = "1"
    },
  ]
}

variable "app_group_name" {
  type    = string
  default = "MyAppGroup"
}

variable "app_group_friendly_name" {
  type    = string
  default = "Sample App Group"
}

variable "app_group_description" {
  type    = string
  default = "WVD Terraform Sample App Group"
}

variable "app_group_resource_type" {
  type    = string
  default = "Desktop"
}

variable "workspace_name" {
  type    = string
  default = "MyWorkspace"
}

variable "workspace_friendly_name" {
  type    = string
  default = "Sample Workspace"
}

variable "workspace_description" {
  type    = string
  default = "WVD Terraform Sample Workspace"
}

variable "workspace_tags" {
  type    = map(string)
  default = {
    Environment = "Test"
  }
}

variable "users" {
  type    = list(string)
  default = ["<user1@example.com>", "<user2@example.com>"]
}
