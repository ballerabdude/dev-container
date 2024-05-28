FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=America/New_York

USER root
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER vscode

RUN sudo apt-get update -y ; sudo apt-get install -y make build-essential curl wget zsh git rsync


# The below commands are to make use of the Dcker cache to speed up the build process
# Create a dummy git repository
RUN sudo mkdir -p /.dotfiles && \
    # Give vscode user access to the /.dotfiles directory
    sudo chown -R vscode:vscode /.dotfiles && \
    cd /.dotfiles && \
    git init && \
    git remote add origin https://github.com/ballerabdude/dotfiles.git
# Clone the actual repository
RUN cd /.dotfiles && \
    git fetch origin main && \
    git reset --hard FETCH_HEAD


COPY init-container.sh /init-container.sh

RUN sudo chmod +x /init-container.sh

ENTRYPOINT [ "/init-container.sh" ]
