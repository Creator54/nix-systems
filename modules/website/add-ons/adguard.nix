{ ... }:
let
  adguard = (import ./../../../config.nix { }).adguard;
in
{
  services = {
    nginx.virtualHosts."${adguard.host}" = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://localhost:" + builtins.toString adguard.port;
    };
    adguardhome = {
      enable = true;
      port = adguard.port;
    };
  };
}
