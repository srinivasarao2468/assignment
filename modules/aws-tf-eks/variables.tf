variable "subnet_ids" {}

variable "private_subnet_ids" {}

variable "vpc_id" {}

variable "app_name" {
  default = "assignment"
}

variable "fp_namespace" {
  default = ["assignment"]
}

variable "node_groups" {
  type = map(object({
    scaling_config = map(string)
    instance_type  = string

  }))
  default = {
    assignment = {
      scaling_config = {
        desired_size = 1
        min_size     = 1
        max_size     = 2
      }
      instance_type = "t3.medium"
    }
    # sample = {
    #   scaling_config = {
    #     desired_size = 1
    #     min_size     = 1
    #     max_size     = 2
    #   }
    #   instance_type = "t3.micro"
    #}
  }
}
variable "tags"{
default = {}
}
