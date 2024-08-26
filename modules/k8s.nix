{ config, pkgs, ... }:

{
  services.kubernetes = {
    roles = [ "master" "node" ]; # Since you're running locally, this is fine

    apiserver = {
      enable = true;
      securePort = 8443;
      advertiseAddress = "127.0.0.1";
      # Setting etcd address to localhost
      etcd.servers = ["http://127.0.0.1:2379"];
    };

    controllerManager.enable = true;
    scheduler.enable = true;
    addonManager.enable = true;

    # Enable the proxy to manage traffic
    proxy = {
      enable = true;
      bindAddress = "0.0.0.0"; # Bind to all interfaces
    };

    # Enable Flannel for networking
    flannel = {
      enable = true;
      network = "10.1.0.0/16"; # Optional, default is fine
      backend = "vxlan";        # Optional, default is fine
    };
  };

  # Ensure Docker or containerd is enabled for Kubernetes to manage containers
  virtualisation.docker.enable = true;
  
  # Alternatively, if you prefer containerd over Docker, enable it like so:
  # virtualisation.containerd.enable = true;

  # Make sure that the necessary kernel modules are loaded
  boot.kernelModules = [ "overlay" "br_netfilter" ];

  networking.firewall.enable = false;  # Disable firewall for local testing (optional, but recommended for simplicity)

}

