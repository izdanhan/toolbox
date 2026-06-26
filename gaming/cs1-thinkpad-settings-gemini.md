# Cities Skylines: Optimal settings for ThinkPad T14s Gen 4

Your ThinkPad T14s Gen 4 will handle Cities: Skylines 1 quite well, provided you configure it properly and accept the physical limitations of an integrated GPU.

The Ryzen 7 Pro 7840U packs the **Radeon 780M**, which is arguably the strongest integrated graphics chip of its generation, and your **32 GB of RAM** gives you the critical breathing room needed to load all the DLCs.

Here is the exact tactical breakdown for running it on your Ubuntu setup:

### Performance Expectations

* **Graphics Settings:** Set your resolution to **1080p** and stick to **Medium settings**. Turn off heavy post-processing effects like depth of field and motion blur.
* **Early to Mid-Game (0 – 50k population):** You will easily hit a smooth **40–60 FPS**.
* **Late Game (100k+ population):** The simulation overhead will cause the framerate to drop down to **25–35 FPS**. This is completely normal for this game, even on high-end desktops, because the engine bottlenecks on single-core CPU tracking for citizen pathfinding.

---

### Critical Linux Tweaks for CS1

Because you are running on Ubuntu with a heavily DLC-loaded setup, you need to apply these settings to prevent performance degradation or crashes:

1. **Native vs. Proton (Force Proton):**
CS1 has a native Linux build, but it relies on an older OpenGL implementation that performs poorly on modern drivers and frequently suffers from saving glitches or crashing when heavily modded.
* Open Steam $\rightarrow$ Right-click **Cities: Skylines** $\rightarrow$ **Properties** $\rightarrow$ **Compatibility**.
* Check "Force the use of a specific Steam Play compatibility tool" and select **Proton Experimental** or **Proton GE**. Running the Windows version through Proton translates DirectX 11 to Vulkan, which runs much more efficiently on the Radeon 780M.


2. **Increase Linux Swap Space:**
Even with 32 GB of system RAM, Ubuntu’s default swapfile size is often too restrictive (usually 2 GB). When CS1 loads all DLCs and assets via the *Loading Screen Mod*, it can trigger the Linux Out-Of-Memory (OOM) killer. Ensure your swap file is configured to at least 8 GB to 16 GB to give the system an emergency buffer.
3. **Steam Launch Options:**
Right-click the game $\rightarrow$ **Properties** $\rightarrow$ **General** $\rightarrow$ **Launch Options**, and paste the following to optimize the engine initialization:
```text
-force-d3d11 -noVirtualTexturing

```



Keep your expectations realistic regarding the battery life—the 7840U will run at maximum TDP while simulating a massive city—but as a portable baseline, it is entirely viable.
