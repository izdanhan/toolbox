# Starfield

Driving a 65" 4K 120Hz display with an RTX 3080 and a Ryzen 9 5900X under Linux Mint requires tactical optimization. Starfield is notoriously unoptimized, punishing both CPU thread performance in heavy zones (New Atlantis/Akila City) and running out of GPU headroom quickly at native 4K.

To maximize the capabilities of your Samsung Q70A's VRR panel without dropping into unstable frame rate territory, native 4K is off the table. You must rely on DLSS upscaling to hit a stable performance envelope.

Here is the exact breakdown for your setup:

### Game & Engine Configuration

* **DLSS Scaling:** Turn it **ON**. Set the Render Resolution Scale to **67%** (this feeds the engine a stable 1440p base image and reconstructs it cleanly to 4K).
* **Dynamic Resolution:** **OFF** (prevents erratic frame pacing drops that fight your VRR window).
* **VSync:** **OFF** (let the TV's hardware VRR handle frame syncing).

### Optimized Graphic Settings

| Setting | Target Value | Tactical Justification |
| --- | --- | --- |
| **Shadow Quality** | **Medium** | Ultra shadows drain up to 18% of your performance. Medium gives back double-digit frames with minimal visual loss. |
| **Volumetric Lighting** | **Medium** | Tying up the 3080's compute pipelines with heavy particle fog is wasteful. Medium saves ~8% headroom. |
| **Crowd Density** | **Medium** | Direct target for the Ryzen 5900X. High will cause micro-stuttering in dense cities. |
| **Indirect Lighting** | **High** | Safe on your hardware; going lower degrades interior visual atmosphere sharply. |
| **Reflections** | **Medium** | Balanced performance impact without completely killing wet surface data. |
| **GTAO Quality** | **High** | Ambient occlusion costs minimal compute on an Ampere architecture card. |
| **Contact Shadows** | **Medium** | Keeps fine-detail shadows clean without eating massive bandwidth. |
| **Particle Quality** | **Medium** or **High** | Neutral performance impact except during massive combat explosions. |
| **Grass Quality** | **High** | The 3080 handles the geometric layout fine outside of city hubs. |
| **Motion Blur / Film Grain** | **OFF** | Visual noise that wastes compute cycles. Drop completely. |
| **VRS (Variable Rate Shading)** | **OFF** | Unreliable behavior under Proton/Nvidia drivers; often introduces frame pacing variation. |

### Linux Platform Tweaks

Given your 595 drivers and Liquorix kernel, make sure your Steam launch options for Starfield include the absolute essentials for optimal thread allocation and execution path under VKD3D:

```bash
__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1 DXVK_ASYNC=1 %command%

```

*(Note: If you encounter stuttering during initial cellular transitions, allow the pipeline cache to build over the first few minutes of gameplay.)*
