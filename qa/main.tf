terraform {
  required_providers {
    atlas = {
      source  = "ariga/atlas"
      version = "~> 0.4"
    }
  }
  backend "s3" {
    bucket = "assaya-terraform-state"
    key    = "infra/dev/sa-east-1/RDS/schema-migration/terraform.tf"
    region = "sa-east-1"
  }
}

provider "atlas" {}

data "atlas_migration" "openbio" {
  dir              = "../openbio/migrations"
  url              = var.url
  revisions_schema = "public"
}

resource "atlas_migration" "openbio" {
  dir              = data.atlas_migration.openbio.dir
  url              = data.atlas_migration.openbio.url
  revisions_schema = data.atlas_migration.openbio.revisions_schema
  version          = data.atlas_migration.openbio.latest
  dev_url          = var.dev_url
}

variable "dev_url" {
    type = string
}

variable "url" {
    type = string
}
