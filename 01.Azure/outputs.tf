output "vgw_publicip_1" {
  value       = module.vnetgw.public_ip_addresses.ip_config_01.ip_address
  description = "Use this output to populate the same variable in AWS variables.tf file."
}

output "vgw_publicip_2" {
  value       = module.vnetgw.public_ip_addresses.ip_config_02.ip_address
  description = "Use this output to populate the same variable in AWS variables.tf file."
}
