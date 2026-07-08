{
    osConfig,
    lib,
    ...
}: {
    config = lib.mkIf osConfig.hostSettings.desktop.hyprland.enable {
        services.hyprsunset = {
            enable = true;
            settings = {
                profile = [
                    {
                        time = "05:00";
                        identity = true;
                    }
                    {
                        time = "23:00";
                        temperature = 4800;
                    }
                ];
            };
        };
    };
}
