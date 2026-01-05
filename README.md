## Install NixOs on VM virtualbox
0 sudo -i
1 loadkeys fr
2 passwd  (definir password root user)
3 ip a (verif IP)

lsblk

cfdisk /dev/sda :
-gpt
-new 1G  type    EFI Sytem
-new 4G  type    Linux Swap
-new "le reste"  type    Linux file system
-write   yes
-quit

lsblk pour check

sda:
mkfs.ext4 -L nixos /dev/sda3
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda1

nvme:
mkfs.ext4 -L nixos /dev/nvme0n1p3
mkswap -L swap /dev/nvme0n1p2
mkfs.fat -F 32 -n boot /dev/nvme0n1p1

## install NIXOS
sda:
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2

nvme:
mount /dev/nvme0n1p3 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
swapon /dev/nvme0n1p2


nixos-generate-config --root /mnt

## install flake and home manager
cd /mnt/etc/nixos

git clone https://github.com/paredesg/nixos.git

nixos-install --flake /mnt/etc/nixos#nixos-vm

nixos-enter --root /mnt -c 'passwd eve'
reboot

