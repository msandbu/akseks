## Azure Diagnostics aktivering mot AKS 

resource "azurerm_monitor_diagnostic_setting" "aksla" {
  name               = "aksla"
  target_resource_id = azurerm_kubernetes_cluster.aks.id

  log {
    category = "kube-apiserver"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-audit"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-audit-admin"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-controller-manager"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-scheduler"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "cluster-autoscaler"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "guard"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log_analytics_workspace_id = azurerm_log_analytics_workspace.lawaks.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

# Azure Monitor Scheduled Log Query Alerts
resource "azurerm_monitor_scheduled_query_rules_alert" "example" {
  name                = "Monitoring Kube-DNS Service"
  location            = azurerm_resource_group.aksrg.location
  resource_group_name = azurerm_resource_group.aksrg.name
  action {
    action_group           = []
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_log_analytics_workspace.lawaks.id
  description    = "Scheduled query rule LogToMetric example"
  enabled        = true
  query          = <<-QUERY
KubePodInventory 
| where ServiceName == "kube-dns"
| where ContainerStatus <> "running"
  QUERY
  severity       = 1
  frequency      = 5
  time_window    = 30
  trigger {
    operator  = "GreaterThan"
    threshold = 3
  }
}
