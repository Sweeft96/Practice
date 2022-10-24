provider "google" {
version = "3.17.0"
project = "${var.project}"
region = "${var.region}"
}
module "storage-bucket" {
source = "SweetOps/storage-bucket/google"
version = "0.1.1"
# Имена поменяйте на другие
name = ["storage-bucket-365211", "storage-bucket-365212"]
}
output storage-bucket_url {
value = "${module.storage-bucket.url}"
}
