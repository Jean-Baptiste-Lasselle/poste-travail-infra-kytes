# poste-travail-infra-kytes
la provision d'un poste de travail standard de dirigeant


- `/etc/hosts` : 

```bash
# Infra Marguerite
192.168.1.30    gitlab.marguerite.io marguerite.io 
192.168.1.30    rocketchat.marguerite.io marguerite.io

# Infra Marguerite / Meteor
# Marguerite's primary Docker Host Worker 
192.168.1.30 dockhost1.marguerite.io marguerite.io
# Marguerite's Meteor IDE Host 
192.168.1.30 meteor-ide.marguerite.io marguerite.io

# Infra Kytes
192.168.1.30    rocketchat.kytes.io
192.168.1.30    gitlab.kytes.io
# Hôte Docker, VM constituant l'infrastructure de déploiement.
192.168.1.30    production-docker-host-1.kytes.io
```

* package manager
Dans `/etc/apt/sources.list`


À la fin de mon isntallation rapide, pedant laquelle j'ai refusé l'ajout de "miroirs" à la configuration du package manager, le contenu de `/etc/apt/sources.list` était : 

```bash
#

# deb cdrom:[Debian GNU/Linux 9.5.0 _Stretch_ - Official amd64 xfce-CD Binary-1 20180714-10:25]/ stretch main

deb cdrom:[Debian GNU/Linux 9.5.0 _Stretch_ - Official amd64 xfce-CD Binary-1 20180714-10:25]/ stretch main

deb http://security.debian.org/debian-security stretch/updates main
deb-src http://security.debian.org/debian-security stretch/updates main


```
J'ai commenté une seule ligne, celle commençant par `deb cdrom`, ait laissé les deux mentionannt le serveur `security.debian.org`, puis ai ajouté en fin de fichier :
```bash
deb http://deb.debian.org/debian stretch main
deb-src http://deb.debian.org/debian stretch main

deb http://deb.debian.org/debian-security/ stretch/updates main
deb-src http://deb.debian.org/debian-security/ stretch/updates main

deb http://deb.debian.org/debian stretch-updates main
deb-src http://deb.debian.org/debian stretch-updates main
```

Ce qui m'a donné un fichier `/etc/apt/sources.list` exactement tel que ci-dessous : 

```bash
#

# deb cdrom:[Debian GNU/Linux 9.5.0 _Stretch_ - Official amd64 xfce-CD Binary-1 20180714-10:25]/ stretch main

deb cdrom:[Debian GNU/Linux 9.5.0 _Stretch_ - Official amd64 xfce-CD Binary-1 20180714-10:25]/ stretch main

deb http://security.debian.org/debian-security stretch/updates main
deb-src http://security.debian.org/debian-security stretch/updates main

deb http://deb.debian.org/debian stretch main
deb-src http://deb.debian.org/debian stretch main

deb http://deb.debian.org/debian-security/ stretch/updates main
deb-src http://deb.debian.org/debian-security/ stretch/updates main

deb http://deb.debian.org/debian stretch-updates main
deb-src http://deb.debian.org/debian stretch-updates main
```

## Problématiques de disques durs externes USB surlesquels des OS windows ont écrit

### Un problème courant: votre dique dur externe en `READ-ONLY`

Embêtant, pour un disque dur externe.

Votre disque dur externe a été monté automatiquement par debian. Vous le
verrez appraître dans le répertoire média de votre utlisateur, dont vous pouvez vérifier le chemin en exécutant : 
```bash
ls -all /media/$USER
echo " "
echo " => Vous êtes [$USER], et votre répertoire média est le répertoire [/media/$USER]"
echo " "
```
Repérez bien le répertoire dns lequel votre disque dur externe est automatiquement monté, de la manière suivante : 
* Débranchez (connecteur USB) votre disque dur externe, pusi exécutez : 
```bash
ls -all /media/$USER
```
Vous constaterez que ce répertoire (à moinsque vous n'ayez branché d'autres disque durs externes, ou autres pérohériques de type médias) est maintenant vide. Si ce n'est pas le cas, attendezs une petite secodne de plsu et réexcutez la commande `ls -all /media/$USER`
* Re-branchez votre disque dur externe USB à votre machine, pusi excutez encore `ls -all /media/$USER`: vous verrez apparaître un nouveau répertoire : Linux a créé ce répertoire, puis il a monté la partition principale (il pêut y en avoir plusieurs) de votre disque dur extrne sur ce répertoire (en tant que point de montage, aussi appelé `mount point` par nos collègues anglo-saxons).


Procédure testée (à réaliser avec un _utilisateur Linux administrateur_ ) : 
* D'abord, nous allons défaire ce que Linuxx a fait automatiquement : démonter la partition de votre disque dur externe qui a été montée sur le répertoire créé par Linux. :
  * Première étape, vérifier quel le nom de la partition de votre disque dur externe. Pour cela, utilisez la commande : 

   ```bash
   sudo fdisk -l
   df -Th
   ```

   Ce qui pour moi, par exemple, pour un poste particulier, j'ai obtenu comme affichage : 

```bash
jbl@pc-alienware-jbl:/media/jbl/point/montage$ df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  4.9G     0  4.9G   0% /dev
tmpfs          tmpfs    1000M   18M  982M   2% /run
/dev/sdf1      ext4       28G  2.3G   24G   9% /
tmpfs          tmpfs     4.9G   23M  4.9G   1% /dev/shm
tmpfs          tmpfs     5.0M  4.0K  5.0M   1% /run/lock
tmpfs          tmpfs     4.9G     0  4.9G   0% /sys/fs/cgroup
/dev/sdf6      ext4      237G   66G  159G  30% /home
tmpfs          tmpfs    1000M  4.0K 1000M   1% /run/user/108
tmpfs          tmpfs    1000M  8.0K 1000M   1% /run/user/1000
/dev/sde3      ext4      905G  354G  506G  42% /iaas
/dev/sdh1      fuseblk   466G  365G  101G  79% /media/jbl/point/montage
jbl@pc-alienware-jbl:/media/jbl/point/montage$ sudo fdisk -l 
[sudo] password for jbl: 
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
Disk identifier: 0x34fdd845

Device     Boot    Start       End   Sectors   Size Id Type
/dev/sdf1  *        2048  58593279  58591232    28G 83 Linux
/dev/sdf2       58595326 586072063 527476738 251.5G  5 Extended
/dev/sdf5       58595328  79544319  20948992    10G 82 Linux swap / Solaris
/dev/sdf6       79546368 586072063 506525696 241.5G 83 Linux




Disk /dev/sdh: 465.8 GiB, 500107861504 bytes, 976773167 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 33553920 bytes
Disklabel type: dos
Disk identifier: 0x77c975a2

Device     Boot Start       End   Sectors   Size Id Type
/dev/sdh1        2048 976769023 976766976 465.8G  7 HPFS/NTFS/exFAT
jbl@pc-alienware-jbl:/media/jbl/point/montage$ 

```
* Ci dessus, mon disque dur externe apparaît comme `/dev/sdh` : je l'ai vérifié, en nrachant/ débranchant mon disque dur externe.
* Ci dessus, mon disque dur externe apparaît comme `/dev/sdh`, on voit que ces utilsiateurs précédents ont foramté et utilisé 3 partitions `/dev/sdh1`, `/dev/sdh2`, `/dev/sdh3` .


* Ensuite, on va faire comme Debian (je ne prétends pas faire mieux, à la main), on va donc crééer un répertoire, dans `/media/$USER`, puis on va monter la partition que 'lon vient de démonter, sur ce nouveau répertoire. Mais au passage, comme nosu le faisons à la main, nous utiliserons toutes les optios à notre disposition, pour, avec l'utilisateur `root`, donner les droits en lecture / écriture sur cette partition, à l'utilisateur `$USER`. Bien. Pour terminer, il fautdera rendre ce paramétrage permaenent, si possible: que cette configuration persiste au re-démarage matériel.



```bash
# Je démonte la partition '/dev/sdh1', de mon disque dur externe '/dev/sdh'
sudo umount /dev/sdh1
# root prend la possession de tout ça,le temps des opérations système
sudo chown -R root:root /media/jbl
# il arrvie , selon le blend debian que vous vous êtes fait, que le package 'ntfs-3g' ne soit pas installé, je l'installe donc, et pusi je mets tout mon petit système en bonne santé, hein
sudo apt-get upgrade -y && sudo apt-get update -y && sudo apt-get install -y ntfs-3g
# Enfin, le remontage partition /dev/sdh1
sudo mount -t ntfs-3g /dev/sdh1 /media/jbl/point/montage/
# je rdonne la propriété aux propriétaire
sudo chown -R root:root /media/jbl
```

# FSTAB with UUIDs

```bash
echo "UUID=2c05271f-07db-462d-bbaa-c6f3216c15e6 /iaas ext4  errors=remount-ro 0 1" >> /etc/fstab
```
