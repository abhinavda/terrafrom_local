resource "kubernetes_deployment" "elasticsearch-test-deployment" {
  metadata {
    name = "elasticsearch-test-deployment"
    labels ={
      app = "elasticsearch-test-app"
    }
  }
  spec {
    selector {
      match_labels ={
        app = "elasticsearch-test-app"
      }
    }
    template {
      metadata {
        labels ={
          app = "elasticsearch-test-app"
        }
      }
      spec {
        container {
          name = "elasticsearch-test-container"
          image = "elasticsearch:7.9.1"
          security_context {
          }
          env {
        name = "discovery.type"
        value= "single-node"
      }
      port {
        container_port = 9200
        name = "client"
      }
      port {
        container_port = 9300
        name = "nodes"
      }
      volume_mount {
        mount_path = "/usr/share/elasticsearch/data/" # volume on container
        name = "els-test-vol"
      }
  }
        volume {
      name = "els-test-vol"
      host_path {
        path = "/storage/elasticsearch/" # on minikube, data will be stored here
        type = "DirectoryOrCreate"
      }
    }
      }
    }
  }
}