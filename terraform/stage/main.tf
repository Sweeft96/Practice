terraform {
  # Версия terraform
  required_version = "0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "3.17.0"

  # ID проекта
  project = "infra-365211"
  region  = "europe-west1"
}
module "app" {
  source          = "../modules/app"
  public_key_path = "~/.ssh/appuser.pub"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
}
module "db" {
  source          = "../modules/db"
  public_key_path = "~/.ssh/appuser.pub"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}
module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
