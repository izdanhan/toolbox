Setting up a Network File System (NFS) is the standard way to share directories between Linux machines on a local network. Here is a guide to set up the **NFS Server** on your Ubuntu 24.04 (Linux Mint 22.3) machine and the **NFS Client** on your other Linux computers.

*Before you begin, make sure you know the local IP address of the NFS Server machine (e.g., `192.168.1.100`) and the IP addresses/subnet of your other Linux computers (e.g., `192.168.1.0/24`).*

-----

## 🖥️ NFS Server Setup (Your Ubuntu/Mint Machine)

### 1\. Install NFS Server Package

Open a terminal on your Ubuntu 24.04/Linux Mint 22.3 machine and run the following command to install the NFS server package:

```bash
sudo apt update
sudo apt install nfs-kernel-server
```

### 2\. Configure Directory Exports

You need to edit the `/etc/exports` file to specify which directories to share and which clients are allowed to access them.

1.  Open the file with a text editor:

    ```bash
    sudo nano /etc/exports
    ```

2.  Add the following lines to the end of the file. Replace `192.168.1.0/24` with the IP address range of your client computers (or use a specific IP address if you only have one client).

    ```conf
    /mnt/alpha/Videos 192.168.1.0/24(rw,sync,no_subtree_check)
    /mnt/beta 192.168.1.0/24(rw,sync,no_subtree_check)
    ```

      * **`/mnt/alpha/Videos`** and **`/mnt/beta`**: The absolute paths to the directories you want to share.
      * **`192.168.1.0/24`**: The client machine(s) allowed to access the share.
      * **`rw`**: Grants read and write access to the client. Use `ro` for read-only.
      * **`sync`**: Forces changes to be written to disk before replying to the client (more reliable, slightly slower).
      * **`no_subtree_check`**: Disables subtree checking, which can prevent problems when a shared directory is a subdirectory of a larger filesystem.

3.  Save and close the file. In `nano`, press **Ctrl+O**, then **Enter**, then **Ctrl+X**.

### 3\. Apply Exports and Restart Service

Apply the new export settings and restart the NFS server to load the configuration:

```bash
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```

### 4\. Adjust Firewall (UFW)

If you are using the UFW firewall (which is common), you need to allow incoming NFS connections.

To allow access for the specific subnet you used in `/etc/exports`:

```bash
sudo ufw allow from 192.168.1.0/24 to any port nfs
sudo ufw enable # Only if the firewall is not already active
```

*Replace `192.168.1.0/24` with your client IP range/subnet.*

-----

## 💻 NFS Client Setup (Your Other Linux Computers)

For each client machine, follow these steps to access the shared directories.

### 1\. Install NFS Client Package

Install the necessary client package:

```bash
sudo apt update
sudo apt install nfs-common
```

### 2\. Create Local Mount Points

Create local directories where the remote shares will be mounted. These directories will be the access points for the shared files.

```bash
sudo mkdir -p /mnt/nfsshare/alpha_videos
sudo mkdir -p /mnt/nfsshare/beta
```

### 3\. Mount the Shares (Temporary)

To test the connection, perform a temporary mount. Replace `192.168.1.100` with your **NFS Server's IP address**.

```bash
# Mount the Videos share
sudo mount 192.168.1.100:/mnt/alpha/Videos /mnt/nfsshare/alpha_videos

# Mount the Beta share
sudo mount 192.168.1.100:/mnt/beta /mnt/nfsshare/beta
```

You can check if the mounts were successful by running `df -h` or checking the contents of the local mount points:

```bash
ls /mnt/nfsshare/alpha_videos
```

### 4\. Mount Permanently (Optional but Recommended)

To ensure the shares are mounted automatically every time the client computer boots up, edit the `/etc/fstab` file.

1.  Open the file with a text editor:

    ```bash
    sudo nano /etc/fstab
    ```

2.  Add the following lines to the end of the file. Replace `192.168.1.100` with your **NFS Server's IP address**.

    ```conf
    # NFS Shares from Server
    192.168.1.100:/mnt/alpha/Videos /mnt/nfsshare/alpha_videos nfs defaults,timeo=900,retrans=5,_netdev 0 0
    192.168.1.100:/mnt/beta /mnt/nfsshare/beta nfs defaults,timeo=900,retrans=5,_netdev 0 0
    ```

      * **`_netdev`**: Ensures the mount is attempted *after* the network is up.

3.  Save and close the file.

4.  To test the `fstab` entries without rebooting, run:

    ```bash
    sudo mount -a
    ```

If you need a visual guide on setting up the NFS server and client, you might find this video helpful: [How to Install and Configure an NFS Linux Server and Client](https://www.youtube.com/watch?v=zmDIfJtCKCk).

Would you like me to help you verify your IP addresses or troubleshoot any specific steps?

http://googleusercontent.com/youtube_content/0
