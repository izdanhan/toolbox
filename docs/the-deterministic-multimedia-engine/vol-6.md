# THE MOTION PICTURE EDITING & COLOR MANUAL

## Volume VI: Non-Linear Timeline Orchestration and Hardware-Accelerated Mastering

### Standard Operating Procedures for DaVinci Resolve (Free Edition) on Windows 11

---

### PREFACE: SOFTWARE RUNTIME OPTIMIZATION

This volume defines the execution protocols for editing, audio-mixing, and color-grading high-fidelity source footage inside **DaVinci Resolve (Free Edition)** on Windows 11.

While the free version lacks select neural-engine features and native hardware-accelerated H.264/H.265 decoding on the timeline, this manual implements explicit software workarounds—specifically Proxy and Render Cache pipelines—to guarantee a real-time, zero-lag editing experience using an **AMD Ryzen 9 5900X, 32 GB RAM, and an NVIDIA RTX 3080**.

---

## CHAPTER 1: WORKSPACE INITIALIZATION & HARDWARE CORES

Before dropping raw media onto a timeline, DaVinci Resolve must be configured to utilize your storage architecture and GPU execution units.

### 1.1 Global Preference Alignment

Launch DaVinci Resolve. Navigate to the top menu bar and select **DaVinci Resolve -> Preferences**.

* **Memory and GPU:** * *GPU Configuration:* Uncheck *Auto*. Set GPU Processing Mode to **CUDA**. Check the manual box next to your **NVIDIA GeForce RTX 3080**.
* **Media Storage:** Ensure your fastest NVMe mount point (`D:\Media\`) is pinned at the top of the scratch disk storage directories list.

### 1.2 Project Settings Optimization

Create a new project. Click the **Project Settings (Gear Icon, lower right)**. Configure your foundational layout parameters precisely:

* **Master Settings:**
* *Timeline Resolution:* `1920 x 1080 HD`. (Operational Directive: Even if your camera native files are 4K UHD, lock your working timeline to 1080p. This massively reduces VRAM overhead and computational stress during color grading. You will change this setting back to 4K right before final rendering).
* *Timeline Frame Rate:* Lock this to **23.976** or **29.97** frames per second, matching the exact acquisition parameters of your Canon R50 source clips.


* **Optimized Media and Render Cache:**
* *Cache format:* Set *Proxy Media Format*, *Optimized Media Format*, and *Render Cache Format* to **DNxHR SQ** or **DNxHR LB**. These are intra-frame editing codecs optimized for Windows performance. They bypass the high CPU decoding overhead that makes native camera compressed formats lag.



---

## CHAPTER 2: AGILE MEDIA INGESTION & AUDIO ALIGNMENT

Data management is handled directly within the dedicated **Media Page** (Tab 1 at the lower edge of the UI console).

```text
[ D:\Media\Videos\ ] ──> [ Resolve Media Pool ] ──> [ Generate Proxies (DNxHR LB) ]
                                                            │
                                                            ▼
[ Separate High-Fidelity Rode Mic Track ] ────> [ Auto-Sync via Waveform ]

```

### 2.1 Media Ingestion

1. Use the upper-left Media Storage browser to find your production path: `D:\Media\Videos\2026-06_Tampere_Downtown\RAW\`
2. Drag the folders into the primary **Media Pool** window. If a dialog prompt displays *"Change Project Frame Rate?"*, click **Change** if this is your primary camera timeline.

### 2.2 The Free-Edition Proxy Pipeline (Essential Step)

Because the free edition of Resolve handles raw compressed camera streams via software thread decoding, you must generate local editing proxies to keep your timeline completely fluid:

1. Select all video clips in your Media Pool.
2. Right-click the highlighted files and choose **Generate Proxy Media**.
3. Resolve will rapidly transcode the clips into lightweight, responsive DNxHR files. Go to the top menu, select **Playback**, and ensure **Use Proxy Media If Available** is checked.

### 2.3 Audio Waveform Merging

If your high-fidelity vocal or ambient audio track from your **Rode VideoMic II Go** was captured as an independent file (e.g., via OBS Studio capture or separate recording device):

1. Import the audio clip into the same Media Pool folder.
2. Highlight the video asset and the matching Rode microphone audio track simultaneously.
3. Right-click and choose **Auto Sync Audio -> Based on Waveform**. Resolve automatically scans the audio tracks, aligns them down to the exact millisecond sample, and non-destructively replaces the internal camera scratch audio with your clean microphone track.

---

## CHAPTER 3: TIMELINE EDITING METRICS

Advance to the **Edit Page** (Tab 3 at the bottom menu).

```text
┌────────────────────────────────────────────────────────┐
│                      EDIT WINDOW                       │
│                                                        │
│ TRACK V2: [ B-Roll / Cutaway Overlay Clips ]            │
│ TRACK V1: [ Primary A-Roll Video Footage Frame Array ] │
│                                                        │
│ TRACK A1: [ Linked High-Fidelity Rode Audio Track ]     │
│ TRACK A2: [ D:\Media\Assets\Music\ Soundbed Track ]     │
└────────────────────────────────────────────────────────┘

```

1. Drag your synced primary clips from the Media Pool onto Track V1/A1 to initialize your sequence layout.
2. Use the **Blade Tool (`B`)** to make precision cuts on actions or phrase pauses, and swap back to the **Selection Tool (`A`)** to position elements cleanly.
3. **Inserting Static Assets:** Drag overlays or background audio files straight from your global asset structures (`D:\Media\Assets\Music\` or `Overlays\`) directly onto secondary tracks (V2/A2) to add layers to your project layout.

---

## CHAPTER 4: CINEMATIC COLOR MASTERING (THE COLOR PAGE)

Advance to the **Color Page**. Your RTX 3080 will handle processing across Resolve's node trees instantly.

### 4.1 Node-Based Processing Architecture

Never apply all exposure, contrast, and color adjustments onto a single layer. You must build a structured, non-destructive node tree by pressing `Alt + S` to create serial nodes sequentially.

```text
  [ Node 01: Exposure ] ──> [ Node 02: Balance ] ──> [ Node 03: Contrast/Look ]

```

* **Node 01: Exposure Triage:** Select Node 1. Use the **Primaries Wheels (Lift, Gamma, Gain)** while watching the Waveform Monitor graph on the lower right dashboard. Adjust *Lift* until your darkest shadow elements rest comfortably near 0, then adjust *Gain* until highlights expand up toward 896 or 1023. Do not push your data past these thresholds to avoid irreversible clipping.
* **Node 02: Temperature / Balance:** Select Node 2. Use the **Temperature** and **Tint** numeric entry blocks to balance out colored city lights, neutralizing mixed skin tones or concrete urban hues across downtown street corners.
* **Node 03: Look Geometry:** Select Node 3. Add global contrast curves or utilize the **Curves (Custom)** graph to separate highlights from deep shadow regions. Adjust the global **Saturation** value to lock in your desired creative look.

---

## CHAPTER 5: THE MASTER 4K EXPORT CRUSH (DELIVER PAGE)

Advance to the **Deliver Page** (the Rocket Ship Icon).

### 5.1 Restoring Full Resolution Metadata

Before configuring your render output settings, you must restore your timeline to full capture fidelity if you scaled it down earlier. Press **Shift + 9** to open Project Settings. Change *Timeline Resolution* back to its master parameters: **3840 x 2160 Ultra HD**. Resolve's processing engine will scale your nodes and edits back up to the master files cleanly.

### 5.2 Render Setting Parameters

Configure the left-hand Render Settings panel strictly as follows to trigger hardware acceleration:

```text
  Render Target Location ──> D:\Media\Videos\...\Master\
  Video Format Profile  ──> MP4
  Codec Stream Mode     ──> H.264 (or H.265)
  Encoder Selector      ──> NVIDIA (Forces NVENC Hardware Core Activation)

```

1. **Location:** Browse to your production drive directory layout: `D:\Media\Videos\2026-06_Tampere_Downtown\Master\`
2. **Export Interface Specs:**
* *Format:* **MP4**
* *Codec:* **H.264** (or *H.265* for smaller high-quality compression layouts).
* *Encoder:* Change this setting from *Native* to **NVIDIA**. **(Critical Performance Metric):** This overrides Windows software processing routines and forces the timeline data straight through the dedicated **NVENC** hardware blocks on your RTX 3080, rendering your project in seconds.
* *Resolution:* `3840 x 2160 Ultra HD`
* *Rate Control:* Set Quality to **Restrict to** `60,000` Kbps for flawless 4K output playback (or `20,000` Kbps if your master project timeline is native 1080p).


3. Click **Add to Render Queue** at the base of the panel.
4. Move over to the right-hand Render Queue module box and click **Render All**.

---

## CHAPTER 6: OPERATIONAL CLEANUP

Once the render status hits 100%, verify the output video file inside your master directory. If the master render is successful, you can safely open your project media storage directory and delete the temporary cache folder (`CacheClip`) to reclaim high-speed NVMe space. Use your camera's internal system tools to wipe your SD card clean for your next operational field trip.
