{ self, config, lib, ... }:
let
  proxies = import "${self}/secrets/proxies.nix";
in
{
  options.proxy.pacFile = lib.mkOption {
    type = lib.types.path;
    readOnly = true;
    description = "Path to the generated PAC file routing select hosts through SOCKS5 proxies.";
  };

  config = {
    proxy.pacFile = "${config.xdg.configHome}/proxy.pac";

    xdg.configFile."proxy.pac".text = ''
      const proxies = ${builtins.toJSON proxies};

      function FindProxyForURL(url, host) {
        if (isPlainHostName(host) || shExpMatch(host, "*.local") || isInNet(host, "127.0.0.0", "255.0.0.0")) {
          return "DIRECT";
        }

        for (const proxy of proxies) {
          for (const domain of proxy.domains ?? []) {
            if (dnsDomainIs(host, domain)) {
              return `''${proxy.type} 127.0.0.1:''${proxy.port}; DIRECT`;
            }
          }
          for (const pattern of proxy.patterns ?? []) {
            if (shExpMatch(host, pattern)) {
              return `''${proxy.type} 127.0.0.1:''${proxy.port}; DIRECT`;
            }
          }
        }

        return "DIRECT";
      }
    '';
  };
}
