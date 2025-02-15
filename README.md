# DjangoBlog Charts

This repository contains Helm charts for deploying DjangoBlog, a blog application built with Django, the soure code can be found at  https://github.com/liangliangyy/DjangoBlog

## Prerequisites

- Kubernetes cluster v.1.23+
- Helm 3

## Installation

### 1  Add the Helm repository:
```bash
helm repo add djangoblog  https://banbi95.github.io/djangoblog-charts 
helm repo update
```
### 2 Install the chart with default conf and latest version:
```bash
helm install my-djangoblog djangoblog-charts/djangoblog 
```
### 3  Install with custom configuration（recommended）
#### 3.1 pull charts to local:
   ```bash
   helm search repo djangoblog  -l
   helm pull djangoblog/djangoblog-chart --version 0.2.0 --untar
```
#### 3.2 edit values under charts/djangoblog/values.yaml, these values will override values of subcharts mysql and redis 
```yaml
# see example-values.yaml

```
#### 3.3 installation and upgarde
   ```bash
helm install mydjangoblog ./charts/djangoblog/  -f charts/djangoblog/values.yaml --debug --dry-run
helm install mydjangoblog ./charts/djangoblog/  -f charts/djangoblog/values.yaml --debug  
helm upgrade mydjangoblog ./charts/djangoblog/  -f charts/djangoblog/values.yaml --debug



```

### 4 Initiation 
  ```bash
  kubectl get pods -n db 
  kubectl exec -it  <djangoblog-pod-name>  -n blog -- bash 
  python manage.py createsuperuser
  python manage.py create_testdata

  ```


