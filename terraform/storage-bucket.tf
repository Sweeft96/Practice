provider "google" {
  version = "3.17.0"
  project = var.project
  region  = var.region
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.1"
  name =  "terraform-prod-state-bucket"
}

output storage-bucket_url {
  value = module.storage-bucket.url
}
