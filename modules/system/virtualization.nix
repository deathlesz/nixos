{
    config,
    lib,
    pkgs,
    ...
}: {
    options = {
        hostSettings = {
            virtualization = {
                docker.enable = lib.mkEnableOption "Docker support";
                libvirt.enable = lib.mkEnableOption "libvirt support";
            };
        };
    };

    config = lib.mkMerge [
        lib.mkif
        config.hostSettings.virtualization.libvirt.enable
        {
            virtualisation.libvirtd = {
                enable = true;

                qemu.package = pkgs.qemu_kvm;
            };

            programs.virt-manager.enable = true;
        }
        lib.mkIf
        config.hostSettings.virtualization.docker.enable
        {
            virtualisation.docker.enable = true;
        }
    ];
}
