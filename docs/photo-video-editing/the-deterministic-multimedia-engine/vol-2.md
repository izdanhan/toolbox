# THE LINUX MULTIMEDIA PRODUCTION MANUAL

## Volume II: Unified Open-Source Ingestion, Scene-Referred Development, and Non-Linear Editing

### Standard Operating Procedures for Fedora Workstation (KDE Plasma Edition)

---

### PREFACE: PLATFORM ARCHITECTURE

This volume dictates the exact protocols for harvesting, development, and timeline assembly of multimedia assets within an uncompromised, open-source Linux environment.

All procedures are engineered specifically for a **Fedora Workstation (KDE Plasma)** host utilizing an x86-64 microarchitecture (`AMD Ryzen 9 5900X`), centralized high-speed storage arrays (`Samsung 990 Pro`), and hardware-accelerated processing pipelines via compute runtimes (`NVIDIA OpenCL / NVENC Pipeline`). Maintain strict directory discipline to guarantee absolute project reproducibility across the filesystem.

---

## CHAPTER 1: THE INGESTION PROTOCOL & DIR STRUCTURE

File ingestion must be treated as a precise data transaction. Manual manipulation using the system file manager (`Dolphin`) introduces risks of missing sidecar files and breaking metadata structures.

### 1.1 Hardware Setup & Mounting

1. Extract the SDXC media card from the capture apparatus (Canon EOS R50).
2. Insert the media into the workstation's card interface reader.
3. Launch **digiKam Asset Manager** from the Application Launcher.

### 1.2 Target Directory Topology

All assets must map strictly to the structured directory system located on your primary production media root. Never scatter files loosely across the storage drives.

```text
Media/
├── Assets/                 [Global static production templates]
│   ├── Brushes/
│   ├── Fonts/
│   ├── Music/
│   ├── Overlays/
│   └── Textures/
├── Photos/                 [Still Image Root Directory]
│   └── 2026-06_Tampere_Downtown/
│       ├── RAW/            [Camera Native .CR3 Files]
│       └── Masters/        [High-Bit-Depth Final Exports]
└── Videos/                 [Motion Capture Root Directory]
    └── 2026-06_Tampere_Downtown/
        ├── RAW/            [Camera Native Clips]
        └── Master/         [Final Render Output Files]

```

### 1.3 Automated Import Configuration

1. Within digiKam, execute **Import -> Cameras -> [Select Card Mount Pointer]**.
2. On the right-hand options panel, expand **File Renaming Options**. Toggle to `Customize` and configure the structural mask string: `yyyyMMdd-[CameraFilename]`. This enforces a permanent chronological sorting layer that prevents naming collisions across production drives.
3. Under **Auto-Creation of Albums**, assign `Date-Based Sub-Albums`.
4. Target the destination paths directly:
* Still image transfers target: `Media/Photos/2026-06_Tampere_Downtown/RAW/`
* Motion sequence transfers target: `Media/Videos/2026-06_Tampere_Downtown/RAW/`


5. Click **Download -> Download New**. Do not wipe or format the physical SDXC card yet.

---

## CHAPTER 2: STRUCTURAL TRIAGE (CULLING)

A professional editor isolates high-value material systematically. Do not clutter downstream editing timelines with degraded or flawed source files.

1. Select the destination ingestion directory inside the digiKam sidebar to populate the workspace grid.
2. Open the **Light Table** view (`Ctrl + L`) to load frames side-by-side at 100% pixel scale for sharpness verification.
3. Step through assets using keyboard arrows and apply numerical rating metadata tags:
* **1 Star (Trash):** Missed focus, micro-shake blur, heavy highlight clipping, or poor composition.
* **3 Stars (Archival):** Sharp focus, sound baseline technical exposure, standard reference material.
* **5 Stars (Production Master):** Exceptional framing, dynamic local contrast, prime narrative delivery.


4. Filter the view to isolate **1-Star** ratings. Select all and execute a complete filesystem purge (`Shift + Delete`).

---

## CHAPTER 3: STILL FRAME MASTERING (DARKTABLE)

RAW `.CR3` files from your Canon R50 require precise demosaicing. We execute this via **darktable**, relying completely on its modern scene-referred workflow powered by hardware acceleration.

```text
[ RAW .CR3 Ingest ] ──> [ OpenCL GPU Hardware Pipelines ] ──> [ Lens / Denoise Profiles ] ──> [ Scene-Referred Tonal Output ]

```

### 3.1 Verification of Hardware Compute Runtimes

Open darktable. Navigate to **Global Settings (Gear Icon) -> Storage & Performance**. Locate **Activate OpenCL Support** and ensure it is turned **ON**. This passes the math operations directly to your **NVIDIA RTX 3080**, ensuring real-time responsive rendering.

### 3.2 Spatial Correction & Tonal Execution (Darkroom)

Import your `Photos/.../RAW/` directory into the **Lightroom** view. Filter the view to show only elements $\ge$ 3 stars. Double-click an image to initialize the **Darkroom** development module:

1. **Lens Correction Module:** Activate *Lens Correction*. The engine reads the camera metadata, matching the profile to neutralize optical distortion, chromatic aberration, and vignetting.
2. **Denoise (Profiled) Module:** For frames captured at high ISO parameters during dusk around Tampere downtown, activate *Denoise (Profiled)*. This bypasses basic blurring algorithms, applying a custom noise reduction model calibrated directly to the sensor characteristics of your camera.
3. **Exposure & Filmic RGB Modules:** Adjust your mid-tones using the *Exposure* module. Next, open the *Filmic RGB* (or *AgX*) module. Map your absolute black and white saturation targets to anchor the scene highlights securely within the histogram borders without clipping data.
4. **Color Balance RGB Module:** Introduce your stylistic color grading, separating shadow tones from highlight vibrance with non-destructive, parametric controls.

### 3.3 Batch Processing & Mastering Export

1. Return to the **Lightroom** panel. Select your developed base frame and click **History Stack -> Copy**.
2. Multi-select all secondary files shot under equivalent ambient lighting conditions and click **History Stack -> Paste**.
3. Access the **Export Selected** panel on the right sidebar:
* **Target:** File on disk.
* **File Format:** Set to `JPEG (8-bit)` for immediate distribution or `TIFF (16-bit)` for long-term uncompressed master archiving.
* **Global Profile:** Select **sRGB** (mandatory to avoid gamma shifts when images are loaded on standard web or external mobile displays).
* **Destination Path:** Set to `Media/Photos/2026-06_Tampere_Downtown/Masters/`. Click **Export**.



---

## CHAPTER 4: NON-LINEAR MOTION TRANSCODING & EDITING (KDENLIVE)

Video sequence orchestration is executed via **Kdenlive**, using open-source MLT frameworks optimized for discrete hardware encoders.

```text
[ Camera Video .MP4 ] ──> [ Kdenlive Media Bin ] ──> [ Proxy Clip Generation ] ──> [ Multi-Track Edit Timeline ]
                                                                                           │
                                                                                           ▼
[ Hardware Master Export ] <── [ FFmpeg Render Profile ] <── [ NVENC GPU Encoding ] <──────┘

```

### 4.1 Workspace Initialization & Proxy Management

1. Launch **Kdenlive**. Navigate to **Project -> Project Settings**. Match your custom frame profile precisely to your native camera acquisition metrics (e.g., `1080p 29.97fps`).
2. Go to the **Proxy** tab in settings. Check **Enable Proxy Clips**. Set the resolution threshold to `1000`. This prompts Kdenlive to automatically generate light, performance-optimized edit files for timeline placement, maintaining 100% editing responsiveness while ensuring the final export renders from the original raw camera assets.
3. Import your clips from `Media/Videos/2026-06_Tampere_Downtown/RAW/` into the **Project Bin**.

### 4.2 Timeline Assembly & Audio Synchronization

1. Move footage assets down to the primary video tracks.
2. **High-Fidelity Audio Alignment:** If your audio capture from the *Rode VideoMic II Go* was run through an external recording interface or requires precise manual pairing, place the separate high-fidelity WAV file onto Audio Track 2 right below the video clip containing the internal camera audio track. Highlight both items, right-click, and select **Align Audio**. Kdenlive analyzes the physical waveform shapes, shifting the high-quality microphone track into perfect alignment. Mute the camera’s internal audio track permanently.
3. Edit your project down, executing cuts, sequencing scene geometry, and placing overlays straight from your static asset directories.

### 4.3 Hardware Accelerated Export Pipeline (NVENC)

To prevent your CPU from bottlenecking during high-bitrate rendering, route the export process directly through the hardware encoder blocks on your graphics card.

1. Click the **Render** action button (`Ctrl + Return`) to open the rendering console.
2. In the profile presets directory tree, locate and expand the **Hardware Accelerated** or **MP4-NVENC** profile category. Select **NVENC H264** or **NVENC H265**.
3. Verify the rendering configuration options. Kdenlive calls your native Linux `ffmpeg` layers, linking the video rendering stream directly to the **NVENC (NVIDIA Encoder)** core on your RTX 3080 GPU.
4. Set the output destination file path to: `Media/Videos/2026-06_Tampere_Downtown/Master/render.mp4`.
5. Execute **Render to File**. Your project will render rapidly, utilizing dedicated hardware acceleration.

---

## CHAPTER 5: MAINTENANCE & STORAGE PROTOCOLS

1. Open the rendered output files in your local media player to ensure absolute compression correctness and video/audio synchronization.
2. Unmount your media card safely from the KDE Plasma system tray.
3. Insert the card back into the body chamber of your camera. Initialize the **Canon R50 internal camera format configuration tool** to clear the card's file systems for the next operational field trip. Never execute file deletion or format adjustments on the card using the PC file manager; this risks corrupting the camera's filesystem architecture.
