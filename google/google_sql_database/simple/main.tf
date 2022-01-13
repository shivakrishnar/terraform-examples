# Summary: Creates a SQL database instance

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "project_id" {
  type = string
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# SQL database instance
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "google_sql_database" "database" {
  name     = "changeme_database"
  project  = var.project_id
  instance = google_sql_database_instance.master.name
}

resource "google_sql_database_instance" "master" {
  name             = "changedb"
  database_version = "POSTGRES_11"
  region           = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = false
}