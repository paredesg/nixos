1. modif keyboard

sudo loadkeys fr

2. modif password nisos and root users


3. load disko module 
curl -L https://gist.githubusercontent.com/paredesg/0ccaf5386e7bb667474e2d5095f8a553/raw/de23423d81d59bc87892491907bd8bb24286cf5c/disko-config.nix -o /tmp/disko-config.nix

4. execute module with disko config 
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko-config.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --yes-wipe-all-disks /tmp/disko-config.nix

5. generate nix config file
nixos-generate-config --no-filesystems --root /mnt
nixos-generate-config --root /mnt


6. copy configuration file
cp /tmp/disko-config.nix /mnt/etc/nixos
cp /root/authorized_keys /etc/nixos
cp /root/configuration.nix /mnt/etc/nixos 


7. install
nixos-install


8. rebuild
nixos-rebuild switch