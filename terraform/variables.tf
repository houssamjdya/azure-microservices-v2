variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-microservices-v2"

}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "norwayeast"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "microservicesv2"
}

