variable "public_key_path" {
  description = "Path to the public key used for ssh provisioners"
  default     = "~/.ssh/appuser.pub"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh provisioners"
  default     = "~/.ssh/appuser"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-b"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

