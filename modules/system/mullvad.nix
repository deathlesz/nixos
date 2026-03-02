{
    config,
    lib,
    pkgs,
    ...
}: {
    options = {
        hostSettings = {
            mullvad.enable = lib.mkEnableOption "Mullvad VPN";
        };
    };

    config = lib.mkIf config.hostSettings.mullvad.enable {
        services.mullvad-vpn = {
            enable = true;
            enableEarlyBootBlocking = true;
        };
    };
}
