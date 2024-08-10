resource "google_storage_bucket" "tf-bucket" {
  name                     = "data-pipeline-tfstate-425016"
  location                 = var.region
  storage_class            = "STANDARD"
  force_destroy            = false
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 604800 // 7 days
  }
}
