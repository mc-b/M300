Kubernetes Umgebung
===================

Kubernetes Umgebungen, basierend auf [microk8s](https://microk8s.io/) mit einer Main und einer Worker Node.

    vagrant ssh main
    kubectl get nodes
    kubectl get pods -A -o wide
    
Das Dashboard ist, im Browser, via [https://localhost:8443](https://localhost:8443) anwählbar.    