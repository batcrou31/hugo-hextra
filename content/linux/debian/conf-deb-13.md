---
title: "Configuration de Debian 13"
sidebar:
  hide: true
---

[Debian](https://www.debian.org/) est une distribution Linux libre, stable et sécurisée, reconnue pour sa fiabilité et adaptée aussi bien aux serveurs qu'aux ordinateurs de bureau.

## Ressources Utiles

- ISO de **Debian 13** : https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/
- Outil de création de **clé bootable** : https://rufus.ie/ 

## Configuration Réseau
### Ajout d'une IP fixe
Pour modifier le fichier « interfaces », il faut effectuer la commande suivante :  

```
nano /etc/network/interfaces 
```
Contenu du fichier interfaces :  

Il sufit de changer le mode `dhcp` en `static` puis d'ajouter :  

```
address <adresse>/<masque>
gateway <adresse>
dns-nameservers <adresse1> <adresse2>
```

Afin que les modifications soit prise en compte, il faut redémarer le service réseau de la machine en effectuant :
```
systemctl restart networking.service
```

## Ajout des dépôts de mise à jour
Tout d'abord, il faut créer un nouveau dépôt :
```
nano /etc/apt/sources.list.d/debian.sources
```

Ajout des dépôts selon sa version :

{{< tabs >}}

  {{< tab name="Debian 13 (Trixie)" >}}
  ```
    Types: deb deb-src
    URIs: https://deb.debian.org/debian
    Suites: trixie trixie-updates
    Components: main non-free-firmware
    Enabled: yes
    Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

    Types: deb deb-src
    URIs: https://security.debian.org/debian-security
    Suites: trixie-security
    Components: main non-free-firmware
    Enabled: yes
    Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg  
  ```
  {{< /tab >}}

  {{< tab name="Debian 12 (Bookworm)" >}}
  ```
    deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
    deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

    # bookworm-security
    deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
    deb-src http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

    # bookworm-updates
    deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
    deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

    # bookworm-backports
    deb http://deb.debian.org/debian bookworm-backports main contrib non-free
    deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free
  ```
  {{< /tab >}}

{{< /tabs >}}

Puis enlever le support d'installation :

```
nano /etc/apt/sources.list
```
il faut rajouter un `#` avant le `deb cdrom:` :  


## Création de certificat SSH
Pour génerer un certificat, il faut d'abord ouvrir le Terminal en Administrateur dans Windows puis se déplacer dans le répertoire suivant :
```
cd .ssh 
```
entrer la commande suivante :
```
ssh-keygen -t rsa -b 2048 
```  


Il faut ensuite spécifier :

- le nom (test_rsa)
- la passphrase (optionel)

Ensuite, sur la machine linux il faut aller dans le dossier `.ssh` :
```
cd .ssh 
```
ou si le dossier n'existe pas :
```
mkdir .ssh 
```
puis créer un fichier nommé `authorized_keys` et coller tout le contenu du fichier `test.pub` créer précédament :
```
nano authorized_keys
```
Il faut ensuite retourner dans le dossier `.ssh` sur l'hôte Windows et créer un fichier `config`  

Contenu du fichier :
```
Host test
HostName <adresse>
IdentityFile ~/.ssh/test_rsa
User root
```
Pour finir, vous pouvez maintenant vous conecter en SSH sur vos machine sans mots de passe !
```
ssh test
```

## Divers
### Authentification du SSH avec l'utilisateur `root`

```
nano /etc/ssh/sshd_config
```
puis modifier la valeur :

```
PermitRootLogin yes
```
  


pour finir, redémarer le service ssh :
```
systemctl restart ssh
```

### Installation de l'agent Qemu sur hôte debian

Installer le service :

```
apt-get install qemu-guest-agent
```

Démarrer le service :
```
systemctl start qemu-guest-agent
```

Activer le démarage auto du service :
```
systemctl enable qemu-guest-agent
```
