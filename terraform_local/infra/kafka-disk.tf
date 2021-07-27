## zookeeper PV
resource "kubernetes_persistent_volume" "zookeeper-test-pv" {
  metadata {
    name = "zookeeper-test-pv"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = "/storage/zookeeper/"
        type = "DirectoryOrCreate"
      }
    }
    persistent_volume_reclaim_policy = "Retain"
  }
}

## kafka pv
resource "kubernetes_persistent_volume" "kafka-test-pv" {
  metadata {
    name = "kafka-test-pv"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = "/storage/kafka/"
        type = "DirectoryOrCreate"
      }
    }
    persistent_volume_reclaim_policy = "Retain"
  }
}