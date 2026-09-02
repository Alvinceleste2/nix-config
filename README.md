## Installation Runbook (NixOS)

Create a root password using the TTY

```bash
sudo su
passwd
```

From yout host, copy the public SSH key to the server

```bash
export NIXOS_HOST=192.168.2.xxx
ssh-add ~/.ssh/alvinceleste
ssh-copy-id -i ~/.ssh/alvinceleste root@$NIXOS_HOST
```

SSH into the host with the agent forwarding enabled (for the secrets repo access)

```bash
ssh -A root@$NIXOS_HOST
```

Partition and mount the drives using `disko`

```bash
curl -L <disko_file_url> -o /tmp/disko.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m destroy,format,mount /tmp/disko.nix
```

Install git

```bash
nix-env -f '<nixpkgs>' -iA git
```

Clone this repository

```bash
mkdir -p /mnt/etc/nixos
git clone https://github.com/Alvinceleste2/nix-config.git /mnt/etc/nixos
```

Put the private key into place (required for secret management)

```bash
mkdir -p /mnt/home/alvinceleste/.ssh
exit
scp ~/.ssh/alvinceleste root@$NIXOS_HOST:/mnt/home/alvinceleste/.ssh
ssh -A root@$NIXOS_HOST
chmod 700 /mnt/home/alvinceleste/.ssh
chmod 600 /mnt/home/alvinceleste/.ssh/*
```

Install the system

```bash
nixos-install \
--root "/mnt" \
--no-root-passwd \
--flake "git+file:///mnt/etc/nixos#<hostname>" # laptop, desktop, etc.
```

Might be necessary to create secure boot keys

```bash
nixos-enter --root /mnt -- nix-shell -p sbctl --run "sbctl create-keys"
```

Unmount the filesystems

```bash
umount "/mnt/boot/efis/*"
umount -Rl "/mnt"
```

Reboot

```bash
reboot
```

## Secure Boot Setup

Enable lanzaboote module inside the host config

```nix
imports = [
    self.modules.nixos.lanzaboote
];
```

It can also be done via nix-shell

```bash
sudo nix-shell -p sbctl
```

Generate secure boot keys

```bash
sudo sbctl create-keys
```

Enroll generated keys (optional `--microsoft` and `--firmware-builtin` flags)

```
sudo sbctl enroll-keys <optional_flags>
```

Verify the enrollment

```
sudo sbctl status
```

Enable Secure Boot into the BIOS (also, don't forget to setup a password!)

After rebooting, check

```
bootctl status
```

>[!NOTE]
> *Useful Commands:* `nix-collect-garbage`, `nixos-generate-config`
