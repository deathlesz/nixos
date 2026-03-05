{...}: {
    imports = [
        ./home.nix
        ./git.nix
        ./mullvad.nix

        ./browsers
        ./desktop
        ./editors
        ./misc
    ];
}
