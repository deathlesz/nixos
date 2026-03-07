{
    config,
    lib,
    ...
}: let
    cfg = config.userSettings.browsers;

    imports = lib.attrNames (lib.filterAttrs (name: value: (value != "directory") && (name != "default.nix")) (builtins.readDir ./.));
    browsers = map (lib.removeSuffix ".nix") imports;

    path =
        if (cfg.defaultBrowser != "none")
        then cfg.${cfg.defaultBrowser}.path
        else null;
in {
    inherit imports;

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

        # may be null even if defaultBrowser is not null, so we check
        xdg.mimeApps.defaultApplications = lib.mkIf (path != null) {
            "x-scheme-handler/http" = path;
            "x-scheme-handler/https" = path;
            "text/html" = path;
            "application/pdf" = path;
        };

        home.sessionVariables = {
            BROWSER = "${cfg.defaultBrowser}";
        };
    };
}
