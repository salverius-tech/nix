# Use the latest NixOS image as the base image
FROM nixos/nix

# Set the working directory inside the container
WORKDIR /app

# Copy the default.nix file from the install/auto directory to the container
COPY install/auto/default.nix .
COPY install/auto/configuration.nix .
COPY install/auto/hardware-configuration.nix .

# Install any necessary dependencies
RUN nix-build

# Set the entry point for the container
ENTRYPOINT ["bash"]