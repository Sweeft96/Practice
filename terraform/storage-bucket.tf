provider "google" {

version = "3.17.0"
project = "${var.project}"
region = "${var.region}"
}
module "storage-bucket" {
source = "SweetOps/storage-bucket/google"
version = "0.3.2"
# Имена поменяйте на другие
name = "storage-bucket-test"
}
output storage-bucket_url {
value = "${module.storage-bucket.url}"
}
