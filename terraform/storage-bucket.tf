provider "google" {

  version = "3.17"
  project = "infra-365211"
  region  = "europe-west1"
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.1"

  # Имя поменяйте на другое
  name = "infra-365211"
}

output storage-bucket_url {
  value = module.storage-bucket.url
}

version = "3.17.0"
project = "${var.project}"
region = "${var.region}"
}
module "storage-bucket" {
source = "SweetOps/storage-bucket/google"
version = "0.1.1"
# Имена поменяйте на другие
name = ["storage-bucket-test", "storage-bucket-test2"]
}
output storage-bucket_url {
value = "${module.storage-bucket.url}"
}
