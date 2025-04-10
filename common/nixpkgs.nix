{
  outputs,
  inputs,
  lib,
  config,
  ...
}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.stable-packages

      # Adds hyprpanel package
      inputs.hyprpanel.overlay

      # Adds NUR overlay
      inputs.nur.overlays.default

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = false;

      # Exceptions
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) (
          [
            "steam"
            "steam-original"
            "steam-run"
            "steam-unwrapped"

            "spotify"

            "nvidia-x11"
            "nvidia-settings"

            # Nvidia CUDA
            "cuda_cudart"
            "cuda_cccl"
            "libnpp"
            "libcublas"
            "libcufft"
            "cuda_nvcc"
            "cuda-merged"
            "cuda_cuobjdump"
            "cuda_gdb"
            "cuda_nvdisasm"
            "cuda_nvprune"
            "cuda_cupti"
            "cuda_cuxxfilt"
            "cuda_nvml_dev"
            "cuda_nvrtc"
            "cuda_nvtx"
            "cuda_profiler_api"
            "cuda_sanitizer_api"
            "libcurand"
            "libcusolver"
            "libnvjitlink"
            "libcusparse"
            "cudnn"

            "obsidian"
          ]
          ++ config.allowedUnfree
          ++ config.home-manager.users."${config.var.username}".allowedUnfree
        );
    };
  };
}
