# Instructions

## Azure

Configure Terraform to talk to Azure either thru a file or az login

```
cd 01.Azure
terraform init
terraform plan
terraform apply
```

It creates:

- One VNET
- One VNET Public subnet and one Gateway subnet
- One VNET Gateway with active-active BGP
- Four local network gateways
- Four site-to-site connections

### Output: Two public IPs. 
- vgw_publicip1
- vgw_publicip2

## AWS

Configure Terraform to talk to AWS either thru a file or aws sso login

### Input
Replace the two output IPs that you got from Azure and find the same variable names in 02.AWS\variables.tf file.
- vgw_publicip1
- vgw_publicip2

```
cd 02.AWS
terraform init
terraform plan
terraform apply
```
It creates:

- One VPC
- One public and one private subnet
- One NAT gateway
- Two customer gateways
- Two VPN connections

### Output: 4 public IPs.
- vpn1_ip1
- vpn1_ip2
- vpn2_ip1
- vpn2_ip2

## Azure

### Input
Replace the 4 output IPs that you got from AWS and find the same variable names in 01.Azure\variables.tf file.
- vpn1_ip1
- vpn1_ip2
- vpn2_ip1
- vpn2_ip2

```
cd 01.Azure
terraform plan
terrafor apply
```
## AWS
Check the tunnels in AWS by going to VPC | VPN | Site-to-Site VPN connections | Tunnel details tab
There will be two VPN connections with two tunnels each. All 4 should be up.

## Azure
Check the tunnels in Azure by going to Virtual Network Gateway | Monitoring | BGP Peers
There will be 4 "Connected" connections. 