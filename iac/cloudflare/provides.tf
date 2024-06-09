terraform {
  required_version = ">= 1.8.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.31.0"
    }
  }

}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}