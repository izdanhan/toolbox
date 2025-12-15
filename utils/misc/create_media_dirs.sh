#!/bin/bash

# Root media directory
ROOT_DIR="/mnt/polaris/Media"

# Define directories and their README content
declare -A DIRS

# Photos
DIRS["$ROOT_DIR/Photos/RAW"]="Original RAW photo files imported from camera."
DIRS["$ROOT_DIR/Photos/Edited"]="Post-processed images (edited with digiKam or Krita)."
DIRS["$ROOT_DIR/Photos/Exported"]="Exported images for sharing, web, or printing."
DIRS["$ROOT_DIR/Photos/Backup"]="Backup copies of original RAW photos."

# Videos
DIRS["$ROOT_DIR/Videos/RAW"]="Original video files from camera or other sources."
DIRS["$ROOT_DIR/Videos/Projects"]="Kdenlive project files (.kdenlive) for editing."
DIRS["$ROOT_DIR/Videos/Rendered"]="Final exported/rendered videos."
DIRS["$ROOT_DIR/Videos/Assets"]="Video assets like B-roll, stock footage, or music."

# Screen Captures
DIRS["$ROOT_DIR/ScreenCaptures/RAW"]="Unprocessed screen recordings captured with OBS or other software."
DIRS["$ROOT_DIR/ScreenCaptures/Clips"]="Short clips ready for editing or highlights."
DIRS["$ROOT_DIR/ScreenCaptures/Projects"]="Screen capture project files."
DIRS["$ROOT_DIR/ScreenCaptures/Exported"]="Rendered/finalized clips for sharing."

# Projects
DIRS["$ROOT_DIR/Projects/Blender/Scenes"]="Blender .blend project files."
DIRS["$ROOT_DIR/Projects/Blender/Renders"]="Rendered output from Blender projects."
DIRS["$ROOT_DIR/Projects/Blender/Assets"]="Textures, models, HDRIs, and other Blender assets."

DIRS["$ROOT_DIR/Projects/Krita/Originals"]="Original Krita project files (.kra)."
DIRS["$ROOT_DIR/Projects/Krita/Exports"]="Exported images from Krita projects."
DIRS["$ROOT_DIR/Projects/Krita/Assets"]="Brushes, textures, patterns for Krita."

DIRS["$ROOT_DIR/Projects/Kdenlive/ProjectFiles"]="Kdenlive project files (.kdenlive)."

DIRS["$ROOT_DIR/Projects/Other"]="Miscellaneous creative projects."

# Assets
DIRS["$ROOT_DIR/Assets/Textures"]="General-purpose textures usable across software."
DIRS["$ROOT_DIR/Assets/Brushes"]="Brushes for Krita or other painting software."
DIRS["$ROOT_DIR/Assets/Fonts"]="Font files for design work."
DIRS["$ROOT_DIR/Assets/Music"]="Music tracks for videos or projects."
DIRS["$ROOT_DIR/Assets/Overlays"]="Overlays and visual effects assets."
DIRS["$ROOT_DIR/Assets/Stock"]="Stock footage, images, or templates."

# Create directories and README.md
for DIR in "${!DIRS[@]}"; do
    mkdir -p "$DIR"
    README="$DIR/README.md"
    echo -e "# $(basename "$DIR")\n\n${DIRS[$DIR]}" > "$README"
done

echo "Directory structure created under $ROOT_DIR with README.md files."

