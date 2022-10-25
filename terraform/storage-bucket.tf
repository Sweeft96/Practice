provider "google" {

  version = "3.17.0"
  project = "${var.project}"
  region  = "${var.region}"
}
module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.2"
  #name = "storage-bucket-test-44543534646"
  #source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "storage-sweeft96"
  #stage       = "production"
  #namespace   = "sweetops"
  location    = "europe-west1"
}
output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
