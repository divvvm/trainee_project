output "webserver_ips" {
  value = module.ec2.webserver_ips
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}