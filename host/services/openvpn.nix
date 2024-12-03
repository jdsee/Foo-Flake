{ ... }: {
  services.openvpn.servers = {
    iq-sirius_20240610 = {
      config = ''config /root/nixos/openvpn/iq-sirius_20240610.ovpn'';
    };
  };
}
