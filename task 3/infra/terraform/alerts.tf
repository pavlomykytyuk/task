resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "AppServiceCPUAlert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_service_plan.main.id]
  description         = "Alerts when the average CPU usage across the service plan is high"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT15M"

  criteria {
    metric_name      = "CpuPercentage"
    metric_namespace = "microsoft.web/serverfarms"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75 # We autoscale at 75%, so CPU over that means either we've hit the scaling limit or something is wrong with scaling
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_group.id
  }
}

resource "azurerm_monitor_metric_alert" "memory_alert" {
  name                = "AppServiceMemoryAlert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_web_app.springboot_react_app.id]
  description         = "Memory usage alert: running low on available memory"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_name      = "MemoryWorkingSet"
    metric_namespace = "Microsoft.Web/sites"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = "4000000000" # 4GB
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_group.id
  }
}

resource "azurerm_monitor_metric_alert" "app_service_http_errors" {
  name                = "AppService5xxHttpErrorsAlert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_web_app.springboot_react_app.id]
  severity            = 2
  enabled             = true
  description         = "Action will be triggered when Http Status Code 5XX is greater than or equal to 1"
  frequency           = "PT1M" // Checks every 1 min
  window_size         = "PT5M" // Every Check looks back 5 min for 5xx errors

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_group.id
  }
}

resource "azurerm_monitor_action_group" "alert_group" {
  name                = "AppServiceAlertGroup"
  resource_group_name = var.resource_group_name
  short_name          = "AlertGrp"

  email_receiver {
    name                    = "AdminEmail"
    email_address           = "admin@example.com"
    use_common_alert_schema = true
  }
}