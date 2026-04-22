resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registery" "main" {
  name                = "acr${var.project_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_log_analytics" "main" {
  name                = "log-${var.project_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.project_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_container_registery.main.location
  dns_prefix          = "aks-${var.project_name}"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"

  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics.main.id
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {

  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "Acr_Pull"
  scope                            = azurerm_container_registery.main.id
  skip_service_principal_aad_check = true
}