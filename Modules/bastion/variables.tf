

variable "instance_type" {}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
}

variable "public_subnetsp" {
  description = "Desired number of instances in the cluster"
  type        = "list"
}


variable "sg_LB" {}
