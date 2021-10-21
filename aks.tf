resource "azurerm_resource_group" "aksrg" {
  name     = "aksrgg"
  location = "West Europe"
}

## Oppretter Log Analytics Workspace med Container Insight (avhengig av behov)

resource "azurerm_log_analytics_workspace" "lawaks" {
  name                = "aks-law"
  resource_group_name = azurerm_resource_group.aksrg.name
  location            = azurerm_resource_group.aksrg.location
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "example" {
  solution_name         = "Containers"
  workspace_resource_id = azurerm_log_analytics_workspace.lawaks.id
  workspace_name        = azurerm_log_analytics_workspace.lawaks.name
  location              = azurerm_resource_group.aksrg.location
  resource_group_name   = azurerm_resource_group.aksrg.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks1"
  location            = azurerm_resource_group.aksrg.location
  resource_group_name = azurerm_resource_group.aksrg.name
  dns_prefix          = "msandbutestvp"
  node_resource_group = "aks-workers-rg"
  sku_tier            = "Paid"

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
      // opsjon:
      admin_group_object_ids  = ["ca07e64d-d490-4b10-a70f-a5ee450fd47b"] 
    }
  }

  // api_server_authorized_ip_ranges = "192.168.0.0/16"


  default_node_pool {
    name       = "systempool"
    node_count = 3
    vm_size    = "standard_d4_v4"
    tags = {
      "project" = "System Pool"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  ## Azure AD Integrert
  ## Aktiverer Kubernetes Addons for AKS, Azure Policy og OMS agent 

  addon_profile {
    azure_policy {
      enabled = true
    }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.lawaks.id
    }
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}


