# VirtualBox AMD-V Error Fix

This is a very common error when using VirtualBox on a Linux host, especially with an AMD processor (indicated by **AMD-V** and **VERR\_SVM\_IN\_USE**).

The error message is telling you that the **KVM** (Kernel-based Virtual Machine) kernel module is currently using the hardware virtualization feature (**AMD-V**, or SVM for Secure Virtual Machine) on your AMD processor. Because KVM is a hypervisor that is already running, VirtualBox, which is another hypervisor, cannot access the same exclusive hardware feature at the same time.

Since you want to use VirtualBox, you need to prevent the KVM module from loading.

Here are the steps to fix this, starting with the simplest temporary solution and moving to a permanent one:

### 1\. Temporary Fix (Unload the KVM Module)

You can unload the KVM modules for your current session. This will allow you to run VirtualBox until your next reboot.

1.  **Check if KVM is loaded:**

    ```bash
    lsmod | grep kvm
    ```

    You should see lines for `kvm_amd` and `kvm`.

2.  **Unload the modules:**

      * Since you have an AMD processor, use `kvm_amd` first, followed by `kvm`.

    <!-- end list -->

    ```bash
    sudo rmmod kvm_amd
    sudo rmmod kvm
    ```

      * If you had an Intel processor, you would use `kvm_intel`.

3.  **Start VirtualBox:**
    Try launching your virtual machine now. It should work.

-----

### 2\. Permanent Fix (Blacklist KVM Modules)

To prevent KVM from loading every time you reboot, you should **blacklist** the modules. This is the recommended long-term solution if you primarily use VirtualBox.

1.  **Create a blacklist file:**
    Open a new file in the `/etc/modprobe.d/` directory using your preferred text editor (like `nano` or `vim`).

    ```bash
    sudo nano /etc/modprobe.d/blacklist-kvm.conf
    ```

2.  **Add the blacklist entries:**
    Add the following two lines to the file to blacklist both the generic KVM module and the AMD-specific one:

    ```
    blacklist kvm_amd
    blacklist kvm
    ```

    Save the file and exit the editor.

3.  **Update the initial ramdisk (Initramfs):**
    This step ensures that the blacklist is applied early in the boot process.

    ```bash
    sudo update-initramfs -u
    # or
    # sudo dracut -f (for some distributions like Fedora/RHEL)
    ```

4.  **Reboot your system:**

    ```bash
    sudo reboot
    ```

After the reboot, the KVM modules should not be loaded, and VirtualBox should be able to access the AMD-V extension without the `VERR_SVM_IN_USE` error.

### ⚠️ Alternative Check: Docker or Other Virtualization Software

If you have software like **Docker Desktop** or another hypervisor (such as **virt-manager** or **libvirt**) installed, they often use KVM to run their virtual machines.

  * If you use **Docker Desktop**, you may need to stop its service before running VirtualBox:
    ```bash
    sudo systemctl stop docker-desktop
    ```
  * You might also check and stop the `libvirtd` service if you have `libvirt` installed:
    ```bash
    sudo systemctl stop libvirtd
    ```
