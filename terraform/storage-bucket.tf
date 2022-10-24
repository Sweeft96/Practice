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

