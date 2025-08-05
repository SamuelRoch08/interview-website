variable "cluster_name" {
  type        = string
  description = "Cluster name."
}

variable "cluster_max_size" {
  type        = number
  description = "Cluster maximum size."
  default     = 3
}

variable "cluster_min_size" {
  type        = number
  description = "Cluster minimum size."
  default     = 1
}

variable "cluster_target_size" {
  type = number 
  description = "Cluster target size."
  default = 2
}

variable "cluster_instance_types" {
  type = string 
  description = "Target instances types."
  default = "t3.micro"
}

variable "cluster_instance_ami" {
  type = string
  description = "Target AMI for instances."
  default = "ami-08c9a28b806bde705" # al2023-ami-ecs-hvm-2023.0.20250730-kernel-6.1-x86_64
}

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "List of subnets IDs for the cluster servers."
}

variable "allowed_inbound_cidr" {
  type        = list(string)
  description = "Allowed inbound CIDRs that can access the nodes."
}




variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
