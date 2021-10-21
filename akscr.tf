resource "azurerm_container_registry" "acr" {
  name                = "azcr01"
  resource_group_name = azurerm_resource_group.aksrg.name
  location            = azurerm_resource_group.aksrg.location
  sku                 = "Standard"
  admin_enabled       = false
}
