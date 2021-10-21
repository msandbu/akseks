resource "azurerm_security_center_subscription_pricing" "asc_aks" {
  tier          = "Standard"
  resource_type = "KubernetesService"
}

resource "azurerm_security_center_subscription_pricing" "asc_cr" {
  tier          = "Standard"
  resource_type = "ContainerRegistry"
}

resource "azurerm_security_center_workspace" "asc_la" {
  scope        = "/subscriptions/6786a392-5dfc-4ed5-8a03-baba5ce5c186"
  workspace_id = azurerm_log_analytics_workspace.lawaks.id
}
