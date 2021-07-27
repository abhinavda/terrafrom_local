resource "kubernetes_persistent_volume" "els-test-pv" {
  metadata {
    name = "els-test-pv"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadOnlyMany","ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/storage/elasticsearch/"
        type = "DirectoryOrCreate"
      }
    }
    persistent_volume_reclaim_policy = "Retain"
  }
}