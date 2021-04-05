# wazo-c4-helm

wazo-c4-helm provides templates and a Helm chart for the Wazo Platform C4. This repository is based on [Wazo's C4 Docker Compose](https://github.com/wazo-platform/wazo-c4) to deploy Wazo C4 infrastructure into a Kubernetes Cluster.

## Installing Helm

Helm is a package manager for Kubernetes applications. It is maintained by the [CNCF](https://www.cncf.io/) - in collaboration with Microsoft, Google, Bitnami and the Helm contributor community. 

Please refer to the [official Helm documentation](https://helm.sh/docs/intro/install/) for additional informations.

## Helm Architecture

Helm is composed of a client and an in-cluster server component:

* **Tiller Server:** Kubernetes application are managed through a component called Tiller Server installed within a Kubernetes cluster. Tiller interacts with the Kubernetes API server to install, upgrade, query and remove Kubernetes resources.

* **Helm Client:** A command-line interface is needed for users to work with Helm Charts. HThis client is interacting with the Tiller Server to perform various operations like install, upgrade and rollback charts.

## Templates

Helm uses Go templates for templating resource files. Beside Go's several built-in functions, Helm provides many other. The templates are found in the `wazo-c4/templates` directory of this repository.

## Charts
Beside templating, which is a powerful tool, Helm acts as a package manager for the Kubernetes application and makes installing, querying, upgrading, and deleting releases pretty seamless. Helm comes with commands to package, publish and fetch Kubernetes applications as Charts.

### package

The charts we've created can be packaged in order to be able to distribute them. The command we use is:

```$ helm package wazo-c4``` which creates a `wazo-c4-$(VERSION).tgz` archive that can be distributed manually or through public or private chart repositories.

### Helm repositories - Chartmuseum

#### Chartmuseum

[Chartmuseum](https://chartmuseum.com/) is an open-source Helm Chart Repository Server which can be deployed and used for storing charts.
Please refer to the documentation of Charmuseum for additional information.

## Common templating commands

### lint

```$ cd wazo-c4 && helm lint```

This project also uses `yamllint` which is run with helm lint in the make command: ```$ make lint``` in the root of this project.

### template

To generate the templates locally without a Tiller server for local testing:

```$ helm template wazo-c4/ --namespace="wazo"```

same as:

```$ make template``` in the root directory of this project. It will generate the `wazo-c4-$(VERSION).yaml` file.

## Local usage

Docker Desktop for Mac has the ability to start a single-node cluster. There is a `Kubernetes` tab in the `preferences` panel of Docker Desktop. Please refer to the documentation of Docker Desktop. For other operating systems [MiniKube](https://kubernetes.io/docs/tasks/tools/install-minikube/) can be used.

After a template is created it can be applied with ```$ make apply```.
