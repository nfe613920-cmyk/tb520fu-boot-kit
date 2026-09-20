# Lenovo TB520FU Boot Kit & Arch Linux ARM Deployment

This repository provides the standalone ARM64 GRUB 2.14 EFI binary build system, the diagnostic/switch-root initramfs, and deployment scripts for running **Arch Linux ARM** natively on the **Lenovo YOGA Pad Pro 12.7 AI (TB520FU / SM8650)**.

---

## 🧭 Boot Sequence Architecture

```text
[Power On] 
   └──> [EDK2 / mu_aloha_platforms (uefi.img)]
           └──> [Standalone GRUB 2.14 (BOOTAA64.EFI)]
                   └──> [Mainline Linux Kernel (Image + DTB)]
                           └──> [Built-in Initramfs (/init)]
                                   ├──> [Auto switch_root to /dev/sda16 (Arch Linux ARM)]
                                   └──> [Fallback: USB Serial Shell (/dev/ttyGS0)]
```

---

## 🗂️ EFI System Partition Layout

Place these files on your USB OTG FAT32 drive or internal ESP partition:

```text
/EFI/BOOT/
├── BOOTAA64.EFI                # Standalone ARM64 GRUB 2.14 binary
├── Image                       # Mainline Linux v7.2.6 ARM64 EFI kernel
└── sm8650-lenovo-tb520fu.dtb   # TB520FU Device Tree Blob
```

---

## 🔑 Default Credentials

- User: `alarm` / Password: `alarm`
- User: `root` / Password: `root`
