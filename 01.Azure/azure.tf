# Create a resource group
module "rg" {
  source = "../../modules/azure/rg-0.0.4"

  az_rg_name     = var.rg_ResourceGroupName
  az_rg_location = var.rgn_RegionLocation
}

# Create a VNET
module "vnet" {
  source = "../../modules/azure/vnet-4.0.0"

  vnet_name           = var.vnet_Name
  resource_group_name = var.rg_ResourceGroupName
  vnet_location       = var.rgn_RegionLocation
  use_for_each        = false
  address_space       = [var.vnet_CIDR]
  subnet_prefixes     = [var.sub_PublicCIDR, var.sub_GatewayCIDR]
  subnet_names        = [var.sub_PublicName, var.sub_GatewayName]

  depends_on = [module.rg]
}

# Create a virtual network gateway
module "vnetgw" {
  source = "../../modules/azure/vnetgw-0.5.1"

  location                  = var.rgn_RegionLocation
  name                      = var.vgw_Name
  subnet_address_prefix     = var.sub_GatewayCIDR
  sku                       = var.vgw_SKU
  type                      = var.vgw_Type
  virtual_network_id        = module.vnet.vnet_id
  vpn_generation            = var.vgw_Generation
  vpn_type                  = var.vpn_Type
  subnet_creation_enabled   = false
  vpn_active_active_enabled = true
  vpn_bgp_enabled           = true
  vpn_bgp_settings = {
    asn = var.asn_Azure
  }
  # Create virtual network gateway configurations
  ip_configurations = {
    "ip_config_01" = {
      name            = var.gwc_BGPName1
      apipa_addresses = var.ip_APIPAAddresses1
      public_ip = {
        allocation_method = var.ip_allocation_method
      }
    },
    "ip_config_02" = {
      name            = var.gwc_BGPName2
      apipa_addresses = var.ip_APIPAAddresses2
      public_ip = {
        allocation_method = var.ip_allocation_method
      }
    }
  }
  # Create local network gateways and connections
  local_network_gateways = {
    # AWS Tunnel 1 to Azure Instance 0
    "lngw_01" = {
      name            = var.lng_AWST1A0
      gateway_address = var.ip_AWST1A0
      bgp_settings = {
        asn                 = var.asn_AWS
        bgp_peering_address = var.ip_peering_AWST1A0
      }
      connection = {
        name       = var.conn_AWST1A0
        type       = var.conn_Type
        enable_bgp = true
        shared_key = var.key_SharedKey
        custom_bgp_addresses = {
          primary   = var.ip_primary_AWST1A0
          secondary = var.ip_secondary_AWST1A0
        }
      }
    },
    # AWS Tunnel 2 to Azure Instance 0
    "lngw_02" = {
      name            = var.lng_AWST2A0
      gateway_address = var.ip_AWST2A0
      bgp_settings = {
        asn                 = var.asn_AWS
        bgp_peering_address = var.ip_peering_AWST2A0
      }
      connection = {
        name       = var.conn_AWST2A0
        type       = var.conn_Type
        enable_bgp = true
        shared_key = var.key_SharedKey
        custom_bgp_addresses = {
          primary = var.ip_primary_AWST2A0
        secondary = var.ip_secondary_AWST2A0 }
      }
    },
    # AWS Tunnel 1 to Azure Instance 1
    "lngw_03" = {
      name            = var.lng_AWST1A1
      gateway_address = var.ip_AWST1A1
      bgp_settings = {
        asn                 = var.asn_AWS
        bgp_peering_address = var.ip_peering_AWST1A1
      }
      connection = {
        name       = var.conn_AWST1A1
        type       = var.conn_Type
        enable_bgp = true
        shared_key = var.key_SharedKey
        custom_bgp_addresses = {
          primary = var.ip_primary_AWST1A1
        secondary = var.ip_secondary_AWST1A1 }
      }
    },
    # AWS Tunnel 2 to Azure Instance 1
    "lngw_04" = {
      name            = var.lng_AWST2A1
      gateway_address = var.ip_AWST2A1
      bgp_settings = {
        asn                 = var.asn_AWS
        bgp_peering_address = var.ip_peering_AWST2A1
      }
      connection = {
        name       = var.conn_AWST2A1
        type       = var.conn_Type
        enable_bgp = true
        shared_key = var.key_SharedKey
        custom_bgp_addresses = {
          primary = var.ip_primary_AWST2A1
        secondary = var.ip_secondary_AWST2A1 }
      }
    }
  }

  depends_on = [module.vnet]
}
