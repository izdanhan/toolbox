
## Linux Terminal Cheat Sheet

This sheet covers fundamental commands for navigating, managing files, viewing content, and getting system info.

---

### **1. Navigation & Directory Listing**

*   **`pwd`** (Print Working Directory)
*   **Purpose:** Shows your current directory.
*   **Example:** `pwd` -> `/home/username/documents`

*   **`ls`** (List)
*   **Purpose:** Lists the contents of a directory.
*   **Examples:**
*   `ls` : Lists files and directories in the current directory.
*   `ls -l` : Long format (details: permissions, owner, size, date).
*   `ls -a` : Shows all files, including hidden ones (starting with `.`).
*   `ls -lh` : Long format, human-readable sizes (e.g., 1K, 234M, 2G).
*   `ls /path/to/directory` : Lists contents of a specific directory.

*   **`cd`** (Change Directory)
*   **Purpose:** Changes your current working directory.
*   **Examples:**
*   `cd myfolder` : Go into `myfolder` (if it's in the current directory).
*   `cd ..` : Go up one level (to the parent directory).
*   `cd ~` or `cd` : Go to your home directory.
*   `cd /` : Go to the root directory.
*   `cd /var/log` : Go to a specific absolute path.

*   **`clear`**
*   **Purpose:** Clears the terminal screen.

---

### **2. File & Directory Management**

*   **`mkdir`** (Make Directory)
*   **Purpose:** Creates a new directory.
*   **Example:** `mkdir new_project`

*   **`touch`**
*   **Purpose:** Creates an empty file or updates a file's timestamp.
*   **Example:** `touch my_file.txt`

*   **`cp`** (Copy)
*   **Purpose:** Copies files or directories.
*   **Examples:**
*   `cp file.txt /tmp` : Copies `file.txt` to the `/tmp` directory.
*   `cp file.txt new_file.txt` : Copies `file.txt` and renames the copy to `new_file.txt`.
*   `cp -r myfolder /backup` : Copies `myfolder` and all its contents (`-r` for recursive) to `/backup`.

*   **`mv`** (Move / Rename)
*   **Purpose:** Moves files/directories or renames them.
*   **Examples:**
*   `mv file.txt /tmp/documents` : Moves `file.txt` to the `/tmp/documents` directory.
*   `mv old_name.txt new_name.txt` : Renames `old_name.txt` to `new_name.txt`.

*   **`rm`** (Remove)
*   **Purpose:** Deletes files or directories. **Use with caution! There is no "recycle bin".**
*   **Examples:**
*   `rm file.txt` : Deletes `file.txt`.
*   `rm -r myfolder` : Deletes `myfolder` and its contents (`-r` for recursive).
*   `rm -rf important_stuff` : **EXTREMELY DANGEROUS!** `-f` (force) removes without prompting. Avoid using on critical system files or when unsure.

---

### **3. Viewing File Content**

*   **`cat`** (Concatenate)
*   **Purpose:** Displays the entire content of a file to the screen. Good for small files.
*   **Example:** `cat my_notes.txt`

*   **`less`**
*   **Purpose:** Displays file content page by page. Good for large files.
*   **Example:** `less large_log_file.log`
*   **Navigation:**
*   `Spacebar` or `f` : Scroll down one page.
*   `b` : Scroll up one page.
*   `/search_term` : Search forward for text.
*   `n` : Go to next search result.
*   `N` : Go to previous search result.
*   `q` : Quit `less`.

*   **`head`**
*   **Purpose:** Displays the beginning of a file (default: first 10 lines).
*   **Example:** `head my_file.txt`
*   `head -n 5 my_file.txt` : Displays the first 5 lines.

*   **`tail`**
*   **Purpose:** Displays the end of a file (default: last 10 lines). Useful for logs.
*   **Example:** `tail system.log`
*   `tail -n 20 system.log` : Displays the last 20 lines.
*   `tail -f system.log` : "Follows" the file, showing new lines as they are added (great for real-time logs). `Ctrl+C` to exit.

*   **`grep`**
*   **Purpose:** Searches for a pattern within files.
*   **Examples:**
*   `grep "error" access.log` : Finds lines containing "error" in `access.log`.
*   `grep -i "warning" syslog` : Finds lines containing "warning" (case-insensitive).
*   `grep -r "TODO" .` : Recursively searches for "TODO" in current directory and subdirectories.

---

### **4. System Information & Processes**

*   **`whoami`**
*   **Purpose:** Shows your current username.

*   **`ps`** (Process Status)
*   **Purpose:** Displays information about running processes.
*   **Example:** `ps aux` : Shows all running processes from all users.

*   **`top`**
*   **Purpose:** Displays a dynamic, real-time view of running processes, CPU usage, memory, etc.
*   **`q` to quit.**

*   **`df`** (Disk Free)
*   **Purpose:** Shows disk space usage for file systems.
*   **Example:** `df -h` : Shows human-readable sizes (e.g., GB, MB).

*   **`du`** (Disk Usage)
*   **Purpose:** Shows disk usage for files and directories.
*   **Example:**
*   `du -h myfolder` : Shows human-readable size for `myfolder`.
*   `du -sh myfolder` : Shows only the total human-readable size for `myfolder`.

*   **`free`**
*   **Purpose:** Displays information about free and used memory (RAM and swap).
*   **Example:** `free -h` : Shows human-readable sizes.

---

### **5. Permissions (Briefly)**

*   **`chmod`** (Change Mode)
*   **Purpose:** Changes file/directory permissions. (e.g., `chmod 755 script.sh` to make a script executable)
*   **Permissions are `rwx` (Read, Write, Execute) for User, Group, Others.**
*   **Common Numeric Modes:**
*   `7` (rwx)
*   `6` (rw-)
*   `5` (r-x)
*   `4` (r--)
*   **Example:** `chmod 755 myscript.sh` (User: rwx, Group: r-x, Others: r-x)
*   **Example:** `chmod +x myscript.sh` (Adds execute permission for all)

*   **`chown`** (Change Owner)
*   **Purpose:** Changes the owner and/or group of a file or directory.
*   **Example:** `chown user:group file.txt`

---

### **6. Networking (Basic)**

*   **`ping`**
*   **Purpose:** Tests connectivity to a network host.
*   **Example:** `ping google.com` (`Ctrl+C` to stop)

*   **`ip a`** (or `ifconfig` on older systems)
*   **Purpose:** Displays network interface information (IP addresses, etc.).

---

### **7. Getting Help**

*   **`man`** (Manual)
*   **Purpose:** Displays the manual page for a command. Very detailed.
*   **Example:** `man ls` (`q` to quit)

*   **`command --help`**
*   **Purpose:** Many commands offer a concise help message with common options.
*   **Example:** `ls --help`

---

### **8. Essential Tips & Tricks**

*   **Tab Completion:** Press `Tab` to auto-complete commands, file names, and directory names. Press `Tab` twice to see all available options.
*   **Command History:**
*   Use the **Up/Down arrow keys** to cycle through previous commands.
*   `history` : Shows a list of all commands you've entered.
*   `!N` : Executes command number `N` from history.
*   `!string` : Executes the most recent command starting with `string`.
*   **`sudo`** (Superuser Do)
*   **Purpose:** Executes a command with superuser (root) privileges. **Use with caution!**
*   **Example:** `sudo apt update`
*   **Redirection:**
*   `>` : Redirects command output to a file (overwrites the file).
*   `ls -l > file_list.txt`
*   `>>` : Appends command output to a file.
*   `echo "More text" >> file_list.txt`
*   `<` : Redirects file content as input to a command.
*   **Piping (`|`)**
*   **Purpose:** Sends the output of one command as the input to another command.
*   **Example:** `ls -l | less` : Lists directory contents and pipes them to `less` for page-by-page viewing.
*   **Example:** `cat access.log | grep "error" | wc -l` : Counts the number of "error" lines in `access.log`.
*   **Running Multiple Commands:**
*   `command1 ; command2` : Runs commands sequentially, regardless of success.
*   `command1 && command2` : Runs `command2` ONLY if `command1` succeeds.
*   `command1 || command2` : Runs `command2` ONLY if `command1` fails.
*   **Interrupting a Command:**
*   `Ctrl+C` : Stops the currently running command.

