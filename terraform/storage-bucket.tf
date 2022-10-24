provider "google" {
version = "3.17.0"
project = "infra-365211"
region = "europe-west1"
}
module "storage-bucket" {
source = "SweetOps/storage-bucket/google"
version = "0.1.1"
# Имена поменяйте на другие
name = ["storage-bucket-infra365211", "storage-bucket-infra365212"]
}
output storage-bucket_url {
value = "${module.storage-bucket.url}"
}

