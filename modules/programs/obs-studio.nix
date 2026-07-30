{ self, inputs, ... }: {

    flake.nixosModules.OBS = { pkgs, lib, ... }: {
        nixpkgs.config.allowUnfree = true;
        programs.obs-studio.enable = true;

        environment.systemPackages = with pkgs; [
            (pkgs.wrapOBS {
                plugins = with pkgs.obs-studio-plugins; [
                    obs-3d-effect
                    obs-advanced-masks
                    obs-backgroundremoval
                    obs-command-source
                    obs-composite-blur
                    obs-dir-watch-media
                    obs-dvd-screensaver
                    obs-freeze-filter
                    obs-gradient-source
                    obs-gstreamer
                    input-overlay
                    obs-move-transition
                    obs-mute-filter
                    obs-pipewire-audio-capture
                    obs-plugin-countdown
                    obs-recursion-effect
                    obs-replay-source
                    obs-retro-effects
                    obs-scale-to-sound
                    obs-shaderfilter
                    obs-source-clone
                    obs-source-record
                    obs-source-switcher
                    obs-stroke-glow-shadow
                    obs-tuna
                    obs-vaapi
                    obs-vertical-canvas
                    obs-vintage-filter
                    obs-vkcapture
                    obs-vnc
                    waveform
                    wlrobs
                ];
            })
        ];
    };
}
