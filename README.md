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
