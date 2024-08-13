{
  fileSystems = {
    "/" = {
	device = "/dev/nvme0n1p6";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/nvme0n1p5";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/nvme0n1p6";
      fsType = "ext4";
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 5; #matters only when using multiple swap devices
  };

  swapDevices = [ { device = "/swapfile"; size = 5120; } ];
}
