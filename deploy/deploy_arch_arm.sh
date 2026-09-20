#!/bin/sh
# Arch Linux ARM Bare-Metal Deployment Script for TB520FU
# Run this inside the diagnostic initramfs shell

set -eu

ROOT_DEV="${1:-/dev/sda16}"
TARBALL="${2:-/mnt/ArchLinuxARM-aarch64-latest.tar.gz}"

echo "=== 1. Formatting rootfs on ${ROOT_DEV} ==="
mkfs.ext4 -F -L "arch_rootfs" "${ROOT_DEV}"

mkdir -p /mnt/arch
mount -t ext4 "${ROOT_DEV}" /mnt/arch

echo "=== 2. Extracting Arch Linux ARM rootfs ==="
tar -xpf "${TARBALL}" -C /mnt/arch

echo "=== 3. Configuring Hostname, Fstab, and Getty ==="
echo "tb520fu-arch" > /mnt/arch/etc/hostname
echo "nameserver 1.1.1.1" > /mnt/arch/etc/resolv.conf

# Enable serial and display console getty
mkdir -p /mnt/arch/etc/systemd/system/getty.target.wants
ln -sf /usr/lib/systemd/system/serial-getty@.service /mnt/arch/etc/systemd/system/getty.target.wants/serial-getty@ttyGS0.service
ln -sf /usr/lib/systemd/system/getty@.service /mnt/arch/etc/systemd/system/getty.target.wants/getty@tty0.service

ROOT_UUID=$(blkid -s UUID -o value "${ROOT_DEV}")
cat << EOF > /mnt/arch/etc/fstab
UUID=${ROOT_UUID}  /  ext4  rw,relatime,errors=remount-ro  0  1
EOF

sync
umount /mnt/arch
echo "=== Deployment Complete! ==="
