To use Git with a private GitHub repository on Arch Linux, you first need to ensure your system is authenticated. Since it's a **private** repo, GitHub requires either an SSH key or a Personal Access Token (PAT).

### 1. Generate an SSH Key

SSH is the most convenient way to interact with private repos because it doesn't require typing a password every time you push.

1. **Generate the key:**
`ssh-keygen -t ed25519 -C "your_email@example.com"`
2. **Start the ssh-agent:**
`eval "$(ssh-agent -s)"`
3. **Add your key to the agent:**
`ssh-add ~/.ssh/id_ed25519`
4. **Copy the key to your clipboard:**
`cat ~/.ssh/id_ed25519.pub`

### 2. Add the Key to GitHub

1. Go to your GitHub **Settings** > **SSH and GPG keys**.
2. Click **New SSH key**, give it a title (e.g., "Arch Laptop"), and paste your key.

---

### 3. Basic Workflow Guide

Once authenticated, follow these steps to manage your project.

| Action | Command | Description |
| --- | --- | --- |
| **Setup** | `git clone git@github.com:username/repo-name.git` | Downloads your private repo to your machine. |
| **Track** | `git add .` | Adds all changed files to the "Staging Area." |
| **Save** | `git commit -m "Your message"` | Saves your changes locally with a description. |
| **Upload** | `git push origin main` | Sends your local commits to the private GitHub repo. |
| **Update** | `git pull origin main` | Fetches and merges changes from GitHub to your machine. |

---

### 4. Essential Tip: The `.gitignore` file

Since this is a private repo, you might be tempted to upload everything. **Don't.** Create a file named `.gitignore` in your root folder to prevent sensitive or unnecessary files (like `node_modules/`, `.env`, or compiled binaries) from being tracked.

**Example `.gitignore` for a typical project:**

```text
.env
*.log
dist/
target/
.vscode/

```

### 5. Using Git inside VS Code

Since you're using VS Code (or a variant):

1. Open your cloned folder.
2. Click the **Source Control** icon (the branch symbol) on the left sidebar.
3. You can stage files by clicking the **+** icon next to them and commit by typing a message in the box and hitting **Commit**.
4. Click **Sync Changes** to push/pull automatically.

Would you like help setting up the **GitHub Pull Requests and Issues** extension to manage your private repo directly inside VS Code?