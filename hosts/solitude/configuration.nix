{...}: {
    config = {
        hostSettings = {
            kernel = {
                cachy = {
                    enable = true;
                    variant = "lto";
                    arch = "x86_64-v3";
                };
            };

            users = [
                {
                    name = "deathlesz";
                    isAdmin = true;
                }
            ];

            security.sudo-rs.enable = true;

            hardware = {
                graphics = {
                    nvidia.enable = true;
                    amd.enable = true;
                };

                bluetooth.enable = true;

                laptop.enable = true;
            };

            audio.enable = true;

            sddm.enable = true;
            desktop.hyprland.enable = true;

            virtualization = {
                libvirt.enable = true;
                docker.enable = true;
            };

            mullvad.enable = true;

            gaming.enable = true;

            iriun.enable = true;

            styling = {
                enable = true;

                theme = "catppuccin-mocha";

                plymouth = {
                    enable = false;
                    theme = "arasaka";
                };

                grub.theme = "cybergrub-2077";
            };
        };

        hardware.nvidia.prime = {
            nvidiaBusId = "PCI:1:0:0";
            amdgpuBusId = "PCI:6:0:0";
        };

        services = {
            # HACK: permanently symlink nVidia/AMD GPUs to specific paths so they can be used in `AQ_DRM_DEVICES`
            udev.extraRules = ''
                KERNEL=="card*", KERNELS=="0000:01:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-dgpu"
                KERNEL=="card*", KERNELS=="0000:06:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/amd-igpu"
            '';

            supergfxd.enable = true;
            asusd.enable = true;

            minidlna = {
                enable = true;
                openFirewall = true;
                settings = {
                    media_dir = ["V,/media/videos"];
                    inotify = "yes";
                };
            };
        };

        networking.extraHosts = ''
            136.119.69.230 control-plane-0
            34.27.99.68 worker-0
            104.197.71.185 worker-1
        '';

        system.stateVersion = "25.05";
    };
}
