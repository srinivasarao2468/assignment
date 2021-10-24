provider "aws" {
  region = "ap-south-1"
}

module "networking" {
  source   = "./modules/networking"
  app_name = var.app_name
}

module "eks" {
  source             = "./modules/eks"
  subnet_ids         = module.networking.pub_sub_ids
  private_subnet_ids = module.networking.pri_sub_ids
  app_name           = var.app_name
  vpc_id             = module.networking.vpc_id
}
