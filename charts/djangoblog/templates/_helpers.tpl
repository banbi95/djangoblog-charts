{{/*
Expand the name of the chart.
*/}}
{{- define "djangoblog-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "djangoblog-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "djangoblog-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "djangoblog-chart.labels" -}}
helm.sh/chart: {{ include "djangoblog-chart.chart" . }}
{{ include "djangoblog-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "djangoblog-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "djangoblog-chart.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "djangoblog-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "djangoblog-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "djangoblog-chart.mysqlHost" -}}
{{- if .Values.mysql.enabled }}
{{- if eq .Values.mysql.architecture "standalone" }}
{{ printf "%s-mysql.%s.svc.cluster.local" .Release.Name .Values.mysql.namespaceOverride |trimPrefix "\n" }}
{{- else if  eq .Values.mysql.architecture  "replication" }}
{{ printf "%s-mysql-master.%s.svc.cluster.local" .Release.Name .Values.mysql.namespaceOverride |trimPrefix "\n" }}
# default use djangoblog-mysql-db.svc.cluster.local
{{- else }}
{{ printf "%s-mysql.db.svc.cluster.local" .Release.Name | trimPrefix "\n" }}
{{- end }}
{{- else if .Values.exetanlDB.enabled }}
{{  .Values.externalDB.host }}
{{- end }}
{{- end }}


{{- define "djangoblog-chart.redisHost" -}}
{{- if eq .Values.redis.architecture "standalone" }}
{{ printf "%s-redis.%s.svc.cluster.local" .Release.Name .Values.redis.namespaceOverride | trim }}
{{- else if eq .Values.redis.architecture "replication" }}
{{ printf "%s-redis-master.%s.svc.cluster.local" .Release.Name .Values.redis.namespaceOverride |trim }}
{{- else }}
{{ printf "%s-redis.default.svc.cluster.local" .Release.Name | trim}}
{{- end }}
{{- end }}
