
***

# Creative Workstation Setup Guide

## Overview
This repository documents the optimized configuration for a high-end creative workstation supporting video/photo editing, gaming, and Linux tinkering. The setup leverages multiple operating systems and specialized storage configurations to create a seamless workflow across Windows and Linux environments.

Continue to [Deep-Roleplay Principles: Kaelen Vesper](deep_roleplay.md)

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

## Hardware Specification 
| Component | Specification |
|-----------|---------------|
| **Desktop CPU** | AMD Ryzen 9 5900X |
| **Desktop GPU** | NVIDIA RTX 3080 10GB |
| **Desktop RAM** | 32GB |
| **Primary SSD** | 2TB Samsung 990 Pro NVMe |
| **Secondary SSD** | 1TB Samsung 980 NVMe |
| **Tertiary SSD** | 500GB Samsung 850 EVO SATA |
| **Storage HDDs** | 2x 2TB HDD |
| **External SSD** | 2TB Samsung T7 USB-C |
| **Laptop** | ThinkPad T14s Gen 4 (Ryzen 7 7840U, 32GB RAM, 2TB SSD) |
| **Displays** | 24" 144Hz main, 24" 60Hz secondary, Kamvas 16 pen display, Samsung Q70A 65" TV |

## Core Principles
1.  **Performance Tiering**: Fast NVMe for OS/active projects, HDDs for bulk storage
2.  **Cross-Platform Compatibility**: Consistent workflow between Windows and Linux
3.  **Experimentation Isolation**: Dedicated drive for distro-hopping without affecting production systems
4.  **Automated Backup**: Mirroring strategy for important data 

## Recommended Setup
1.  **Windows 11** on 2TB 990 Pro: Primary OS for gaming, DaVinci Resolve, and Affinity Suite
2.  **Fedora Linux** on 1TB 980: Daily driver for development and open-source creative tools
3.  **Lab OS** on 500GB 850 EVO: Experimental distros using Distrobox 
4.  **Media Storage**: 2x2TB HDDs in mergerFS pool for media files and project archives 

## Key Features
- **Cross-Platform Project Structure**: Unified directory hierarchy accessible from all OSes
- **GPU Optimization**: Configured for both creative workloads and gaming
- **Distro-Hopping Made Safe**: Containerized and virtualized experimentation 
- **Media Sharing**: Network share setup for movies/TV series across devices 

## Usage Guide
Each markdown file provides detailed instructions for specific aspects of the setup:
1.  Start with **01_OS_Setup.md** for partition planning and OS installation
2.  Configure storage according to **02_Storage_Strategy.md**
3.  Install and optimize software using **03_Software_Configuration.md**
4.  Establish efficient workflows with **04_Workflow_Management.md**
5.  Set up experimentation environment with **05_Lab_Environment.md**
6.  Configure network sharing following **06_Network_Sharing.md**

This setup creates a powerful, flexible workstation that balances production needs with experimentation freedom, leveraging your high-end hardware while maintaining organizational efficiency.
