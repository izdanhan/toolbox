# 04 - Workflow Management Guide

## Table of Contents
1.  [Cross-Platform Workflow Philosophy](#cross-platform-workflow-philosophy)
2.  [Project Lifecycle Management](#project-lifecycle-management)
3.  [Media Ingestion Process](#media-ingestion-process)
4.  [Creative Application Workflows](#creative-application-workflows)
5.  [Version Control & Project Tracking](#version-control--project-tracking)
6.  [Maintenance Routines](#maintenance-routines)

## Cross-Platform Workflow Philosophy

Your workflow should be OS-agnostic. The operating system becomes merely a tool to access your projects, not a determinant of how you work. This is achieved through:

1.  **Consistent Folder Structure** (as established in Storage Guide)
2.  **Cloud-Synced Configuration Files** for applications that support it
3.  **Standardized Naming Conventions** across all projects
4.  **Regular Sync Procedures** between active and archive storage

## Project Lifecycle Management

### Phase 1: Pre-Production
```bash
# Project initialization template
PROJECT_ROOT="MediaProjects/Project_$(date +%Y-%m-%d)_ProjectName/"
mkdir -p "$PROJECT_ROOT"/{01_Footage,02_Audio,03_Assets,04_ProjectFiles,05_Exports,06_Cache}
```

### Phase 2: Active Production (On Fast NVMe)
1.  **Location:** `C:\MediaProjects\` (Windows) or `~/MediaProjects/` (Linux)
2.  **Workflow:** All active editing happens here
3.  **Applications:** DaVinci Resolve (Win), Kdenlive (Linux), Affinity Suite (Win)

### Phase 3: Archiving (Move to HDD)
1.  **Trigger:** Project completed or inactive for >30 days
2.  **Action:** Move entire project folder to `E:\MediaProjects\` or `/mnt/archive/MediaProjects/`
3.  **Verification:** Use checksum verification before deleting from NVMe

### Phase 4: Backup (Mirror to Second HDD)
1.  **Frequency:** After each archiving operation
2.  **Tool:** FreeFileSync (Windows) or rsync (Linux)
3.  **Command:** `rsync -avh --delete /mnt/archive/ /mnt/backup/`

## Media Ingestion Process

### Photo Import with digiKam
```bash
# Recommended digiKam import settings:
# - Destination: PROJECT_ROOT/01_Photos/YYYY/MM-MMDD/
# - Renaming: {Date}-{Time}-{OriginalName}.{Ext}
# - Metadata: Add copyright and basic tags
# - Verification: Enable "Check after download"
```

### Video Import (Manual Method)
```bash
# Create today's folder structure
INGEST_DIR="01_Footage/$(date +%Y-%m-%d)/"
mkdir -p "$INGEST_DIR"

# Copy with verification (Linux example)
rsync -avh --progress /media/card/DCIM/100CANON/ "$INGEST_DIR"

# Windows alternative: use Teracopy with verification enabled
```

### File Naming Convention
```
YYYY-MM-DD_ProjectName_SequenceNumber.FileExtension
2024-09-10_ProductReview_001.MP4
2024-09-10_ProductReview_001.CR3
```

## Creative Application Workflows

### DaVinci Resolve (Windows)
1.  **Project Setup:**
    - Set project settings to match your footage
    - Enable "Use optimized media" if working with h.265
    - Set cache location to `D:\Resolve_Cache\`

2.  **Editing Process:**
    - Create timeline with correct resolution and frame rate
    - Use proxy mode for 4K footage on slower systems
    - Utilize color management for consistent results

3.  **Export Settings:**
    - YouTube 4K: H.265, 50Mbps, AAC audio
    - Archive: DNxHR or ProRes for maximum quality

### Kdenlive (Linux)
```bash
# Recommended settings:
# - Proxy mode: Enable for 4K projects
# - Auto-save: 5 minute interval
# - Default duration: Set to 5 seconds for images
# - Cache: Set to /mnt/scratch/Kdenlive_cache/
```

### Affinity Photo (Windows)
1.  **Develop Persona:** Raw development and lens corrections
2.  **Photo Persona:** Main editing workspace
3.  **Export Persona:** Batch exporting with presets

### Cross-Platform Asset Management
```bash
# Sync frequently used assets between systems
rsync -avh /mnt/archive/SharedAssets/ /home/user/MediaProjects/SharedAssets/
# Or use cloud storage (Nextcloud/Dropbox) for small assets
```

## Version Control & Project Tracking

### Git for Project Management
```bash
# Initialize git in project root (ignores media files)
echo "# Project: $(basename $(pwd))" > README.md
cat > .gitignore << EOL
# Ignore media files
01_Footage/
02_Audio/
03_Assets/raw/
05_Exports/
06_Cache/

# Application files
*.kdenlive~
*.preview/
EOL

git init
git add .
git commit -m "Initial project structure"
```

### Project Metadata File
Create `project_meta.json` in each project root:
```json
{
  "project_name": "YouTubeIntro",
  "created_date": "2024-09-10",
  "status": "active",
  "description": "Introduction video for new series",
  "deadline": "2024-09-25",
  "tags": ["intro", "4k", "color_graded"],
  "applications": ["DaVinci_Resolve", "Affinity_Photo"]
}
```

## Maintenance Routines

### Daily Checklist
1.  **Backup Current Projects:** `rsync -avh ~/MediaProjects/ /mnt/archive/MediaProjects/ --delete`
2.  **Clear Cache:** Delete contents of `D:\` or `/mnt/scratch/` (keep last 7 days)
3.  **Update Software:** Run system updates on both OSes

### Weekly Tasks
1.  **Full Backup Verification:** `rsync -n -avh /mnt/archive/ /mnt/backup/`
2.  **Storage Analysis:** `ncdu /mnt/archive` or WinDirStat on Windows
3.  **Project Archive:** Move completed projects from NVMe to HDD

### Monthly Maintenance
1.  **Filesystem Check:** `sudo btrfs scrub start /` (if using btrfs)
2.  **Application Updates:** Update all Flatpaks and external applications
3.  **Review Workflow:** Adjust processes based on pain points

## Automated Scripts

### Project Archiver Script
```bash
#!/bin/bash
# archive_project.sh
PROJECT=$1
ARCHIVE_DIR="/mnt/archive/MediaProjects"
ACTIVE_DIR="$HOME/MediaProjects"

if [ -z "$PROJECT" ]; then
    echo "Usage: archive_project.sh <project_name>"
    exit 1
fi

if [ -d "$ACTIVE_DIR/$PROJECT" ]; then
    # Verify checksums before move
    echo "Verifying project integrity..."
    rsync -n -avh --checksum "$ACTIVE_DIR/$PROJECT/" "$ARCHIVE_DIR/$PROJECT/"
    
    read -p "Proceed with archiving? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        mv "$ACTIVE_DIR/$PROJECT" "$ARCHIVE_DIR/"
        echo "Project $PROJECT archived successfully."
    fi
else
    echo "Project not found in active directory."
fi
```

### Sync Script for External Drive
```bash
#!/bin/bash
# sync_to_t7.sh
PROJECT=$1
T7_MOUNT="/media/$USER/T7"

if [ -z "$PROJECT" ]; then
    echo "Syncing all active projects..."
    rsync -avh --delete ~/MediaProjects/ "$T7_MOUNT/MediaProjects/"
else
    echo "Syncing project $PROJECT..."
    rsync -avh --delete ~/MediaProjects/"$PROJECT" "$T7_MOUNT/MediaProjects/"
fi
```

## Troubleshooting Common Issues

### File Permission Issues (Linux)
```bash
# Fix NTFS permissions after Windows modification
sudo chown -R $USER:$USER /mnt/archive/
sudo chmod -R u=rwX,g=rwX,o= /mnt/archive/
```

### Project File Compatibility
1.  **DaVinci Resolve:** Use DRP for full compatibility, but note Linux/Win differences
2.  **Kdenlive:** Project files are generally cross-platform
3.  **Affinity:** No Linux version; use Windows for these projects

### Performance Optimization
```bash
# Linux: Enable GPU acceleration where available
sudo dnf install nvidia-cuda-toolkit

# Windows: Ensure Studio drivers are installed
# and power mode set to "Best Performance"
```

This workflow management system ensures that your creative process remains organized and efficient, regardless of which operating system you're using. The next guide will cover your lab environment for distro hopping and experimentation.
