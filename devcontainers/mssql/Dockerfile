FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu 

#ENV DEBIAN_FRONTEND=noninteractive

# Install 'sudo' if the base image doesn't already have it.
# The 'devcontainers/base' images usually include sudo, so this might be redundant but harmless.
# Clean up apt cache immediately to keep image size down.
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# --- Configure a non-root user for development (essential security practice) ---
# Dev Container Features will be applied as this user.
# ARG values can be passed during the Docker build process if needed.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user and grant sudo privileges (no password required for convenience in a dev container).
##RUN if [ "$USER_UID" -ne "0" ]; then \
##        groupadd --gid "$USER_GID" "$USERNAME" \
##        && useradd -s /bin/bash --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME" \
##        && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"$USERNAME" \
##    ; fi

# Switch to the non-root user. All subsequent operations (including Dev Container Feature installations)
# will be performed as this user.
USER $USERNAME

# Set the working directory where your project code will be mounted.
WORKDIR /workspace

# No need for specific package installations like .NET SDK, mssql-tools, or Nix itself here,
# as those are handled by Dev Container Features in your devcontainer.json.
