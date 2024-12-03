{ ... }: {
  services.kanata = {
    enable = true;
    keyboards.default = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc)

        (defalias
          esctl (multi f24 (tap-hold-press 150 150 esc lctl)))

        (deflayermap (base-layer)
          lctl @esctl
          caps @esctl)
      '';
    };
  };
}
