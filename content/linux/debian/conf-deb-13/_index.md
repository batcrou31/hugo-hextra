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

![](/images/debian/conf-deb/inter.png)

Il sufit de changer le mode `dhcp` en `static` puis d'ajouter les 3 lignes suivantes :  

```
address <adresse>/<masque>
gateway <adresse>
dns-nameservers <adresse1> <adresse2>
```

> [!NOTE]
> *Exemple :* 
>
> ```
> address 192.168.1.10/24
> gateway 192.168.1.254
> dns-nameservers 192.168.1.254 8.8.8.8
> ```

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

``` Bash {filename="/etc/apt/sources.list.d/debian.sources"}
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

Puis enlever le support d'installation :

```
nano /etc/apt/sources.list
```  

il faut rajouter un `#` avant le `deb cdrom:` :  

![](/images/debian/conf-deb/sup.png)

## Création de certificat SSH

> [!WARNING]+ Attention
> Les manipulations suivante sont à effectuer sur **Windows** !

Pour génerer un certificat, il faut d'abord ouvrir un Terminal en Administrateur puis se placer dans le répertoire suivant :
```
cd .ssh 
```
Ensuite, entrez la commande suivante suivant pour générer un certificat `rsa` de 2048 bits:  

```
ssh-keygen -t rsa -b 2048 
```  

Il faut ensuite spécifier :

- le nom `test_rsa` / puis faire `Entrée` pour la passphrase

![](/images/debian/conf-deb/certif.png)

Contenu du dossier `.ssh` :

![](/images/debian/conf-deb/certif-1.png)

> [!WARNING]+ Attention
> Les manipulations suivante sont à effectuer sur **Linux** !

Ensuite il faut aller dans le dossier `.ssh` :
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

> [!WARNING]+ Attention
> Les manipulations suivante sont à effectuer sur **Windows** !

Il faut ensuite retourner dans le dossier `.ssh` créer un fichier `config`  

Contenu du fichier :
```
Host test
HostName <adresse>
IdentityFile ~/.ssh/test_rsa
User root
```
Pour finir, vous pouvez maintenant vous conecter en SSH sur vos machines sans mots de passe !
```
ssh test
```

### Facultatif
{{< details title="Supprimer l'authentification par mot de passe de l'utilisateur `ROOT`" closed="true" >}}
étant donner que l'on peut ce connecter grâce à un certificat, ont peut supprimer l'authentification par mots de passe de l'utilisateur `ROOT` :

``` Bash {filename="/etc/ssh/sshd_config"}
PermitRootLogin prohibit-password
```
pour finir, redémarer le service ssh : 

``` Bash
systemctl restart ssh
```  

{{< /details >}}  

## Divers
### Authentification du SSH avec l'utilisateur `root`

``` Bash
nano /etc/ssh/sshd_config
```
puis modifier la valeur :

``` Bash
PermitRootLogin yes
```
  
![](/images/debian/conf-deb/rootlog.png)

pour finir, redémarer le service ssh :  

``` Bash
systemctl restart ssh
```

### Installation de l'agent Qemu sur debian

Installer le service :

``` Bash
apt-get install qemu-guest-agent
```

Démarrer le service :  

``` Bash
systemctl start qemu-guest-agent
```

Activer le démarage auto du service :
``` Bash
systemctl enable qemu-guest-agent
```
### Liste de commande linux

{{< pdf "./commande-linux.pdf" >}}
