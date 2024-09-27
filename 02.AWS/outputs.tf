output "ip_AWST1A0" {
  value = module.vpngw1.vpn_connection_tunnel1_address
}

output "ip_AWST2A0" {
  value = module.vpngw1.vpn_connection_tunnel2_address
}

output "ip_AWST1A1" {
  value = module.vpngw2.vpn_connection_tunnel1_address
}

output "ip_AWST2A1" {
  value = module.vpngw2.vpn_connection_tunnel2_address
}