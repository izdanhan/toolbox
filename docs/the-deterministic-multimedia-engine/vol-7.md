# THE LINUX MOTION PICTURE EDITING & CODING MANUAL

## Volume VII: Open-Source Timeline Orchestration and Hardware-Accelerated Mastering

### Standard Operating Procedures for Kdenlive on Fedora Workstation (KDE Plasma)

---

### PREFACE: SYSTEM INTEGRITY & RUNTIME ENVIRONMENTS

This volume establishes the technical protocols for editing, multi-track timeline assembly, and audio engineering inside **Kdenlive** within a hardware-accelerated **Fedora Workstation (KDE Plasma)** environment.

The pipeline is engineered to extract maximum performance from your **AMD Ryzen 9 5900X, 32 GB RAM, and NVIDIA RTX 3080**. It bypasses high-overhead CPU software decoding by leveraging multi-threaded intra-frame Proxy pipelines and bridges directly into the **NVIDIA NVENC (H.264/H.265)** hardware encoder blocks via system-native `ffmpeg` layers.

---

## CHAPTER 1: WORKSPACE INITIALIZATION & HARDWARE ACCELERATION

Before loading media into the project bin, Kdenlive must be optimized to map processing pipelines directly to your discrete GPU hardware.

### 1.1 Hardware-Accelerated Playback Configuration

Launch Kdenlive. Navigate to the top menu bar and execute **Settings -> Configure Kdenlive...**

* **Playback Panel:** Locate the *Hardware Acceleration* block. Set the driver platform to **VAAPI** or **NVDEC/CUDA** (depending on your local flatpak or native repository configurations). This forces your RTX 3080 to take over real-time timeline video decoding, keeping clip scrubbing entirely fluid.
* **Environment Panel:** Verify that the file paths point directly to your high-performance NVMe storage volume (`/run/media/.../Media/` or your assigned Linux mount path). Never use a slow mechanical drive or network storage for your temporary cache directory.

### 1.2 Master Project Profile Synchronization

1. Go to **Project -> Project Settings** (`Shift + Set`).
2. Under the **Custom Project Profiles** tree, match your timeline configuration precisely to your Canon R50 acquisition telemetry: Select **4K UHD 2160p 23.98 fps** (or *1080p 29.97 fps* if editing standard high-frame-rate test footage).
3. **The Proxy Matrix Initialization:** Toggle over to the **Proxy** tab inside Project Settings:
* Check the box to **Enable Proxy Clips**.
* Set *Rescale larger than* to **1000 pixels**.
* Set the *Encoding Profile* to **MPEG4** or **MJPEG**.
* *Operational Directive:* This automatically targets your heavy 4K `.MP4` files, downscaling them into light, fluid intra-frame temporary editing clips inside the timeline environment. When you execute the final render, Kdenlive automatically references the master camera files to ensure 100% export quality.



---

## CHAPTER 2: HIGH-THROUGHPUT MEDIA INGESTION & TRACK ALIGNMENT

All operations map cleanly into the open-source directory topology established on your media volume.

```text
[ Media/Videos/RAW/ ] ──> [ Kdenlive Project Bin ] ──> [ Automatic Background Proxies Generated ]
                                                                     │
                                                                     ▼
[ Separate High-Fidelity Audio File ] ────────────> [ Waveform Audio Alignment Tool ]

```

### 2.1 Ingestion Protocols

1. In the upper-left console dashboard, right-click inside the **Project Bin** and select **Add Clip or Folder...**
2. Browse to your dedicated project acquisition root: `Media/Videos/2026-06_Tampere_Downtown/RAW/`
3. Import the folder. If a dialog box prompts you to change the project profile to match the clips, click **Yes** to prevent timeline conversion errors.
4. Kdenlive will immediately spawn background threads to compile proxy files. You will observe small orange `P` indicators lock onto your clip thumbnails inside the Project Bin when execution is complete.

### 2.2 High-Fidelity Audio Waveform Alignment

If you captured clean commentary or ambient street tracks using your **Rode VideoMic II Go** routed into a separate screen/audio capture system (like an OBS Studio master capture session):

1. Import the separate audio track file into the Project Bin.
2. Drag the video clip down onto Video Track 1 (`V1`). The low-grade camera internal scratch track will occupy Audio Track 1 (`A1`).
3. Drag your clean, high-fidelity Rode audio track file directly onto Audio Track 2 (`A2`).
4. Select both the clip on `V1` and the clip on `A2` simultaneously. Right-click the group and choose **Align Audio**.
5. Kdenlive's acoustic analysis framework evaluates the physical waveform frequencies, sliding the high-fidelity track into sample-accurate phase sync. Permanently mute or delete the original scratch track on `A1`.

---

## CHAPTER 3: TIMELINE ORCHESTRATION & COMPOSITION LAYOUTS

Move to your active editing workspace tracks.

```text
┌────────────────────────────────────────────────────────┐
│                   KDENLIVE TIMELINE                    │
│                                                        │
│ TRACK V2: [ Reaction Window / B-Roll Overlays ]        │
│ TRACK V1: [ Primary Urban Camera Assets Array ]        │
│                                                        │
│ TRACK A1: [ MUTED Camera Scratch Track ]               │
│ TRACK A2: [ Synced High-Fidelity Rode Mic Track ]      │
│ TRACK A3: [ Media/Assets/Music/ Background Track ]     │
└────────────────────────────────────────────────────────┘

```

1. Use the **Razor Tool (`X`)** to split clips instantly on phrase pauses or framing updates. Swap back to the **Selection Tool (`S`)** to slide layout clips across your sequence tracks.
2. **Integrating Static Overlays:** Drag background audio layers or geometric vector branding straight from your permanent global storage trees (`Media/Assets/Music/` or `Overlays/`) down onto your lower audio or higher video tracks to build your presentation layers.

---

## CHAPTER 4: PARALLEL PROCESS EFFECTS & CORRECTION (THE EFFECTS PAGE)

Kdenlive processes video effects sequentially. Open your **Effects** panel (`Ctrl + 4`) and manage your processing chain strictly in this structural order.

```text
  [ Step 01: Lift/Gamma/Gain ] ──> [ Step 02: White Balance ] ──> [ Step 03: Curves/Saturation ]

```

### 4.1 Exposure Stabilization & Color Grading

1. Locate **Lift/Gamma/Gain** inside the Color correction folder. Drag and drop it onto your primary video clips. Open your **Vectorscope / Waveform Monitor** panels via the view options menu. Adjust your shadow black point (*Lift*) and peak highlights (*Gain*) to stretch the image data across the entire signal range without clipping.
2. Drag the **White Balance** effect onto your track. Use the neutral picker to sample concrete street infrastructure or a neutral building surface from downtown Tampere to wipe away mixed city lighting casts.
3. Apply the **Curves** module to dial in local mid-tone contrast, then use the **Saturation** slider to step up your global colors to complete the creative look.

---

## CHAPTER 5: NVENC HARDWARE-ACCELERATED ENCODING (THE MASTER EXPORT)

To prevent your CPU from bottlenecking during file compression, route the rendering pipeline through your graphics card's hardware blocks.

### 5.1 The Render Console Setup

1. Click the main **Render** button on the top toolbar dashboard (`Ctrl + Return`).
2. In the rendering preset profile column, navigate down and expand the **Hardware Accelerated** category tree. Select **MP4-NVENC H264** or **NVENC H265**.

```text
  Render Destination  ──> Media/Videos/2026-06_Tampere_Downtown/Master/
  Format Profile       ──> MP4 (Hardware Accelerated)
  Selected Preset     ──> NVENC H264 (Calls Native Linux FFmpeg Layers)
  Bitrate Parameters  ──> VBR Constant Quality (Crf 20-23)

```

### 5.2 Compiling the Render Configuration

1. Set your output file path destination directly to your project master archive: `Media/Videos/2026-06_Tampere_Downtown/Master/production_master.mp4`
2. **The NVENC Speed Configuration:** Click the **Open Option / Edit Profile** button to review the raw `ffmpeg` backend commands. Ensure the line reads `-vcodec h264_nvenc` or `hevc_nvenc`. This explicitly tells the system to bypass the CPU threads and pipe the raw data blocks straight through the **NVIDIA Encoder (NVENC)** hardware blocks on your RTX 3080.
3. Under the quality parameter box, select **VBR** or **Constant Quality**. Set the value slider to **20** or **22** for ultra-clean, high-bitrate archival delivery.
4. Click the primary button: **Render to File**. The project timeline frames will compile rapidly via hardware acceleration.

---

## CHAPTER 6: FIELD POST-FLIGHT CLEANUP

1. Launch your media player to review the final output inside the master folder, confirming complete video alignment and audio synchronization.
2. Once the final master is verified, go to Kdenlive's top menu and choose **Project -> Clean Project**. This securely purges temporary workspace proxy caches, reclaiming high-speed space on your NVMe storage drive.
3. Unmount your SDXC card safely from the KDE Plasma system tray. Re-insert it into your Canon R50 body and run the internal formatting tool to prep the filesystem for your next operational field trip.
