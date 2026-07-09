{
    config,
    lib,
    pkgs,
    osConfig,
    ...
}: let
    cfg = config.userSettings.styling.cursor;
in {
    options = {
        userSettings = {
            styling.cursor = {
                name = lib.mkOption {
                    type = lib.types.str;
                    description = "Cursor theme to use";
                    default =
                        if (config.stylix.polarity == "light")
                        then "Quintom_Ink"
                        else "Quintom_Snow";
                };
                package = lib.mkPackageOption pkgs "cursor" {
                    default = ["quintom-cursor-theme"];
                };
                size = lib.mkOption {
                    type = lib.types.int;
                    description = "Cursor size to use";
                    default = 24;
                };
            };
        };
    };

    config = lib.mkIf osConfig.hostSettings.styling.enable {
        home.pointerCursor = {
            enable = true;

            name = cfg.name;
            # set by Stylix
            # package = cfg.package
            size = cfg.size;

            gtk = {
                enable = true;
            };
            hyprcursor = {
                enable = lib.mkIf osConfig.hostSettings.desktop.hyprland.enable true;
            };
            x11 = {
                enable = true;
            };
        };
    };
}
