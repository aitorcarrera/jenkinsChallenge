resource "kubernetes_namespace" "user_1" {
  metadata {
    name = "user-1"
  }
}

resource "kubernetes_namespace" "user_2" {
  metadata {
    name = "user-2"
  }
}

resource "kubernetes_service_account" "administrator" {
  metadata {
    name      = "administrator"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "user_1" {
  metadata {
    name      = "user-1"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "user_2" {
  metadata {
    name      = "user-2"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "user_3" {
  metadata {
    name      = "user-3"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "user_4" {
  metadata {
    name      = "user-3"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "user_5" {
  metadata {
    name      = "user-5"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "admin_user" {
  metadata {
    name = "admin-user"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "administrator"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
}

resource "kubernetes_cluster_role_binding" "user_1" {
  metadata {
    name = "user-1"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "user-1"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }
}

resource "kubernetes_cluster_role_binding" "user_2" {
  metadata {
    name = "user-2"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "user-2"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }
}

resource "kubernetes_role" "write_user_1" {
  metadata {
    name      = "write-user-1"
    namespace = "user-1"
  }

  rule {
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
    api_groups = ["*"]
    resources  = ["*"]
  }
}

resource "kubernetes_role" "read_user_2" {
  metadata {
    name      = "read-user-2"
    namespace = "user-2"
  }

  rule {
    verbs      = ["get", "list", "watch"]
    api_groups = ["*"]
    resources  = ["*"]
  }
}

resource "kubernetes_role_binding" "write_user_1" {
  metadata {
    name = "write-user-1"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "user-1"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "write-user-1"
  }
}

resource "kubernetes_role_binding" "read_user_2" {
  metadata {
    name = "read-user-2"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "user-1"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "read-user-2"
  }
}

