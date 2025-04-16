
# Kubernetes Setup for Prometheus, OpenTelemetry, and Grafana

This setup includes the configuration for Prometheus, OpenTelemetry Collector, and Grafana on Kubernetes. The following instructions will guide you through the process of deploying these services.

## Prerequisites

Before deploying the YAML files, ensure that you have the following installed:

### 1. Docker
- [Install Docker](https://docs.docker.com/get-docker/) on your local machine.
  
### 2. Kubernetes
- [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to interact with the Kubernetes cluster.
- Ensure you have a running Kubernetes cluster. You can use local solutions like [Minikube](https://minikube.sigs.k8s.io/docs/) or [K3s](https://k3s.io/) for testing.

### 3. Helm (Optional for some Kubernetes environments)
- [Install Helm](https://helm.sh/docs/intro/install/), which may help in managing complex deployments.

### 4. Set Up K8s Cluster
If you don't have a Kubernetes cluster, you can set up a simple local one using Minikube:
```bash
minikube start
```

### 5. Install Metrics Server (for Kubernetes clusters)
To monitor resources in your Kubernetes cluster, you may need the metrics server:
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml
```

---

## Deployment Instructions

### 1. Apply the YAML files

You need to apply the YAML files provided for the services. This will set up Prometheus, OpenTelemetry Collector, and Grafana.

Run the following commands:

```bash
kubectl apply -f /path/to/prometheus.yaml
kubectl apply -f /path/to/otel-collector.yaml
kubectl apply -f /path/to/grafana.yaml
```

Replace `/path/to/` with the actual path where your YAML files are stored.

### 2. Verify the Deployments

Check the status of the deployments:

```bash
kubectl get deployments
```

Ensure that all the deployments for `prometheus`, `otel-collector`, and `grafana` are listed as "READY."

### 3. Verify the Services

Check the services to ensure they are exposed properly:

```bash
kubectl get services
```

You should see the following services:
- Prometheus (`prometheus`)
- OpenTelemetry Collector (`otel-collector`)
- Grafana (`grafana`)

### 4. Access the Services

#### Prometheus:
Prometheus is exposed as a `NodePort` service, so you can access it via the Kubernetes node IP and port `31450`:
```bash
minikube service prometheus
```

#### Grafana:
Grafana is exposed as a `LoadBalancer` service. You can access it via the external IP of the service:
```bash
kubectl get svc grafana
```
Navigate to the Grafana UI at the IP address provided in the output (e.g., `http://<external-ip>:80`), and log in using the default username `admin` and password `admin`.

#### OpenTelemetry Collector:
The OpenTelemetry Collector is also exposed via a `LoadBalancer` service, accessible at the service's external IP.

### 5. Test the Setup

1. **Prometheus Metrics**: Go to `http://<prometheus-ip>:9090` and check the Prometheus dashboard. You can query the metrics scraped from the OpenTelemetry Collector.

2. **Grafana Dashboards**: In Grafana, add the Prometheus data source by selecting **Prometheus** as the data source and setting the URL to `http://prometheus:9090`. You should be able to visualize the metrics.

3. **Check Logs**: If you encounter any issues, you can check the logs of each service for debugging:

   - Prometheus logs:
     ```bash
     kubectl logs -f deployment/prometheus
     ```
   - OpenTelemetry Collector logs:
     ```bash
     kubectl logs -f deployment/otel-collector
     ```
   - Grafana logs:
     ```bash
     kubectl logs -f deployment/grafana
     ```

---

## Cleanup

To remove all the resources created:

```bash
kubectl delete -f /path/to/prometheus.yaml
kubectl delete -f /path/to/otel-collector.yaml
kubectl delete -f /path/to/grafana.yaml
```

---
