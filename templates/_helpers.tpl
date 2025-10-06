{{/*
Expand the name of the chart.
*/}}
{{- define "slack-access-request.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "slack-access-request.fullname" -}}
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
Create a default fully qualified postgresql name.
*/}}
{{- define "postgres.fullname" -}}
{{- if .Values.postgres.fullnameOverride }}
{{- .Values.postgres.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "postgres" .Values.postgres.nameOverride }}
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
{{- define "slack-access-request.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "slack-access-request.labels" -}}
slack-access-request.sh/chart: {{ include "slack-access-request.chart" . }}
{{ include "slack-access-request.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "slack-access-request.selectorLabels" -}}
app.kubernetes.io/name: {{ include "slack-access-request.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "slack-access-request.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "slack-access-request.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Renders an environment variable, using a secretKeyRef if secretName is provided,
otherwise uses the plain value.
*/}}
{{- define "slack-access-request.envFromSecretOrValue" -}}
{{- $envName := index . 0 -}}
{{- $plainValue := index . 1 -}}
{{- $secretName := index . 2 -}}
{{- $secretKey := index . 3 -}}

{{- if $secretName }}
- name: {{ $envName }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ required (printf "Missing secretKey for %s" $envName) $secretKey | quote }}
{{- else }}
- name: {{ $envName }}
  value: {{ required (printf "Missing value for %s" $envName) $plainValue | quote }}
{{- end }}

{{- end }}
