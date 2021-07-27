resource "kubernetes_service" "zoo-test-service" {

  metadata {
    name = "zoo-test-service"
  }
  spec {
    selector ={
      app = "zookeeper-test-app"
    }
    type = "NodePort"
    #cluster_ip = "10.96.0.6"

    port {
      port = 2181
      name = "zk-client-port"
      target_port = 2181
      node_port = 30181
    }
    port {
      port = 2888
      name = "follower"
      target_port = 2888
    }
    port {
      port = 3888
      name = "leader"
      target_port = 2888
    }
  }
}

## kafka service
resource "kubernetes_service" "kafka-test-service" {
  metadata {
    name = "kafka-test-service"
  }
  spec {
    selector ={
      app = "kafka-test-app"
    }
    type = "NodePort"
    port {
      port = 9092
      name = "broker-port"
      target_port = 9092
      node_port = 30092
    }
  }
}