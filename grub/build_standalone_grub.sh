#!/bin/bash
set -euo pipefail

GRUB_DIR="${1:-build/grub-2.14-arm64-efi}"
OUTPUT_EFI="${2:-BOOTAA64.EFI}"
GRUB_CFG="${3:-grub/grub.cfg}"

"${GRUB_DIR}/grub-mkstandalone" \
    --directory="${GRUB_DIR}/grub-core" \
    --format=arm64-efi \
    --output="${OUTPUT_EFI}" \
    "boot/grub/grub.cfg=${GRUB_CFG}"

echo "Standalone ARM64 GRUB binary built: ${OUTPUT_EFI}"
