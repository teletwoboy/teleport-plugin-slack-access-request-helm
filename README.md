<div align=center>

# teleport-plugin-slack-access-request-helm

[![License](https://img.shields.io/badge/License-Apache%202.0-%234b5563.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0)
[![MADE BY](https://img.shields.io/badge/made%20by-teletwoboy-informational?style=flat-square)](https://github.com/teletwoboy)
![Helm](https://img.shields.io/badge/Helm-Chart-success?style=flat-square)

</div>

<br>

## Overview
This repository contains the Helm chart for deploying the [teleport-plugin-slack-access-request](https://github.com/teletwoboy/teleport-plugin-slack-access-request) application to Kubernetes.  
It allows users to easily `install`, `configure`, and `upgrade` the plugin in a GitOps-friendly way.

It is versioned by Git tag rather than the Helm Repository, and will be refactored in the future.

<br>

## Installation

For installation instructions, <br>
please refer to the [teleport-plugin-slack-access-request installation](https://github.com/teletwoboy/teleport-plugin-slack-access-request?tab=readme-ov-file#installation-with-argocd). <br>
<br>
[teletwoboy](https://github.com/teletwoboy) aims for infrastructure management based on GitOps.

<br>

## Structure
```
.
├── charts                          # Directory containing packaged chart dependencies
│   └── postgresql-16.5.0.tgz       # Packaged PostgreSQL chart dependency (version 16.5.0)
├── templates                       # Kubernetes manifest templates with Helm placeholders/logic
│   ├── NOTES.txt                   # Post-installation notes displayed to the user after chart installation
│   ├── _helpers.tpl                # Helper template functions (e.g., naming conventions, labels) used in other templates
│   ├── deployment.yaml             # Kubernetes Deployment resource definition for the application
│   ├── hpa.yaml                     # Horizontal Pod Autoscaler configuration for scaling the application
│   ├── ingress.yaml                 # Ingress resource definition for external access to the service
│   ├── migration_job.yaml           # Kubernetes Job resource for running database migrations
│   ├── service.yaml                 # Kubernetes Service resource to expose the application internally
│   ├── serviceaccount.yaml          # ServiceAccount resource for assigning permissions to the application
│   └── tests                        # Directory containing Helm test templates
│       └── test-connection.yaml     # Helm test Pod to verify that the service is accessible after deployment
├── .helmignore                     # Files and directories to ignore when packaging the chart (similar to .gitignore)
├── Chart.lock                      # Lock file for chart dependencies to ensure consistent versions
├── Chart.yaml                      # Main Helm chart metadata (name, version, description, dependencies, etc.)
└── values.yaml                      # Default configuration values for the chart; can be overridden by the user
```

<br>

## License

This project is licensed under the [Apache License 2.0](LICENSE)

