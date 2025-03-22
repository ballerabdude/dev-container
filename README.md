# Dev-Container Project

This project contains the necessary configuration and scripts to set up a development environment in a container. The container can be deployed to a Kubernetes cluster and Visual Studio Code (VS Code) can be attached to it using the Kubernetes extension.

## Structure

The project is structured as follows:

- `Dockerfile`: This file contains the instructions to build the Docker image for the development environment.
- `init-container.sh`: This script is used to initialize the container. It starts the container, sets up a trap to exit gracefully on signal 15 (SIGTERM), and then executes the command passed as arguments to the script.
- `k8s/`: This directory contains Kubernetes configuration files for the project.
  - `deployment.yaml`: This file defines the deployment configuration for the development environment on Kubernetes.
  - `pvc.yaml`: This file defines the PersistentVolumeClaim resources used by the deployment.
- `.github/workflows/`: This directory contains GitHub Actions workflow files.
  - `docker-build-push.yml`: This workflow builds and pushes the Docker image to GitHub Container Registry (GHCR) when changes are pushed to the main branch.

## .dotfiles
[My Dotfiles](https://github.com/ballerabdude/dotfiles) are used to configure the development environment. The dotfiles are cloned into the docker image during build. The dotfiles contain configurations for various tools such as Vim, Tmux, and Git.
During startup the dotfiles are copied to the home directory of the user but are not overwritten if they already exist. The installation of the dotfiles is idempotent. Feel free to fork the dotfiles and customize them to your liking.

## Usage

### Running Locally with Docker

To run the development container locally:

1. Navigate to a directory where you want to store your dev container files:
   ```bash
   # Choose any directory where you want to store your work
   cd ~/Documents     # for macOS/Linux
   # or
   cd %USERPROFILE%\Documents     # for Windows Command Prompt
   # or
   cd $env:USERPROFILE\Documents  # for Windows PowerShell
   ```

2. Create a `dev-container` directory:
   ```bash
   mkdir dev-container
   cd dev-container
   ```

3. Run the container:
   ```bash
   docker run -d -v ${PWD}:/home ghcr.io/ballerabdude/dev-container:latest
   ```
   
   On Windows Command Prompt:
   ```cmd
   docker run -d -v %cd%:/home ghcr.io/ballerabdude/dev-container:latest
   ```
   
   On Windows PowerShell:
   ```powershell
   docker run -d -v ${PWD}:/home ghcr.io/ballerabdude/dev-container:latest
   ```

4. Verify the container is running:
   ```bash
   docker ps
   ```

5. Access the container shell:
   ```bash
   docker exec -it CONTAINER_ID /bin/bash
   ```
   Replace `CONTAINER_ID` with the ID from the `docker ps` command.
   
### Using Docker Desktop Alternatives

If you prefer not to use Docker Desktop, see [PODMAN_INSTRUCTIONS.md](PODMAN_INSTRUCTIONS.md) for details on how to run this container using Podman.

### Building from Source

To build the Docker image for the development environment, run the following command:

```sh
docker build -t dev-container .
```

### Kubernetes Deployment

To deploy the development environment on Kubernetes, run the following commands:
```sh
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/pvc.yaml
```

[Attach VS Code to a Kubernetes container](https://code.visualstudio.com/docs/devcontainers/attach-container#:~:text=To%20attach%20to%20a%20container,want%20to%20attach%20to%20resides.)

### GitHub Container Registry

The Docker image is automatically built and pushed to GitHub Container Registry (GHCR) when changes are pushed to the main branch. The workflow builds and tags the image with:
- `latest`
- `ubuntu-22.04` (matching the current base image)
- Short SHA of the commit
- Branch name
- Tag name (if pushing a tag)

You can pull the latest image from the registry using:

```sh
docker pull ghcr.io/YOUR_GITHUB_USERNAME/dev-container:ubuntu-22.04
```

Replace `YOUR_GITHUB_USERNAME` with your GitHub username.

#### Using the GHCR Image with Kubernetes

To use the image from GHCR in your Kubernetes deployment, update the image reference in `k8s/deployment.yaml`:

```yaml
spec:
  template:
    spec:
      containers:
      - name: dev-container
        image: ghcr.io/YOUR_GITHUB_USERNAME/dev-container:ubuntu-22.04
        # ... rest of the container spec
```

Replace `YOUR_GITHUB_USERNAME` with your GitHub username.

## Contributing
Contributions are welcome. Please submit a pull request or create an issue to discuss the changes you want to make.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

