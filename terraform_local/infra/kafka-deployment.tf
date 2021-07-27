resource "kubernetes_deployment" "zookeeper-test-deployment" {
  metadata {
    name = "zookeeper-test-deployment"
    labels ={
      app = "zookeeper-test-app"
    }
  }
  spec {
    selector {
      match_labels ={
        app = "zookeeper-test-app"
      }
    }
    template {
      metadata {
        labels ={
          app = "zookeeper-test-app"
        }
      }
      spec {
        container {
          name = "zoo-test-container"
          image = "bitnami/zookeeper:latest"
          security_context {
          }
          port {
            container_port = 2181
            name = "zk-client-port"
          }
          env {
            name = "ALLOW_ANONYMOUS_LOGIN"
            value = "yes"
          }
          env {
            name = "ZOO_SERVER_ID"
            value = "1"
          }
          volume_mount {
            mount_path = "/bitnami/zookeeper/data/version-2/"
            name = "zookeeper-version-dir"
          }
  }
        volume {
          name = "zookeeper-version-dir"
          host_path {
            path = "/storage/zookeeper/"
            type = "DirectoryOrCreate"
          }
        }
      }
    }
  }
}

## kafka deployment:
resource "kubernetes_deployment" "kafka-test-deployment" {
  metadata {
    name = "kafka-test-deployment"
    labels ={
      app = "kafka-test-app"
    }
  }

  spec {
    selector {
      match_labels ={
        app = "kafka-test-app"
      }
    }
    template {
      metadata {
        labels ={
          app = "kafka-test-app"
        }
      }
      spec {

        container {
          name = "kafka-test-container"
          image = "wurstmeister/kafka:2.12-2.4.1"
          security_context {
          }
          port {
            container_port = 9092
            name = "broker-port"
          }
          env {
            name = "KAFKA_ZOOKEEPER_CONNECT"
            value = "zoo-test-service:2181/kafka"
          }
          env {
            name = "KAFKA_LISTENERS"
            value = "PLAINTEXT://0.0.0.0:9092"
          }
          env {
            name = "KAFKA_ADVERTISED_LISTENERS"
            value= "PLAINTEXT://kafka-test-service:9092"
          }
          env {
            name = "KAFKA_BROKER_ID"
            value= "0"
          }
          env {
            name = "KAFKA_ADVERTISED_PORT"
            value = "9092"
          }
          env{
            name="KAFKA_LOG_DIRS"
            value = "/kafka/kafka-logs/"
          }
          env {
            name = "KAFKA_CLUSTER_ID"
            value = "test-kafka-cluster"
          }
          volume_mount {
            mount_path = "/kafka/kafka-logs/"
            name = "kafka-log-dir"
          }
        }
         volume {
          name = "kafka-log-dir"
          host_path {
            path = "/storage/kafka/"
            type = "DirectoryOrCreate"
          }
        }
      }
    }
  }
}
