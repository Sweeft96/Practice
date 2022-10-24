variable "private_key_path" {
  description = "Path to the private key used for ssh provisioners"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-b"
}
variable "project" {
  description = "Project"
  default     = "infra-365211"
}
variable "region" {
  description = "Region"
  default     = "euro-west1"
}
