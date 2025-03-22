# Running Dev Containers Without Docker Desktop

This guide explains how to use Podman as an alternative to Docker Desktop for running development containers on both macOS and Windows systems.

## Why Podman?

Podman is a daemonless container engine that provides a Docker-compatible command line interface. Benefits include:

- No need for a background daemon process
- Rootless containers by default
- Compatible with Docker images and Dockerfiles
- Available on both macOS and Windows
- Free and open source without licensing restrictions

## Installation

### macOS

1. Install Podman using Homebrew:
   ```bash
   brew install podman
   ```

2. Initialize and start a Podman machine:
   ```bash
   podman machine init --cpus 2 --memory 2048 --disk-size 20
   podman machine start
   ```

3. Verify installation:
   ```bash
   podman version
   ```

### Windows

1. Install Podman using Chocolatey (in an admin PowerShell):
   ```powershell
   choco install podman
   ```
   
   Alternatively, download the installer from the [Podman releases page](https://github.com/containers/podman/releases).

2. Initialize and start a Podman machine:
   ```powershell
   podman machine init --cpus 2 --memory 2048 --disk-size 20
   podman machine start
   ```

3. Verify installation:
   ```powershell
   podman version
   ```

## Running the Dev Container

Follow these steps to run the development container:

1. Navigate to a directory where you want to store your dev container files:
   ```bash
   # Choose any directory where you want to store your work
   cd ~/Documents     # for macOS
   # or
   cd $env:USERPROFILE\Documents  # for Windows PowerShell
   ```

2. Create a `dev-container` directory:
   ```bash
   mkdir dev-container
   cd dev-container
   ```

3. Run the container using Podman:
   ```bash
   podman run -d -v ${PWD}:/home ghcr.io/ballerabdude/dev-container:latest
   ```
   
   On Windows PowerShell, use this syntax:
   ```powershell
   podman run -d -v ${PWD}:/home ghcr.io/ballerabdude/dev-container:latest
   ```

4. Verify the container is running:
   ```bash
   podman ps
   ```

## Accessing the Container

To access the running container:

```bash
# Get the container ID
podman ps

# Access the container shell
podman exec -it CONTAINER_ID /bin/bash
```

Replace `CONTAINER_ID` with the actual ID from the `podman ps` command.

## Using Docker-Compatible Tools with Podman

### Setting up Docker compatibility

#### macOS
```bash
echo 'alias docker=podman' >> ~/.zshrc  # or ~/.bash_profile
source ~/.zshrc  # or source ~/.bash_profile
```

#### Windows PowerShell
```powershell
# Add to your PowerShell profile
function docker { podman $args }
```

### Using Compose

Install Podman Compose:

```bash
# macOS
pip3 install podman-compose

# Windows
pip install podman-compose
```

## Stopping and Removing Containers

```bash
# Stop a running container
podman stop CONTAINER_ID

# Remove a container
podman rm CONTAINER_ID

# Stop and remove all containers
podman stop $(podman ps -q)
podman rm $(podman ps -a -q)
```

## Troubleshooting

### Volume Mounting Issues

If you encounter issues with volume mounting:

1. Make sure the Podman machine has access to the directory you're trying to mount
2. On macOS, only directories under your home directory can be mounted by default
3. On Windows, check the directory sharing settings in Podman

### Network Issues

If the container can't access the network:

```bash
# Restart the Podman machine
podman machine stop
podman machine start
```

### Resource Limitations

If the container is slow or unstable, increase the VM resources:

```bash
podman machine stop
podman machine set --cpus 4 --memory 4096
podman machine start
```

## Additional Resources

- [Podman Official Documentation](https://podman.io/docs)
- [Podman GitHub Repository](https://github.com/containers/podman) 