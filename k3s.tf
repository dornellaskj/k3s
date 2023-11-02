module "k3s" {
  source  = "xunleii/k3s/module"
  k3s_version = "v1.0.0"
  name = "my.k3s.local"
  cidr = {
    pods = "10.0.0.0/16"
    services = "10.1.0.0/16"
  }
  drain_timeout = "30s"
  managed_fields = ["label", "taint"]
  global_flags = [
    "--tls-san k3s.my.domain.com"
  ]
  servers = {
    server-one = {
      ip = "192.168.86.28"
      connection = {
        host = "192.168.86.28" 
        user = "kevind"
      }
      flags = ["--flannel-backend=none"]
      labels = {"node.kubernetes.io/type" = "master"}
      taints = {"node.k3s.io/type" = "server:NoSchedule"}
    }
    server-two = {
      ip = "192.168.86.31"
      connection = {
        host = "192.168.86.31"
        user = "kevind"
      }
      flags = ["--flannel-backend=none"]
      labels = {"node.kubernetes.io/type" = "worker"}
      taints = {"node.k3s.io/type" = "server:NoSchedule"}
    }
  }
}