# THE LIVE PRODUCTION & SCREEN CAPTURE MANUAL

## Volume V: Real-Time Stream Ingestion, Spatial Display Capture, and Signal Routing

### Standard Operating Procedures for OBS Studio on Windows 11

---

### PREFACE: PLATFORM ARCHITECTURE

This volume dictates the operational protocols for configuring **OBS Studio** on Windows 11 as a high-fidelity capture deployment. The target objective is the simultaneous capture of low-latency camera telemetry (Canon EOS R50 via clean HDMI/USB interfaces), directional studio audio engineering (Rode VideoMic II Go mounted on an articulated arm stand), and localized window desktop raster capture (synchronized YouTube media reactions).

The processing pipeline relies heavily on the **NVIDIA NVENC H.264/AV1** hardware hardware-encoder blocks inside the **RTX 3080** to maintain a locked 60 fps production matrix with zero dropped frames.

---

## CHAPTER 1: SUB-SYSTEM HARDWARE CONFIGURATION

Prior to software initialization, the physical capture components must be systematically locked into their deployment positions.

### 1.1 Audio Positioning & Proximity Engineering

1. Secure the **Arm Stand** firmly to the structural edge of your editing desk.
2. Mount the **Rode VideoMic II Go** onto the arm's suspension shock mount. Slide the **Rode WS12 windshield** over the capsule to suppress sharp vocal plosives ($B$, $P$, $T$ sounds) at close range.
3. Position the microphone capsule exactly **10–15 centimeters (4–6 inches) away from your mouth**, angled roughly 45 degrees off-axis from your line of speech. Do not leave the microphone sitting across the desk on a small stand; close proximity ensures a high signal-to-noise ratio and eliminates room echo.
4. Route the USB-C cable (or 3.5mm analog interface line) along the arm chassis, leaving sufficient slack for articulation, and insert it directly into a high-speed motherboard port.

### 1.2 Camera Deployment (The Clean Feed Protocol)

1. Mount the **Canon EOS R50** onto the arm stand adapter or a dedicated desk mount at eye level. Connect the camera to a continuous dummy battery power source to bypass the standard LP-E17 runtime limits.
2. **The Interface Path (Two Options):**
* **Option A (Optimal - HDMI Capture):** Connect a Micro-HDMI cable from the R50 to an external USB Capture Card (e.g., Elgato Cam Link 4K). Plug the capture card into a rear USB 3.0 port. Open the R50 Menu -> *Yellow Wrench Tab 3 -> HDMI Info Display* -> Set strictly to **Clean / No Info Output**. This pipes a pure, menu-free video stream directly to your PC.
* **Option B (Direct USB Webcam Mode):** Connect a USB-C to USB-C cable directly from the camera body to the motherboard. The R50 natively registers as a standard UVC/UAC webcam device over USB.


3. Turn the camera's top Mode Dial to **Movie Mode** to lock the sensor aspect ratio to 16:9.

---

## CHAPTER 2: OBS SYSTEM ENGINES & GRAPHICS ACCELERATION

Launch OBS Studio. Before constructing scenes, open **Settings** from the control panel and configure the backend engines for hardware efficiency.

### 2.1 Video Canvas Alignment

* Navigate to the **Video** tab:
* *Base (Canvas) Resolution:* `1920x1080`
* *Output (Scaled) Resolution:* `1920x1080` (Maintain a 1:1 pixel matrix; downscaling introduces unnecessary filtering blur).
* *Common FPS Values:* Set to **60** to ensure perfectly fluid screen capture playback during fast-motion video analysis.



### 2.2 The NVENC Encoding Blueprint

* Navigate to the **Output** tab and change Output Mode from Simple to **Advanced**. Access the **Recording** tab:
* *Video Encoder:* Select **NVIDIA NVENC H.264** or **NVIDIA NVENC AV1** (if recording for internal storage archive). This completely offloads file compression to the hardware blocks on your RTX 3080.
* *Rate Control:* **CBR** (Constant Bitrate).
* *Bitrate:* Set to **12,000 Kbps** for high-fidelity 1080p60 local mastering.
* *Keyframe Interval:* `2 s`.
* *Preset:* `P5: Slow (Good Quality)` or `P6: Slower`.
* *Profile:* `high`.
* *Max B-frames:* `2`.



---

## CHAPTER 3: SCENE ARCHITECTURE & WINDOW REGION CAPTURE

A professional broadcast layout isolates specific window parameters while blacking out desktop backgrounds and private browser components.

```text
┌────────────────────────────────────────────────────────┐
│                   PRIMARY OBS CANVAS                   │
│                                                        │
│  ┌───────────────────────────────┐                     │
│  │                               │                     │
│  │   SOURCE 1: WINDOW CAPTURE    │                     │
│  │    (Targeted YouTube Crop)    │   ┌──────────────┐  │
│  │                               │   │              │  │
│  │                               │   │   SOURCE 2:  │  │
│  └───────────────────────────────┘   │  VIDEO DEV   │  │
│                                      │ (Canon R50)  │  │
│                                      │              │  │
│                                      └──────────────┘  │
└────────────────────────────────────────────────────────┘

```

### 3.1 Constructing the Foundation

1. Under the **Scenes** module box, click the `+` icon and title it: `Reaction_Layout`.
2. Under the **Sources** module box, click `+` and select **Video Capture Device**. Title it `Camera_R50`. Select your capture card link or the native Canon webcam driver from the device list. Set Resolution to `1920x1080` and Frame Rate to `Highest FPS` or `Match Output`.

### 3.2 The Surgical Screen Region Crop (YouTube Capture)

1. Initialize your web browser. Load the target YouTube media frame on your primary monitor.
2. Return to OBS Sources. Click `+` and select **Window Capture**. Title it `Browser_YouTube`.
3. In the properties prompt, change *Window* to target your specific browser executable (e.g., `chrome.exe` or `firefox.exe`). Set *Capture Method* to **Windows 10 (1903 and up)** to ensure hardware acceleration does not render a blank black screen. Click OK.
4. **The Precision Regional Crop:** The source will currently display your entire browser workspace, including search bars and browser bookmarks.
* Hover your cursor over the perimeter bounds of the `Browser_YouTube` source box on your preview canvas.
* Hold down the physical **ALT Key** on your keyboard. Click and drag the red bounding edge boxes inward.
* This non-destructively trims away the browser UI elements, isolating nothing but the video playback window.


5. **Layout Assembly:** Release the ALT key. Drag the isolated video frame box to fill the upper left quadrant of your layout canvas. Grab your `Camera_R50` layer source, resize it downward, and snap it securely into the lower right corner as your reaction talking-head window overlay.

---

## CHAPTER 4: AUDIO GAIN PIPELINES & NOISE MANAGEMENT

Professional vocals must remain sharp, clear, and perfectly separated from the audio running in the background video.

### 4.1 Audio Device Ingestion

1. In OBS, go to **Settings -> Audio**.
2. Under *Global Audio Devices*, explicitly assign **Desktop Audio** to your main system audio output channel (this routes the YouTube video playback sound straight to the stream canvas).
3. Assign **Mic/Auxiliary Audio** to the exact hardware pointer labeled for your attached **Rode Microphone**. Click Apply.

### 4.2 The Signal Processing Filter Chain

In your main workspace console mixer, locate the `Mic/Aux` track slider. Click the three vertical dots options icon right next to it and select **Filters**. Click `+` to stack your DSP filters in this exact operational order:

```text
[ Rode Microphone Input ]
           │
           ▼
   1. NOISE SUPPRESSION  ──> (Deploys RNNoise AI algorithm to filter out PC fans)
           │
           ▼
   2. THREE-BAND EQ      ──> (Cuts low-end mud below 80Hz / Boosts highs for clarity)
           │
           ▼
   3. COMPRESSOR         ──> (Evens out volume, clamping down shouts and lifting whispers)
           │
           ▼
   4. LIMITER            ──> (Brick-wall ceiling set to -2.0dB to stop digital distortion)

```

1. **Noise Suppression:** Select the **RNNoise (Higher quality)** method. This uses local resource profiles to erase background hums and PC fan noise without altering your speaking voice.
2. **3-Band Equalizer:** Reduce the *Low* shelf slightly if your voice sounds muddy due to your close proximity to the microphone. Add a subtle +1.5 dB boost to the *High* band to clean up vocal definition.
3. **Compressor:** Set the Ratio to `3:1` or `4:1`, Threshold to `-18 dB`, and Output Gain to `+3 dB`. This normalizes your speaking dynamics, keeping casual commentary clear while clamping down on sudden loud laughter or reactions before it clips.
4. **Limiter:** Set the *Threshold* ceiling strictly to **-2.0 dB**. This acts as a brick wall that guarantees your audio will never cross into overdriven digital distortion, protecting your audience's ears.

### 4.2 Audio Balance Ratios

Play a YouTube video and speak normally into your Rode microphone while watching your OBS **Audio Mixer** levels panel:

* Your **Mic/Aux voice levels** should bounce consistently in the upper green and yellow zones, peaking between **-10 dB and -5 dB**.
* The **Desktop Audio tracking bar** (the YouTube audio) should be adjusted down using its volume slider until it bounces safely within the **-25 dB to -18 dB region**. Your voice must always sit roughly 10 to 15 dB louder than the video content to maintain absolute clarity.

---

## CHAPTER 5: CAPTURE OPERATIONS & FILE DEPLOYMENT

1. **Pre-Flight Verification:** Prior to hitting record, click through your scene sources layout. Verify your browser crop is secure, your microphone filter chain is active, and the preview frame rate feels smooth.
2. **Execute Recording:** Click **Start Recording** on the control console panel.
3. **File Retrieval:** When your capture run is complete, click *Stop Recording*. The NVENC block completes compression routines immediately. Navigate directly to your high-performance storage drive structure at:
`Media\Videos\2026-06_Tampere_Downtown\RAW\`
Your output file will be waiting there as an uncompromised high-bitrate master file, ready to be pulled directly onto your Kdenlive editing timeline.
