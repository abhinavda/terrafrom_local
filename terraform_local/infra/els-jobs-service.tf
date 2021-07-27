## elasticsearch service
resource "kubernetes_service" "elasticsearch-test-service" {
  metadata {
    name = "elasticsearch-test-service"
  }
  spec {
    selector ={
      app = "elasticsearch-test-app"
    }
    type = "NodePort"
    #cluster_ip = "10.96.0.5"
    port {
      port = 9200
      name = "client"
      target_port = 9200
      node_port = 30200
    }
    port {
      port = 9300
      name = "nodes"
      target_port = 9300
      node_port = 30300
    }
  }
}