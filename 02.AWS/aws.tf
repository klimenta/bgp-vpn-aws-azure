# Create VPC
module "vpc" {

  source = "../../modules/aws/vpc-5.5.1"

  name = var.vpc_Name
  cidr = var.vpc_CIDR

  azs             = var.vpc_AZs
  private_subnets = var.sub_pvtCIDR
  public_subnets  = var.sub_pubCIDR

  enable_nat_gateway = true
  enable_vpn_gateway = true
  amazon_side_asn    = var.asn_AWS
}

# Change the route to enable propagation to public route table
# resource "aws_vpn_gateway_route_propagation" "rtPropg" {
#   vpn_gateway_id = module.vpc.vgw_id
#   route_table_id = module.vpc.public_route_table_ids[0]
# }

# Change the route to enable propagation to private route table
resource "aws_vpn_gateway_route_propagation" "rtPvtPropg" {
  vpn_gateway_id = module.vpc.vgw_id
  route_table_id = module.vpc.private_route_table_ids[0]
}

# Add the NAT gateway as a route to Internet to the private route table
# resource "aws_route" "r" {
#   route_table_id         = module.vpc.private_route_table_ids[0]
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = module.vpc.natgw_ids[0]
# }

# Create 2 customer gateways
module "cgw" {
  source = "../../modules/aws/cgw-2.0.1/"

  name = var.cgw_Name

  customer_gateways = {
    IP1 = {
      bgp_asn    = var.asn_Azure
      ip_address = var.vgw_publicip_1
    },
    IP2 = {
      bgp_asn    = var.asn_Azure
      ip_address = var.vgw_publicip_2
    }
  }
}

module "vpngw1" {
  source = "../../modules/aws/vpngw-3.7.2/"

  customer_gateway_id               = module.cgw.ids[0]
  vpc_id                            = module.vpc.vpc_id
  vpn_gateway_id                    = module.vpc.vgw_id
  vpn_connection_static_routes_only = false
  local_ipv4_network_cidr           = "0.0.0.0/0"

  tunnel1_inside_cidr   = var.ip_AWST1A0
  tunnel2_inside_cidr   = var.ip_AWST2A0
  tunnel1_preshared_key = var.key_SharedKey
  tunnel2_preshared_key = var.key_SharedKey

  tags = {
    Name = var.vpn_AWSA0Name
  }

  depends_on = [module.cgw]

}

module "vpngw2" {
  source = "../../modules/aws/vpngw-3.7.2/"

  customer_gateway_id               = module.cgw.ids[1]
  vpc_id                            = module.vpc.vpc_id
  vpn_gateway_id                    = module.vpc.vgw_id
  vpn_connection_static_routes_only = false
  local_ipv4_network_cidr           = "0.0.0.0/0"

  tunnel1_inside_cidr   = var.ip_AWST1A1
  tunnel2_inside_cidr   = var.ip_AWST2A1
  tunnel1_preshared_key = var.key_SharedKey
  tunnel2_preshared_key = var.key_SharedKey

  tags = {
    Name = var.vpn_AWSA1Name
  }

  depends_on = [module.cgw]

}
