{ ... }: {
  # FIXME: Signal Error on Screen-Share
  # [92634:1101/172956.306400:ERROR:egl_dmabuf.cc(327)] Unable to load EGL entry functions.
  # [92634:1101/172956.324522:ERROR:shared_screencast_stream.cc(215)] PipeWire stream state error: no more input formats
  # [92634:1101/172956.324543:ERROR:shared_screencast_stream.cc(178)] PipeWire remote error: no more input formats
  # [92634:1101/172956.342309:ERROR:shared_screencast_stream.cc(215)] PipeWire stream state error: no more input formats
  # [92634:1101/172956.342326:ERROR:shared_screencast_stream.cc(178)] PipeWire remote error: no more input formats

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
