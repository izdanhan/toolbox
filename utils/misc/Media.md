## 📂 Media Directory Structure and Guide

This `Media` folder is organized to streamline creative workflows involving photos, videos, screen captures, and project-specific assets. 
---

### 🗺️ Directory Structure Overview

The main folders under `Media/` are:

* **`Assets/`**: Contains resources used across multiple projects (like fonts, music).
* **`Photos/`**: Manages all photography files (RAW, Edited, Exported, Backup).
* **`Projects/`**: Stores files specific to various creative projects (like Kdenlive, Krita, and others).
* **`ScreenCaptures/`**: Houses recordings and derived clips from screen capture sessions.
* **`Videos/`**: Manages video production files (RAW footage, Assets, Projects, Rendered).

| Path | Description | Contents |
| :--- | :--- | :--- |
| `Media/Assets/` | Reusable resources for various projects. | Brushes , Fonts , Music , Overlays , Stock , Textures  |
| `Media/Photos/` | All photographic material. | Backup , Edited , Exported , RAW  |
| `Media/Projects/` | Dedicated folders for different software and project types. | Kdenlive, Krita, Other  |
| `Media/Projects/Kdenlive/` | Kdenlive video editing project files. | ProjectFiles  |
| `Media/Projects/Krita/` | Krita digital art project files. | Assets , Exports , Originals  |
| `Media/ScreenCaptures/` | Screen recording files. | Clips , Exported , Projects , RAW  |
| `Media/Videos/` | All video production material. | Assets , Projects , RAW , Rendered  |

---

### 💡 Guide and Tips for Using This Structure

#### **Raw Files & Input**

* **Import all original media** into their respective `RAW/` folders first.
    * For photos, use `Media/Photos/RAW/`.
    * For videos, use `Media/Videos/RAW/`.
    * For screen recordings, use `Media/ScreenCaptures/RAW/`.
* **Do not edit or delete files** directly from the `RAW/` folders. This ensures you always have the original source material.

#### **Creative Assets**

* **Place reusable assets** in `Media/Assets/`. For example:
    * Music tracks go in `Media/Assets/Music/`.
    * Fonts go in `Media/Assets/Fonts/`.
* **If an asset is *only* for Krita**, place it in `Media/Projects/Krita/Assets/` (e.g., specific Krita brushes or patterns).

#### **Projects & Editing**

* **Keep project files separate** from the media they use.
    * Kdenlive project files (`.kdenlive`) are stored in `Media/Projects/Kdenlive/ProjectFiles/` or `Media/Videos/Projects/`.
    * Original Krita project files (`.kra`) are in `Media/Projects/Krita/Originals/`.
* For video production, **B-roll, stock footage, or music** specific to a video project should be linked from `Media/Videos/Assets/`.

#### **Output & Export**

* **Export final, rendered media** to the designated `Exported/` or `Rendered/` folders.
    * Final videos go in `Media/Videos/Rendered/`.
    * Images for sharing/printing go in `Media/Photos/Exported/`.
    * Finished screen capture clips go in `Media/ScreenCaptures/Exported/`.
* **Backups of RAW photos** should be kept in `Media/Photos/Backup/`.
