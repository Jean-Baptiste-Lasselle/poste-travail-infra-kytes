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
```bash
deb http://deb.debian.org/debian stretch main
deb-src http://deb.debian.org/debian stretch main

deb http://deb.debian.org/debian-security/ stretch/updates main
deb-src http://deb.debian.org/debian-security/ stretch/updates main

deb http://deb.debian.org/debian stretch-updates main
deb-src http://deb.debian.org/debian stretch-updates main
```

À la fin de mon isntallation rapide, pedant laquelle j'ai refusé l'ajout de "miroirs" à la configuration du package manager, le contenu de `/etc/apt/sources.list` était : 

```bash
#

# deb cdrom:[Debian GNU/Linux 9.5.0 _Stretch_ - Official amd64 xfce-CD Binary-1 20180714-10:25]/ stretch main

deb cdrom:[Debian GNU/Linux 9.5.0 _Stretch_ - Official amd64 xfce-CD Binary-1 20180714-10:25]/ stretch main

deb http://security.debian.org/debian-security stretch/updates main
deb-src http://security.debian.org/debian-security stretch/updates main


```
J'ai commenté 
