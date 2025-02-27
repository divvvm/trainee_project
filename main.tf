module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source                    = "./modules/subnets"
  vpc_id                    = module.vpc.vpc_id
  public_subnet_cidr_1      = var.public_subnet_cidr_1
  public_subnet_cidr_2      = var.public_subnet_cidr_2
  private_app_subnet_cidr_1 = var.private_app_subnet_cidr_1
  private_app_subnet_cidr_2 = var.private_app_subnet_cidr_2
  private_db_subnet_cidr    = var.private_db_subnet_cidr
  public_route_table_id     = module.vpc.public_route_table_id
}

module "security_groups" {
  source             = "./modules/security_groups"
  vpc_id             = module.vpc.vpc_id
  bastion_ingress_ip = var.bastion_ingress_ip
  bastion_sg_name    = var.bastion_sg_name
  alb_sg_name        = var.alb_sg_name
  asg_sg_name        = var.asg_sg_name
  rds_sg_name        = var.rds_sg_name
  vpc_cidr           = var.vpc_cidr
}