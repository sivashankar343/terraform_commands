#To create Backup of terraform.tfstate into bucket

terraform {
  backend "s3" {
    bucket = "sivashankar-terraform-state-2026"
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}
