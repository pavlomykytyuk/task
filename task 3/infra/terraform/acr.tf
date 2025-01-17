resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "allow_app_to_pull_from_registry" {
  principal_id         = azurerm_linux_web_app.springboot_react_app.identity.0.principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.main.id
}
