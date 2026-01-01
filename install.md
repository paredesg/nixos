## Install Nix os on VM virtualbox

0 sudo -i
1 sudo loadkeys fr
2 passwd (definir password root user)

lsblk

cfdisk /dev/sda
    gpt
    new 1G  type    EFI Sytem
    new 4G  type    Linux Swap
    new "le reste"  type    Linux file system

    write   yes
    quit

lsblk pour check

mkfs.ext4 -L nixos /dev/sda3
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda1


## install NIXOS

mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2

## install flake et home manager
cd /mnt/etc/nixos

git clone https://github.com/paredesg/nixos.git

nixos-install --flake /mnt/etc/nixos#nixos-vm
nixos-enter --root /mnt -c 'passwd eve'
reboot

