# Cities Skylines 1: Essential Mods

To make Cities: Skylines 1 viable without losing your mind over structural mechanics and traffic AI, you need a highly specific baseline of mods.

*Note: Since CS1 is in its legacy state, many older foundational mods are broken or abandoned. Ensure you subscribe to the exact, updated versions listed below on the Steam Workshop.*

### 1. Hard Core Engine & Optimization (Mission-Critical)

Before adding any content, you must fix the game’s resource optimization.

* **Harmony (Mod Dependency):** Absolute baseline library required for almost all modern mods to execute code injections cleanly.
* **Patch Loader Mod + FPS Booster:** Drastically improves framerates by decoupling the UI rendering from the core simulation loop.
* **Loading Screen Mod Revisited:** Optimizes RAM consumption by allowing assets to share duplicate textures and meshes. Crucial for keeping your 32 GB RAM from choking under a heavy DLC load.

### 2. Traffic & Infrastructure Correction

* **TM:PE V11 STABLE (Traffic Manager: President Edition):** The most critical mod in CS1. Replaces the broken pathfinding with advanced routing AI, allows lane-by-lane speed limits, priority signs, custom traffic lights, and manually assigned lane connectors to stop vehicles from utilizing a single lane for miles.
* **Network Anarchy:** Overrides strict native constraints (e.g., "Slope too steep," "Space already occupied"). Essential for clean highway merges and complex overpasses.
* **Network Multitool:** Adds specialized tools to create perfect circles, parallel roads, smooth slopes, and seamless lane merges without trial-and-error manual rebuilding.

### 3. Manipulation & Management

* **Move It:** Allows you to select *anything* (roads, buildings, nodes, trees) and shift, elevate, rotate, or duplicate it. Saves hundreds of hours when fixing imperfectly snapped geometry.
* **Find It! 2:** Substitutes the highly inefficient vanilla build menu with a searchable, tagged database of every asset and prop in your game.
* **81 Tiles 2:** Unlocks the entire map area instead of the restrictive vanilla 9 or 25 tile limits. The modern version also handles electricity and water logic passing natively through roads to reduce utility clutter.

### 4. Macro-Simulation Tuning

* **Realistic Population 2:** Overhauls the game's absurd zoning math. In vanilla, a massive skyscraper holds 20 people and a tiny house holds 15. This mod scales population realistically based on physical building volume, forcing you to design actual high-density transit infrastructure for high-density areas.
* **Lifecycle Rebalance Revisited:** Prevents the infamous "Death Waves" (where thousands of citizens who moved in at the exact same time die simultaneously, bankrupting your healthcare system) by randomizing age, health, and vehicle ownership vectors.

## How to transfer mods from Steam install to Bottles install

To inject your Steam Workshop mods into a non-Steam installation running inside a Bottles prefix, you have to manually copy the workshop content into the specific Windows-structured path that Bottles exposes.

Cities: Skylines 1 looks for local mods and custom assets inside its `%LOCALAPPDATA%` folder structure. Here is how to map and transfer them on Ubuntu.

### Step 1: Locate the Source (Steam Workshop Files)

Steam downloads all workshop items into a centralized, numbered directory separate from the main game. On your host system, open a terminal or your file manager and navigate to:

```bash
~/.local/share/Steam/steamapps/workshop/content/255710/

```

*(Note: `255710` is the Steam application ID for Cities: Skylines 1).*

Inside this folder, you will see a collection of folders named with long strings of numbers (e.g., `2814654513`). Each folder represents a unique mod or asset.

### Step 2: Locate the Target (Bottles Prefix)

Bottles replicates a standard Windows filesystem inside an isolated sandbox. You need to find the Virtual `C:` drive for the specific bottle you installed CS1 in.

Navigate to your Bottles data directory:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/bottles/[YOUR_BOTTLE_NAME]/drive_c/users/ab/Local Settings/Application Data/Colossal Order/Cities_Skylines/

```

*(Replace `[YOUR_BOTTLE_NAME]` with the actual name you gave your bottle. `ab` is the default username Bottles generates inside the prefix).*

### Step 3: Create the Addons Directory

If you have not installed mods locally inside this bottle before, the required subdirectories will not exist yet. Navigate into that target `Cities_Skylines` folder and create two separate folders exactly as spelled:

1. **`Mods`** (For code-altering tools like TM:PE, Move It, Harmony).
2. **`Addons`** $\rightarrow$ inside it, create a folder named **`Assets`** (For custom buildings, vehicles, roads, and props).

### Step 4: Map and Copy the Content

You cannot just dump everything into one folder; CS1 expects mods to be in separate folders containing their respective `.dll` files, while assets (`.crp` files) belong grouped together.

* **For Code Mods (e.g., TM:PE, Network Anarchy, Move It):**
Take the numbered folder from Steam (the whole folder, not just the contents) and paste it directly into the target `Mods` directory:
```text
.../Cities_Skylines/Mods/[Numbered_Folder]/[Mod_Files].dll

```


* **For Custom Assets & Buildings:**
Open the numbered workshop folders containing `.crp` files. Copy the `.crp` files directly into your target `Assets` folder. They do not need to stay in individual numbered subfolders.
```text
.../Cities_Skylines/Addons/Assets/[Asset_Name].crp

```



Once copied, boot the game via Bottles, head directly to the **Content Manager** from the main menu, and manually enable the transferred modifications under the **Mods** and **Assets** tabs.
