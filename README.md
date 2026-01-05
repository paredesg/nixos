## Install NixOs on VM virtualbox
0 sudo -i </br>
1 loadkeys fr </br>
2 passwd  (definir password root user) </br>
3 ip a (verif IP) </br>

lsblk

cfdisk /dev/sda : </br>
gpt </br>
new 1G  type    EFI Sytem </br>
new 4G  type    Linux Swap </br>
new "le reste"  type    Linux file system </br>
write   yes </br>
quit </br>

lsblk pour check </br>

sda: </br>

mkfs.ext4 -L nixos /dev/sda3 </br>
mkswap -L swap /dev/sda2 </br>
mkfs.fat -F 32 -n boot /dev/sda1 </br>

nvme: </br>

mkfs.ext4 -L nixos /dev/nvme0n1p3 </br>
mkswap -L swap /dev/nvme0n1p2 </br>
mkfs.fat -F 32 -n boot /dev/nvme0n1p1 </br>

## install NIXOS

sda: </br>

mount /dev/sda3 /mnt </br>
mount --mkdir /dev/sda1 /mnt/boot </br>
swapon /dev/sda2 </br>

nvme: </br>

mount /dev/nvme0n1p3 /mnt </br>
mount --mkdir /dev/nvme0n1p1 /mnt/boot </br>
swapon /dev/nvme0n1p2 </br>

nixos-generate-config --root /mnt </br>

## install flake and home manager
cd /mnt/etc/nixos </br>

git clone https://github.com/paredesg/nixos.git </br>

nixos-install --flake /mnt/etc/nixos#nixos-vm </br>

nixos-enter --root /mnt -c 'passwd eve' </br>
reboot </br>

