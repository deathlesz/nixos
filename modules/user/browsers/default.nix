{
    config,
    lib,
    ...
}: let
    cfg = config.userSettings.browsers;

    browsers = [
        "firefox"
    ];
    desktopPath =
        if (cfg.defaultBrowser != "none")
        then cfg.${cfg.defaultBrowser}.desktopPath
        else null;
in {
    options = {
        userSettings = {
            browsers.defaultBrowser = lib.mkOption {
                description = "Default browser to use";
                type = lib.types.enum (["none"] ++ browsers);
                default = "none";
            };
        };
    };

    config = lib.mkIf (cfg.defaultBrowser != "none") {
        userSettings.browsers.${cfg.defaultBrowser}.enable = true;

        # may be null even if defaultBrowser is not null
        xdg.mimeApps.defaultApplications = lib.mkIf (desktopPath != null) {
            "x-scheme-handler/http" = desktopPath;
            "x-scheme-handler/https" = desktopPath;
            "text/html" = desktopPath;
            "application/pdf" = desktopPath;
        };

        home.sessionVariables = {
            BROWSER = "${cfg.defaultBrowser}";
        };
    };
}
