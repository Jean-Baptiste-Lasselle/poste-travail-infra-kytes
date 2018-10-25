#!/bin/bash
echo "ATTENTION!!!!! CE FICHIER N'A PAS ETE TESTE !!! N'eSSAYEZ PAS D'EXECUTER SON CODE HORS D'UNE VM IMAGE DE VOTRE MACHINE PHYSIQUE!!! "
exit 0


bobby@pc-alienware-jib:~/VirtualBox VMs$ sudo fdisk -l
[sudo] password for bobby: 
Disk /dev/sde: 931.5 GiB, 1000204886016 bytes, 1953525168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x76055135

Device     Boot    Start        End    Sectors   Size Id Type
/dev/sde1             63      80324      80262  39.2M de Dell Utility
/dev/sde2  *       81920   23564287   23482368  11.2G  7 HPFS/NTFS/exFAT
/dev/sde3       23564288 1953521663 1929957376 920.3G  7 HPFS/NTFS/exFAT


Disk /dev/sdf: 279.5 GiB, 300069052416 bytes, 586072368 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x20d43d49

Device     Boot     Start       End   Sectors   Size Id Type
/dev/sdf1  *         2048 565121023 565118976 269.5G 83 Linux
/dev/sdf2       565123070 586072063  20948994    10G  5 Extended
/dev/sdf5       565123072 586072063  20948992    10G 82 Linux swap / Solaris


bobby@pc-alienware-jib:~/VirtualBox VMs$ mkdir -p /iaas
mkdir: cannot create directory ‘/iaas’: Permission denied
bobby@pc-alienware-jib:~/VirtualBox VMs$ sudo mkdir -p /iaas
bobby@pc-alienware-jib:~/VirtualBox VMs$ sudo fdisk /dev/sde3

Welcome to fdisk (util-linux 2.29.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): m

Help:

  DOS (MBR)
   a   toggle a bootable flag
   b   edit nested BSD disklabel
   c   toggle the dos compatibility flag

  Generic
   d   delete a partition
   F   list free unpartitioned space
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table
   i   print information about a partition

  Misc
   m   print this menu
   u   change display/entry units
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


Command (m for help): d
Partition number (1-4, default 4): 

Partition 4 has been deleted.

Command (m for help): d
Partition number (1-3, default 3): 

Partition 3 has been deleted.

Command (m for help): d
Partition number (1,2, default 2): 

Partition 2 has been deleted.

Command (m for help): d
Selected partition 1
Partition 1 has been deleted.

Command (m for help): d
No partition is defined yet!
Could not delete partition 1

Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Re-reading the partition table failed.: Invalid argument

The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).

bobby@pc-alienware-jib:~/VirtualBox VMs$ df -TH
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  5.3G     0  5.3G   0% /dev
tmpfs          tmpfs     1.1G   11M  1.1G   1% /run
/dev/sdf1      ext4      284G  209G   61G  78% /
tmpfs          tmpfs     5.3G   85M  5.2G   2% /dev/shm
tmpfs          tmpfs     5.3M  4.1k  5.3M   1% /run/lock
tmpfs          tmpfs     5.3G     0  5.3G   0% /sys/fs/cgroup
tmpfs          tmpfs     1.1G   17k  1.1G   1% /run/user/116
tmpfs          tmpfs     1.1G   37k  1.1G   1% /run/user/1000
bobby@pc-alienware-jib:~/VirtualBox VMs$ df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  4.9G     0  4.9G   0% /dev
tmpfs          tmpfs    1000M  9.8M  990M   1% /run
/dev/sdf1      ext4      265G  195G   57G  78% /
tmpfs          tmpfs     4.9G   81M  4.9G   2% /dev/shm
tmpfs          tmpfs     5.0M  4.0K  5.0M   1% /run/lock
tmpfs          tmpfs     4.9G     0  4.9G   0% /sys/fs/cgroup
tmpfs          tmpfs    1000M   16K 1000M   1% /run/user/116
tmpfs          tmpfs    1000M   36K 1000M   1% /run/user/1000
bobby@pc-alienware-jib:~/VirtualBox VMs$ 

sudo mkfs.ext4 /dev/sde3

mount /dev/sde3 /iaas
sudo -s
echo ""
