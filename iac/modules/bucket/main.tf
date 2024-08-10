resource "google_storage_bucket" "tf-bucket" {
  name                     = "data-pipeline-tf-state-425016"
  location                 = var.region
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 604800 // 7 days
  }
}

resource "google_storage_bucket" "bucket-lake" {
  name                     = "bucket-lake-425016"
  location                 = var.region
  storage_class            = "STANDARD"
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}
