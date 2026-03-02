{
    config,
    lib,
    ...
}: let
    cfg = config.hostSettings.hardware.graphics;
in {
    config = lib.mkIf (cfg.nvidia.enable || cfg.amd.enable || cfg.virtio.enable) {
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
}
