---
title: "Installation et configuration de TigerVNC sur un environnement de bureau Xfce"
date: 2026-11-08T00:00:00+00:00
lastmod: 2026-11-08T00:00:00+00:00
sidebar:
  hide: true
---

## Prérequis

- Un **système Debian** avec un <a href="https://www.xfce.org/" target="_blank" rel="noopener noreferrer">environnement de bureau Xfce</a>
- Une **connexion SSH**

## Installation

### Installation des paquets
Mises à jour/installation des paquets de TigerVNC :
``` bash
sudo apt update && sudo apt install tigervnc-standalone-server tigervnc-common dbus-x11 -y
```

![](/images/debian/tiger_vnc/VNC-1.PNG)

## Configuration
### Définition d'un mot de passe VNC
Maintenant il faut définir un mot de passe de connexion pour TigerVNC avec la commande suivante :
``` bash
vncpasswd
```

> [!NOTE]
> Le maximum est de 8 caractères, il est également possible de définir un mot de passe pour l'affichage en lecture seule.

![](/images/debian/tiger_vnc/VNC-2.PNG)

### Configuration du lancement Xfce dans TigerVNC
Création/édition du fichier `xstartup` :
``` bash
mkdir -p ~/.vnc
nano ~/.vnc/xstartup
```
Contenu du fichier `xstartup` :

``` Bash {filename="/.vnc/xstartup"}
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
```
Puis il faut rendre le fichier exécutable :

``` bash
chmod +x ~/.vnc/xstartup
```

### Test du serveur
Toujours dans le terminal, entrez la commande suivante :
``` bash
vncserver :1 -localhost no -geometry 1920x1080 -depth 24
```

> [!NOTE]+ Note
> Commande pour vérifier l'état du service :
>
> - L'argument `:1` correspond au port `5901` (**:1 = 5900+1**, **:2 = 5900+2**, etc...)
> - L'argument `-localhost no` autorise les connexions distantes.
> - L'argument `-geometry` permet de modifier la résolution de l'écran. 

Dans le client VNC de votre choix, entrez l'adresse IP ainsi que l'identifiant (Nom de la machine par exemple).  

Exemple avec [RealVNC Viewer](https://www.realvnc.com/fr/connect/download/viewer/) :

![](/images/debian/tiger_vnc/VNC-3.PNG)

Accepter le message d'avertissement :

![](/images/debian/tiger_vnc/VNC-4.PNG)

> [!WARNING]+ Attention
> VNC n'est pas chiffré par défaut, pour un accès distant via internet vous pouvez utiliser un VPN ou mettre en place un bastion comme [Apache Guacamole](https://guacamole.apache.org/)

Puis, entrez le mot de passe créé précédemment :

![](/images/debian/tiger_vnc/VNC-5.PNG)

Résultat dans VNC Viewer : 

![](/images/debian/tiger_vnc/VNC-7.PNG)

La commande suivante est pour arrêter le server VNC :
``` bash
vncserver -kill :1
```

### Création du service avec systemd
Création du fichier `/etc/systemd/system/vncserver@.service`
``` bash
sudo nano /etc/systemd/system/vncserver@.service
```
Contenu du fichier `vncserver@.service` :
``` ini
[Unit]
Description=Remote desktop service (VNC) - %i
After=syslog.target network.target

[Service]
Type=simple
User=NOM_D'UTILISATEUR
WorkingDirectory=/home/NOM_D'UTILISATEUR
PIDFile=/home/TON_USER/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver :%i -localhost no -geometry 1920x1080 -depth 24 -fg
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
```

> [!NOTE]
> Pensez à remplacer `NOM_D'UTILISATEUR` par l'utilisateur de la session VNC
    
Activation/démarrage du service créé précédemment

```
sudo systemctl daemon-reload
sudo systemctl enable --now vncserver@1.service
```
