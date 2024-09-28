# Resource group
variable "rg_ResourceGroupName" {
  type        = string
  default     = "rgVPN"
  description = "Resource group name"
}

variable "rgn_RegionLocation" {
  type        = string
  default     = "eastus2"
  description = "Azure region"
}

# VNET
variable "vnet_Name" {
  type        = string
  default     = "vnetVPN"
  description = "VNET name"
}

variable "vnet_CIDR" {
  type        = string
  default     = "10.1.0.0/16"
  description = "VNET CIDR"
}

variable "sub_PublicCIDR" {
  type        = string
  default     = "10.1.0.0/24"
  description = "CIDR of the public subnet"
}

variable "sub_GatewayCIDR" {
  type        = string
  default     = "10.1.1.0/24"
  description = "CIDR of the Gateway subnet"
}

variable "sub_PublicName" {
  type        = string
  default     = "subPublic"
  description = "Name of the public subnet"
}

variable "sub_GatewayName" {
  type        = string
  default     = "GatewaySubnet"
  description = "Name of the Gateway subnet - DO NOT CHANGE. It has to stay as GatewaySubnet"
}

# Virtual network gateway
variable "vgw_Name" {
  type        = string
  default     = "vgwVPN"
  description = "Name of the virtual gateway"
}

variable "vgw_SKU" {
  type        = string
  default     = "VpnGw2AZ"
  description = "Virtual Gateway SKU"
}

variable "vgw_Type" {
  type        = string
  default     = "Vpn"
  description = "Virtual Gateway Type (VPN or ExpressRoute)"
}

variable "vgw_Generation" {
  type        = string
  default     = "Generation2"
  description = "Virtual Gateway Generation"
}

variable "vpn_Type" {
  type        = string
  default     = "RouteBased"
  description = "VPN type - RouteBased or PolicyBased"
}

variable "asn_Azure" {
  type        = string
  default     = "65000"
  description = "Azure ASN"
}

variable "asn_AWS" {
  type        = string
  default     = "64512"
  description = "AWS ASN"
}

# Virtual network gateway config 1
variable "gwc_BGPName1" {
  type        = string
  default     = "vnetGatewayConfig01"
  description = "Name of the virtual network gateway configuration for the first tunnel"
}

variable "ip_APIPAAddresses1" {
  type        = list(string)
  default     = ["169.254.21.2", "169.254.22.2"]
  description = "APIPA address for the first tunnel"
}

# Virtual network gateway config 2
variable "gwc_BGPName2" {
  type        = string
  default     = "vnetGatewayConfig02"
  description = "Name of the virtual network gateway configuration for the second tunnel"
}

variable "ip_APIPAAddresses2" {
  type        = list(string)
  default     = ["169.254.21.6", "169.254.22.6"]
  description = "APIPA address for the second tunnel"
}

variable "ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "Static or Dynamic public IP"
}

# Local network gateway common settings
variable "conn_Type" {
  type        = string
  default     = "IPsec"
  description = "Connection type: IPsec or Vnet2Vnet"
}

variable "key_SharedKey" {
  type        = string
  default     = "KlimentAndreev1970_"
  description = "Make sure it's the same as 'key_SharedKey' variable in variables.tf under the AWS folder"
  # Don't go crazy with complexity. AWS side can support only 
  # between 8 and 64 characters in length and cannot start with zero (0). 
  # Allowed characters are alphanumeric characters, periods (.), and underscores (_).
}

# Local network gateway AWS Tunnel 1 to Azure Instance 0
# lngw_01
variable "lng_AWST1A0" {
  type        = string
  default     = "lng_AWSTunnel1ToAzureInstance0"
  description = "From AWS Tunnel 1 to Azure Instance 0"
}

###
### REPLACE FROM THE OUTPUT OF AWS IN STEP 2
###
variable "ip_AWST1A0" {
  type        = string
  default     = "3.12.25.130"
  description = "Enter the output of ip_AWST1IP1 from the AWS output.tf script"
}

variable "ip_peering_AWST1A0" {
  type        = string
  default     = "169.254.21.1"
  description = "BGP Peering IP for AWS Tunnel1 to Azure Instance 0"
}

variable "ip_primary_AWST1A0" {
  type        = string
  default     = "169.254.21.2"
  description = "Primary Custom BGP Address for AWS Tunnel1 to Azure Instance 0"
}

variable "ip_secondary_AWST1A0" {
  type        = string
  default     = "169.254.21.6"
  description = "Secondary Custom BGP Address for AWS Tunnel1 to Azure Instance 0"
}

variable "conn_AWST1A0" {
  type        = string
  default     = "connAWSTunnel1toAzureInstance0"
  description = "Connection name for AWS Tunnel1 to Azure Instance 0"
}

# Local network gateway AWS Tunnel 2 to Azure Instance 0
# lngw_02
variable "lng_AWST2A0" {
  type        = string
  default     = "lng_AWSTunnel2ToAzureInstance0"
  description = "From AWS Tunnel 2 to Azure Instance 0"
}

###
### REPLACE FROM THE OUTPUT OF AWS IN STEP 2
###
variable "ip_AWST2A0" {
  type        = string
  default     = "3.134.250.132"
  description = "Enter the output of ip_AWST2A0 from the AWS output.tf script"
}

variable "ip_peering_AWST2A0" {
  type        = string
  default     = "169.254.22.1"
  description = "BGP Peering IP for AWS Tunnel2 to Azure Instance 0"
}

variable "ip_primary_AWST2A0" {
  type        = string
  default     = "169.254.22.2"
  description = "Primary Custom BGP Address for AWS Tunnel2 to Azure Instance 0"
}

variable "ip_secondary_AWST2A0" {
  type        = string
  default     = "169.254.21.6"
  description = "Secondary Custom BGP Address for AWS Tunnel1 to Azure Instance 1"
}

variable "conn_AWST2A0" {
  type        = string
  default     = "connAWSTunnel2toAzureInstance0"
  description = "Connection name for AWS Tunnel2 to Azure Instance 0"
}

# Local network gateway AWS Tunnel 1 to Azure Instance 1
# lngw_03
variable "lng_AWST1A1" {
  type        = string
  default     = "lng_AWSTunnel1ToAzureInstance1"
  description = "From AWS Tunnel 1 to Azure Instance 1"
}

###
### REPLACE FROM THE OUTPUT OF AWS IN STEP 2
###
variable "ip_AWST1A1" {
  type        = string
  default     = "3.128.169.24"
  description = "Enter the output of ip_AWST1A1 from the AWS output.tf script"
}

variable "ip_peering_AWST1A1" {
  type        = string
  default     = "169.254.21.5"
  description = "BGP Peering IP for AWS Tunnel1 to Azure Instance 1"
}

variable "ip_primary_AWST1A1" {
  type        = string
  default     = "169.254.21.2"
  description = "Primary Custom BGP Address for AWS Tunnel1 to Azure Instance 1"
}

variable "ip_secondary_AWST1A1" {
  type        = string
  default     = "169.254.21.6"
  description = "Secondary Custom BGP Address for AWS Tunnel1 to Azure Instance 1"
}

variable "conn_AWST1A1" {
  type        = string
  default     = "connAWSTunnel1toAzureInstance1"
  description = "Connection name for AWS Tunnel1 to Azure Instance 1"
}

# Local network gateway AWS Tunnel 2 to Azure Instance 1
# lngw_04
variable "lng_AWST2A1" {
  type        = string
  default     = "lng_AWSTunnel2ToAzureInstance1"
  description = "From AWS Tunnel 2 to Azure Instance 1"
}

###
### REPLACE FROM THE OUTPUT OF AWS IN STEP 2
###
variable "ip_AWST2A1" {
  type        = string
  default     = "18.217.179.34"
  description = "Enter the output of ip_AWST2A1 from the AWS ouput.tf script"
}

variable "ip_peering_AWST2A1" {
  type        = string
  default     = "169.254.22.5"
  description = "BGP Peering IP for AWS Tunnel2 to Azure Instance 1"
}

variable "ip_primary_AWST2A1" {
  type        = string
  default     = "169.254.21.2"
  description = "Primary Custom BGP Address for AWS Tunnel2 to Azure Instance 1"
}

variable "ip_secondary_AWST2A1" {
  type        = string
  default     = "169.254.22.6"
  description = "Secondary Custom BGP Address for AWS Tunnel2 to Azure Instance 1"
}

variable "conn_AWST2A1" {
  type        = string
  default     = "connAWSTunnel2toAzureInstance1"
  description = "Connection name for AWS Tunnel2 to Azure Instance 1"
}
