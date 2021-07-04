Demo Umgebung
=============

Kubernetes Umgebung mit 
- Monitoring (Prometheus)
- Service Mesh (Istio)
- Logging (fluent-bit)

Abgeleitet von den Beispielen
* [Monitoring](https://github.com/mc-b/duk-demo/blob/master/data/jupyter/demo/Prometheus.ipynb)
* [Service Mesh](https://github.com/mc-b/duk-demo/blob/master/data/jupyter/demo/ServiceMesh-Istio.ipynb)
* [Logging](https://github.com/mc-b/duk-demo/blob/master/data/jupyter/demo/Logging.ipynb)

Monitoring
----------

    kubectl get services -n monitoring

Installierte SW
- Alertmanager
- Grafana (User/PW: admin/prom-operator)
- Prometheus

Service Mesh
------------

Installiert ist istio mit kiali und jaeger.

    kubectl get services -n istio-system
    
Bookinfo Beispiel mit http://<ip vm>:<port istio-ingressgateway>/productpage anwählen.

Kiali und Jaeger UI anwählen.

Logging
-------

Logging dient der Aufzeichnung und Nachvollziehbarkeit von Fehlerzuständen des Softwareprozesses. 

Die ConfigMap `fluent-bit` im Namespace `logging` ist wie folgt zu erweitern:

    [OUTPUT]
        Name            stdout
        Match           *
        Retry_Limit     False 
        
fluent-bit Pod (z.B. im Dashboard) killen.        
        
Anschliessend ein Testpod starten, welcher all Sekunde eine Meldung ins Log schreibt.      

    kubectl apply -f https://raw.githubusercontent.com/mc-b/duk/master/logging/counter-pod.yaml  
    
Log anschauen

    kubectl logs -n logging -l app.kubernetes.io/name=fluent-bit  | grep counter
    
Testpod wieder löschen, ansonsten wird zu viel CPU verbraucht.

    kubectl delete -f https://raw.githubusercontent.com/mc-b/duk/master/logging/counter-pod.yaml

        