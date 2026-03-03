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
                        time = "08:30";
                        identity = true;
                    }
                    {
                        time = "18:30";
                        temperature = 4800;
                    }
                ];
            };
        };
    };
}
