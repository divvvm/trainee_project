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