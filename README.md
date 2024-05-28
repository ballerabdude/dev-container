# Dev-Container Project

This project contains the necessary configuration and scripts to set up a development environment in a container. The container can be deployed to a Kubernetes cluster and Visual Studio Code (VS Code) can be attached to it using the Kubernetes extension.

## Structure

The project is structured as follows:

- `Dockerfile`: This file contains the instructions to build the Docker image for the development environment.
- `init-container.sh`: This script is used to initialize the container. It starts the container, sets up a trap to exit gracefully on signal 15 (SIGTERM), and then executes the command passed as arguments to the script.
- `k8s/`: This directory contains Kubernetes configuration files for the project.
  - `deployment.yaml`: This file defines the deployment configuration for the development environment on Kubernetes.
  - `pvc.yaml`: This file defines the PersistentVolumeClaim resources used by the deployment.

## .dotfiles
[My Dotfiles](https://github.com/ballerabdude/dotfiles) are used to configure the development environment. The dotfiles are cloned into the docker image during build. The dotfiles contain configurations for various tools such as Vim, Tmux, and Git.
During startup the dotfiles are copied to the home directory of the user but are not overwritten if they already exist. The installation of the dotfiles is idempotent. Feel free to fork the dotfiles and customize them to your liking.

## Usage

[Attach VS Code to a Kubernetes container](https://code.visualstudio.com/docs/devcontainers/attach-container#:~:text=To%20attach%20to%20a%20container,want%20to%20attach%20to%20resides.)

To build the Docker image for the development environment, run the following command:

```sh
docker build -t dev-container .
```
To deploy the development environment on Kubernetes, run the following commands:
```sh
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/pvc.yaml
```



# Contributing
Contributions are welcome. Please submit a pull request or create an issue to discuss the changes you want to make.

# License
This project is licensed under the MIT License. See the LICENSE file for details.

