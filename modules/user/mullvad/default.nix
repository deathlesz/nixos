{
    osConfig,
    lib,
    pkgs,
    ...
}: {
    config = lib.mkIf osConfig.hostSettings.mullvad.enable {
        programs.mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
            settings = {
                autoConnect = true;
                startMinimized = true;
            };
        };
    };
}
