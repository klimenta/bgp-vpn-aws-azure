# VPC
variable "rgn_RegionLocation" {
  type        = string
  default     = "us-east-2"
  description = "AWS region"
}

variable "vpc_Name" {
  type        = string
  default     = "vpcVPN"
  description = "Name of the VPC in AWS"
}

variable "vpc_CIDR" {
  type        = string
  default     = "10.2.0.0/16"
  description = "CIDR of the VPC in AWS"
}

variable "vpc_AZs" {
  type        = list(string)
  default     = ["us-east-2a"]
  description = "Location of available zones"
}

variable "sub_pvtCIDR" {
  type        = list(string)
  default     = ["10.2.1.0/24"]
  description = "Private subnet CIDR"
}

variable "sub_pubCIDR" {
  type        = list(string)
  default     = ["10.2.2.0/24"]
  description = "Public subnet CIDR"
}

# Customer gateways
variable "cgw_Name" {
  type        = string
  default     = "cgwVPN"
  description = "Name of the Customer Gateway"
}

####
#### REPLACE WITH OUTPUT FROM AZURE
####
variable "vgw_publicip_1" {
  type        = string
  default     = "4.153.88.226"
  description = "Use the output from previous Azure script. First public IP of the Virtual Network Gateway in Azure"
}

####
#### REPLACE WITH OUTPUT FROM AZURE
####
variable "vgw_publicip_2" {
  type        = string
  default     = "4.153.88.212"
  description = "Use the output from previous Azure script. Second public IP of the Virtual Network Gateway in Azure"
}

variable "asn_AWS" {
  type        = string
  default     = "64512"
  description = "AWS ASN"
}

variable "asn_Azure" {
  type        = string
  default     = "65000"
  description = "Azure ASN"
}

# VPN site to site 1
variable "key_SharedKey" {
  type        = string
  default     = "KlimentAndreev1970_"
  description = "Make sure it's the same as vartiables.tf in  Azure folder"
  # Don't go crazy with complexity. AWS side can support only 
  # between 8 and 64 characters in length and cannot start with zero (0). 
  # Allowed characters are alphanumeric characters, periods (.), and underscores (_).

}

variable "vpn_AWSA0Name" {
  type        = string
  default     = "vpnToAzureInstance0"
  description = "AWS Tunnel to Azure Instance 0 name"
}

variable "ip_AWST1A0" {
  type    = string
  default = "169.254.21.0/30"
}

variable "ip_AWST2A0" {
  type    = string
  default = "169.254.22.0/30"
}

# VPN site to site 2
variable "vpn_AWSA1Name" {
  type        = string
  default     = "vpnToAzureInstance1"
  description = "AWS Tunnel to Azure Instance 1 name"
}

variable "ip_AWST1A1" {
  type    = string
  default = "169.254.21.4/30"
}

variable "ip_AWST2A1" {
  type    = string
  default = "169.254.22.4/30"
}
