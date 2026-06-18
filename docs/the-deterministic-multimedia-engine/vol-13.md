# THE FILESYSTEM MANIFESTO

## Volume XIII: Deterministic Directory Architecture and Cross-Platform Asset Lifecycle

### Standard Operating Procedures for Logical Storage Governance and Metadata Sovereignty

---

### PREFACE: STRUCTURAL DISCIPLINE

Filesystem chaos is the primary bottleneck of high-throughput multimedia production. Searching for assets, dealing with fragmented naming conventions, or mixing uncompressed source files with throwaway render caches causes major operational friction.

This volume provides the definitive layout blueprints for your storage systems. It organizes your files into a logical, predictable directory structure that scales seamlessly across **Fedora KDE Linux** and **Windows 11**. It ensures that every asset type—from raw code to 10-bit cinema files—has a single, uncompromised home.

---

## CHAPTER 1: THE ROOT TOPOLOGY OVERVIEW

Your complete digital environment maps into a unified root directory structure. It isolates static global assets, active production files, and historical archives into distinct, independent branches.

```text
Media/
├── Assets/                 [Static Global Master Repositories]
├── Coding/                 [Software Repositories & Execution Blocks]
├── Photos/                 [Still Image Acquisition & Mastering]
├── Videos/                 [Motion Picture Acquisition & Mastering]
├── Tutorials/              [Educational Ingestion & Reference Stacks]
└── Gaming/                 [Interactive Environments & Capture Stacks]

```

---

## CHAPTER 2: DEEP FIELD ANATOMY (DIRECTORY BY DIRECTORY)

### 2.1 The `Assets/` Repository (Global Master Ingredients)

The `Assets/` directory stores read-only, reusable project assets. These files are never edited directly; they are referenced by external applications like Affinity, Kdenlive, or DaVinci Resolve.

```text
Media/Assets/
├── Brushes/                [Custom Krita, GIMP, and Affinity digital brush packs]
├── Fonts/                  [TrueType/OpenType files for typography and video titles]
├── Music/                  [Licensed soundbeds and background tracks for video edits]
├── Overlays/               [Alpha-channel transparent PNGs, transition templates, and logos]
├── Stock/                  [Third-party b-roll footage and high-res background plates]
└── Textures/               [High-fidelity surface maps for Blender and 3D rendering]

```

* **Operational Rules:** Keep this directory backed up across your primary devices. If you download a new font or audio clip for a project, store it here first before linking it to your timeline.

### 2.2 The `Coding/` Repository (Deterministic Logic)

This directory isolates your programming environments, version-controlled scripts, and code exercises from your high-volume media files.

```text
Media/Coding/
└── mooc-26/                [Structured University Programming Repository]
    └── mooc-ohjelmointi-2026/
        ├── course_config.toml
        └── osa01-01_hymio/
            ├── src/
            │   └── hymio.py
            └── test/

```

* **Operational Rules:** Keep this directory lightweight and clean. Do not store large media blocks or video assets here. Rely entirely on git version control systems to track changes to your scripts.

### 2.3 The `Photos/` Repository (Still Image Pipeline)

This directory structure handles everything from raw, uncompressed sensor data straight from your camera to final, web-optimized master files.

```text
Media/Photos/
└── [YYYY-MM_Project_Name_Location]/
    ├── RAW/                [Camera Native .CR3 files - Protected Data Layer]
    └── Masters/            [Final 16-bit TIFF or sRGB JPEG distribution files]

```

* **Operational Rules:** Organize folders strictly using the `YYYY-MM_Short-Description` naming convention. This groups your projects chronologically by year and month. The `RAW/` subfolder is sacred: never write modified files, exports, or software scratchpads inside it.

### 2.4 The `Videos/` Repository (Motion Picture Production Stack)

Because video editing involves heavy file processing, this directory splits up heavy source assets, low-overhead editing proxies, and final master renders to keep things running efficiently.

```text
Media/Videos/
└── [YYYY-MM_Project_Name_Location]/
    ├── RAW/                [Camera Native Video Clips / High-Bitrate OBS Ingests]
    ├── Proxy/              [Lightweight temporary clips for fast editing]
    └── Master/             [Final, high-bitrate rendered output streams]

```

* **Operational Rules:** Point your video editors (Kdenlive and DaVinci Resolve) to write their temporary preview and cache files directly into a hidden or system-specific folder on your fast local NVMe drive. Keep these temporary cache files out of your main `Master/` directories to save backup space.

---

## CHAPTER 3: INTER-OPERATIONAL FILE FLOW

To keep your filesystem organized over the long term, follow this strict visual workflow for routing assets through your directory structure whenever you return from a field shoot:

```text
       [ EXTRACTION ] ────> Connect SD Card to Workstation Reader Block
                                      │
                                      ▼
       [ SEPARATION ] ────> Isolate Media Types via digiKam
                                      │
             ┌────────────────────────┴────────────────────────┐
             ▼                                                 ▼
     [ .CR3 Still Files ]                             [ .MP4 Video Clips ]
             │                                                 │
             ▼                                                 ▼
 Media/Photos/YYYY-MM_Name/RAW/                   Media/Videos/YYYY-MM_Name/RAW/
             │                                                 │
             ▼ (Darktable / Affinity)                          ▼ (Kdenlive / Resolve)
 Media/Photos/YYYY-MM_Name/Masters/               Media/Videos/YYYY-MM_Name/Master/

```

---

## CHAPTER 4: CORE DISCIPLINE & RULES FOR FILESYSTEM SUCCESS

1. **The Single-Root Law:** Never save temporary project files loosely onto your desktop, system download folders, or generic user documents paths. Every file must live within your managed `Media/` tree. If an asset doesn't fit into an existing folder, create a dedicated, named subfolder within the correct main category branch immediately.
2. **Deterministic Naming Conventions:** Avoid vague, messy names like `untitled.mp4`, `edit_v2_final_revised.mp4`, or `test_photo.jpg`. Use strict, structured file names that include the creation date, camera index, or precise descriptive descriptors:
* Correct Still Image Name: `20260619-IMG_0432.CR3`
* Correct Video Master Name: `Tampere_Downtown_Reaction_Master_1080p60.mp4`


3. **Strict Separation of Master Assets:** Keep your raw source data layer completely independent from your edited work. Never overwrite your camera-original `.CR3` files. Your source files must remain clean, pristine, and unaltered, serving as the secure foundation for your entire editing history.
4. **Regular Housekeeping Protocols:** At the end of every production cycle, clean up your active workspace. Delete your temporary render cache blocks and proxy files to reclaim high-speed NVMe drive space. Your project directories should ultimately hold only your original source assets, editing project files, and final high-fidelity distribution masters. This keeps your system fully optimized, organized, and ready for your next field operation.
