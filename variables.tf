variable "aws_region" {
  description = "The AWS region to use."
  default     = "<AWS_REGION>"
}

variable "vpc_id" {
  description = "The ID of the VPC."
}

variable "subnet_ids" {
  description = "The IDs of the subnets."
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group."
}

variable "target_group_arn" {
  description = "The ARN of the target group."
}
