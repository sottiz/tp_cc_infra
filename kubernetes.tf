terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
}

data "google_client_config" "default" {}

data "google_container_cluster" "my_cluster" {
    name = google_container_cluster.primary.name

}

provider "kubernetes" {
  host = google_container_cluster.primary.outputs.kubernetes_cluster_host

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate)
}
