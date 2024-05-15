provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Desktop Host Pool
resource "azurerm_virtual_desktop_host_pool" "example" {
  name                = var.host_pool_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  validate_environment     = true
  start_vm_on_connect      = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  description              = "Acceptance Test: A pooled host pool - ${var.host_pool_name}"
  maximum_sessions_allowed = var.max_session_limit
  load_balancer_type       = var.load_balancer_type
  type                     = "Pooled"  # Type of host pool
  
  # Scheduled agent updates
  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 2
    }
  }
}

# Virtual Desktop Application Group
resource "azurerm_virtual_desktop_application_group" "example" {
  name                = var.app_group_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  friendly_name       = var.app_group_friendly_name
  description         = var.app_group_description
  type                = var.app_group_resource_type
  host_pool_id        = azurerm_virtual_desktop_host_pool.example.id  # Link to host pool
}

# Virtual Desktop Workspace
resource "azurerm_virtual_desktop_workspace" "example" {
  name                = var.workspace_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  friendly_name       = var.workspace_friendly_name
  description         = var.workspace_description
  tags                = var.workspace_tags
}

# Virtual Desktop Application Group User Assignments
resource "azurerm_virtual_desktop_application_group_user" "example" {
  count                = length(var.users)
  resource_group_name  = azurerm_resource_group.example.name
  application_group_name = azurerm_virtual_desktop_application_group.example.name
  user_principal_name = var.users[count.index]
}
