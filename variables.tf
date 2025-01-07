variable "aws_region" {
  description = "The AWS region to deploy resources."
  default     = "us-east-1"
}

variable "ami" {
  type        = string
  description = "AMI ID for the instances"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
}

variable "instance_types" {
  type = list(object({
    type     = string
    weighted = number
  }))
  description = "List of instance types with their weights"
  default = [
    {
      type     = "c5.xlarge"
      weighted = 1
    },
    {
      type     = "c5.2xlarge"
      weighted = 2
    },
    {
      type     = "c5.4xlarge"
      weighted = 4
    }
  ]
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "iam_fleet_role" {
  type        = string
  description = "IAM role ARN for Spot Fleet"
}

variable "target_capacity" {
  type        = number
  description = "Number of instances to maintain"
  default     = 1
}

variable "allocation_strategy" {
  type        = string
  description = "Spot Fleet allocation strategy"
  default     = "capacityOptimizedPrioritized"
}

variable "volume_config" {
  type = object({
    size = number
    type = string
  })
  description = "Root volume configuration"
  default = {
    size = 50
    type = "gp3"
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}