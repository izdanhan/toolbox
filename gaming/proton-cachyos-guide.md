**Do not lower your native game resolution.** Keep the game running at your display's native resolution.

OptiScaler works as an interceptor. You tell the game to turn on **DLSS** at native resolution, and the game engine automatically drops its *internal* rendering resolution based on the preset you chose (Quality, Balanced, Performance). OptiScaler then intercepts those lower-res frames, blocks Nvidia's proprietary path, and reconstructs them into your native resolution using AMD's FSR 4 pipelines.

---

## Complete Guide to Optimal Deployment (Proton-CachyOS 11.0)

### Phase 1: The Steam Launch Command

Paste this exact string into your game's Launch Options:

```bash
MANGOHUD=1 PROTON_USE_OPTISCALER=1 PROTON_USE_FSR4=1 gamemoderun %command%

```

*(Proton-CachyOS 11.0 automates the tedious parts: it downloads the necessary Nvidia `nvngx.dll` stubs on the fly and drops them into the prefix so the game thinks an RTX card is present).*

---

### Phase 2: In-Game Graphics Settings

1. Boot the game. Go straight to **Settings $\rightarrow$ Graphics/Display**.
2. Set your resolution to your display’s **Native Resolution** (e.g., $1920 \times 1200$ or $1920 \times 1080$).
3. Set Display Mode to **Fullscreen** or **Borderless Windowed**.
4. Locate the Anti-Aliasing / Upscaling section. **Select NVIDIA DLSS**.
5. Set the DLSS Quality Preset depending on your target frame rate:
* **Quality:** Best visuals, renders internally around ~67% of native.
* **Balanced:** Optimal performance-to-clarity ratio for the 780M APU.
* **Performance:** Maximum frames (renders at 50% native).



---

### Phase 3: The OptiScaler Menu Calibration

Once you are actively in control of your character/gameplay:

1. Press the **`Insert`** key on your keyboard. The OptiScaler ImGUI overlay will appear on screen.
2. Navigate to the **Upscalers** tab.
3. Change the backend target to **FSR 3.X/4**.
4. Match the **Model Number** to the preset you selected in the game settings to properly align sharpness filters:
* **Model 1:** If you chose *Quality* in-game.
* **Model 2:** If you chose *Balanced* in-game.
* **Model 3:** If you chose *Performance* in-game.


5. Click **Change Upscaler** to apply the configuration. Press **`Insert`** again to close the menu.

---

### Phase 4: Verification via MangoHud

Look at your MangoHud overlay. If your frame rate has significantly increased, frame pacing is flat, and the image looks vastly sharper than basic TAA or FSR 1.0, the pipeline is fully operational.

> **Emergency Fallback:** If a game crashes instantly on boot or displays a black/white window with this configuration, it means the game engine's launcher conflicts with Proton 11's early Wayland/OptiScaler hooks. Wipe the launch options, switch the compatibility runner to **Proton-GE 10-34**, and use standard in-game FSR/AA methods.
