# DjangoBlog Charts

This repository contains Helm charts for deploying DjangoBlog, a blog application built with Django, the soure code can be found at  https://github.com/liangliangyy/DjangoBlog

## Prerequisites

- Kubernetes cluster v.1.23+
- Helm 3

## Installation

1. Add the Helm repository:

   ```bash
   helm repo add djangoblog-charts https://banbi95.github.io/djangoblog-charts
   helm repo update

2. Install the chart with default conf and latest version:
   ```bash
   helm install my-djangoblog djangoblog-charts/djangoblog 
3. Install with custom configuration（recommended）:
   ```bash
   helm search repo -l djangoblog 
   helm pull djangoblog-charts/djangoblog --version 0.1.x
   tar -zxvf djangoblog-charts-djangoblog-0.1.x.tgz
   helm install my-djangoblog djangoblog-charts/djangoblog --versions 0.1.x -f custom-values.yaml

4. Upgrading s
   ```bash
   helm upgrade my-djangoblog djangoblog-charts/djangoblog -f your-values.yaml

