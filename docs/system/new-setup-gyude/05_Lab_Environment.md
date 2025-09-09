
***

# 05 - Lab Environment & Distro-Hopping Guide

## Table of Contents
1.  [Lab Environment Philosophy](#lab-environment-philosophy)
2.  [Safe Exploration Methods](#safe-exploration-methods)
3.  [Virtualization Setup](#virtualization-setup)
4.  [Containerized Environments](#containerized-environments)
5.  [Bare-Metal Testing](#bare-metal-testing)
6.  [Testing Workflow](#testing-workflow)
7.  [Performance Comparison](#performance-comparison)

## Lab Environment Philosophy

Your lab environment should satisfy your tinkering needs while protecting your production systems. Follow these principles:

1.  **Isolation:** Experiments should never risk your main Windows/Fedora installations
2.  **Recoverability:** Ability to quickly reset to a known good state
3.  **Documentation:** Record findings for future reference
4.  **Performance:** Leverage your hardware without compromising stability

## Safe Exploration Methods

### Method Comparison Table

| Method | Safety | Performance | Setup Speed | Best For |
| :--- | :--- | :--- | :--- | :--- |
| **Live USB** | Very High | Low | Fast | Quick testing, recovery |
| **Virtual Machine** | High | Medium | Medium | UI testing, apps |
| **Distrobox** | High | High | Fast | CLI testing, packages |
| **Dual-Boot** | Medium | Full | Slow | Full immersion, gaming |
| **Bare Metal** | Low | Full | Slow | Hardware testing |

## Virtualization Setup

### VirtualBox Configuration
```bash
# Install on Fedora
sudo dnf install VirtualBox akmod-VirtualBox kernel-devel

# Recommended VM settings:
# - Type: Linux
# - Version: Other Linux (64-bit)
# - Memory: 8-16GB (⅓ of system RAM)
# - Video Memory: 128MB
# - Storage: 40GB dynamically allocated
# - Enable 3D Acceleration
```

### QEMU/KVM with Virt-Manager
```bash
# Install on Fedora
sudo dnf install @virtualization virt-manager

# Configure default storage pool
sudo virsh pool-define-as default dir - - - - "/var/lib/libvirt/images"
sudo virsh pool-start default
sudo virsh pool-autostart default

# Add your user to libvirt group
sudo usermod -aG libvirt $USER
```

### GPU Passthrough Setup
For advanced testing with actual GPU performance:
```bash
# Enable IOMMU in BIOS/UEFI
# Add to kernel parameters: intel_iommu=on or amd_iommu=on

# Identify GPU groups
sudo dnf install iommu-tools
sudo vi /etc/default/grub
# Add: GRUB_CMDLINE_LINUX="intel_iommu=on iommu=pt"
sudo update-grub

# Complex setup - consider using pre-built solutions like:
git clone https://github.com/QaidVoid/QuickGPU-VFIO.git
```

## Containerized Environments

### Distrobox for Package Testing
```bash
# Install Distrobox
sudo dnf install distrobox

# Create various distribution environments
distrobox-create --name arch-test --image archlinux:latest
distrobox-create --name debian-test --image debian:latest
distrobox-create --name nix-test --image nixos/nix

# Enter environments
distrobox-enter arch-test

# Export apps to host (appears in your app menu)
distrobox-export --app code --export-path ~/.local/share/applications
```

### Podman for Isolation
```bash
# Podman is already installed on Fedora
podman run -it --rm ubuntu:latest bash
podman run -it --rm alpine:latest sh

# For GUI applications
podman run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  ubuntu:latest

# Create persistent development environment
podman run -it --name dev-env \
  -v $HOME/Projects:/projects \
  -v $HOME/.ssh:/root/.ssh \
  fedora:latest
```

## Bare-Metal Testing

### Dedicated Testing Drive
Your 500GB Samsung 850 EVO is perfect for this:

1.  **Keep Ventoy USB handy** with multiple ISO files
2.  **Partition the drive** with 3-4 test installations (100GB each)
3.  **Use separate /home partitions** or symlink to shared storage

### Installation Script Skeleton
```bash
#!/bin/bash
# install_distro.sh
set -e

DISTRO=${1:-arch}
MOUNT_POINT="/mnt/test"

case $DISTRO in
    "arch")
        pacstrap $MOUNT_POINT base linux linux-firmware
        genfstab -U $MOUNT_POINT >> $MOUNT_POINT/etc/fstab
        ;;
    "debian")
        debootstrap stable $MOUNT_POINT http://deb.debian.org/debian
        ;;
    *)
        echo "Unknown distribution: $DISTRO"
        exit 1
        ;;
esac

# Common setup
echo "test-machine" > $MOUNT_POINT/etc/hostname
echo "127.0.1.1 test-machine" >> $MOUNT_POINT/etc/hosts
```

### Bootloader Management
```bash
# When testing multiple distributions, use Fedora's GRUB as main
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

# Alternatively, use rEFInd for better multi-OS support
sudo dnf install refind
sudo refind-install
```

## Testing Workflow

### New Distribution Evaluation Checklist
Create `evaluation_template.md` in your lab notes:

```markdown
# Distribution Evaluation: [Distribution Name]

## Basic Information
- **Version:** 
- **Install Date:** 
- **Kernel Version:** 
- **Desktop Environment:** 

## Installation Experience
- [ ] Installation process smoothness
- [ ] Hardware detection (WiFi, GPU, etc.)
- [ ] Partitioning flexibility
- [ ] Bootloader configuration

## Hardware Compatibility
- **NVIDIA GPU:** 
- **Ryzen CPU:** 
- **ThinkPad T14s:** 
- **Peripherals:** 

## Performance Metrics
- **Boot Time:** 
- **Memory Usage:** 
- **Disk I/O:** 
- **GPU Acceleration:** 

## Package Management
- **Software Availability:** 
- **Update Stability:** 
- **Rollback Capability:** 

## Daily Driver Potential
- **Stability:** 
- **Documentation:** 
- **Community Support:** 
- **Gaming Performance:** 

## Final Verdict
[Summary and recommendation]
```

### Automated Testing Script
```bash
#!/bin/bash
# test_distro.sh
DISTRO=$1

# Run basic benchmarks
echo "=== CPU Performance ==="
sysbench cpu --cpu-max-prime=20000 run

echo "=== Memory Speed ==="
sysbench memory run

echo "=== Disk I/O ==="
sysbench fileio --file-total-size=1G prepare
sysbench fileio --file-total-size=1G --file-test-mode=rndrw run
sysbench fileio --file-total-size=1G cleanup

# Save results with timestamp
mkdir -p ~/lab-results
sysbench cpu --cpu-max-prime=20000 run > ~/lab-results/${DISTRO}_$(date +%Y-%m-%d).log
```

## Performance Comparison

### Gaming Performance Testing
```bash
# Install common gaming tools across test distributions
./install_gaming_tools.sh

# Test with native games
glxgears
vkcube

# Test with Proton
steam steam://run/730  # CS:GO
steam steam://run/292030  # The Witcher 3

# Benchmark with Phoronix Test Suite
wget https://phoronix-test-suite.com/releases/phoronix-test-suite-10.8.4.tar.gz
tar xvf phoronix-test-suite-10.8.4.tar.gz
cd phoronix-test-suite
./phoronix-test-suite benchmark unigine-valley
```

### Creative Application Testing
```bash
# Test video editing performance
kdenlive --test-performance

# Test GPU acceleration in Blender
blender -b -P ~/scripts/blender_gpu_test.py

# Raw development test
darktable --test-gpu
```

### Kernel Comparison Testing
```bash
# Test different kernels on Fedora
sudo dnf install kernel-mainline kernel-lqx kernel-xanmod

# Boot into different kernels and test performance
uname -r
sysbench cpu --cpu-max-prime=20000 run

# Monitor differences in power consumption
sudo dnf install powertop
sudo powertop --csv=power_usage.csv
```

## Maintenance and Cleanup

### Environment Rotation Script
```bash
#!/bin/bash
# rotate_environments.sh
# Archive old test installations older than 30 days
find /mnt/test -name "*old" -type d -mtime +30 -exec rm -rf {} \;

# Clean container cache
distrobox-list | grep -E 'test-.+' | xargs -I {} distrobox rm {}

# Clean package caches across distributions
for distro in $(ls /mnt/test); do
    arch-chroot /mnt/test/$distro pacman -Scc --noconfirm
    # or apt/dnf clean based on distribution
done
```

### Knowledge Base Maintenance
Keep notes in a structured format:
```bash
# Directory structure for lab notes
~/lab-notes/
├── distributions/
│   ├── arch/
│   ├── debian/
│   └── nixos/
├── hardware/
│   ├── nvidia/
│   ├── amd/
│   └── thinkpad/
└── experiments/
    ├── gaming/
    ├── creative/
    └── kernel/
```

This lab environment setup allows you to safely satisfy your distro-hopping urges while maintaining your productive workflow. The next guide will cover network sharing and media distribution.

## Repository Structure
| File      | Description   |
|-----------|---------------|
| README.md | [Overview and hardware summary](README.md)
| 01_OS_Setup.md | [Dual-boot configuration guide](01_OS_Setup.md)
| 02_Storage_Strategy.md | [Storage layout and management](02_Storage_Strategy.md)
| 03_Software_Configuration.md | [Creative software setup](03_Software_Configuration.md)
| 04_Workflow_Management.md | [Cross-platform workflow implementation](04_Workflow_Management.md)
| 05_Lab_Environment.md | [Distro-hopping and experimentation setup](05_Lab_Environment.md)
| 06_Network_Sharing.md | [Media sharing and network configuration](06_Network_Sharing.md)
