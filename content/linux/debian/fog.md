---
title: "Installation et configuration d'un serveur FOG'"
sidebar:
  hide: true
---

[FOG](https://fogproject.org/) (Free and Open-source Ghost) est une solution libre de déploiement et de clonage de postes en réseau.

{{< callout type="warning" >}}
  Effectuez le tuto suivant avant de passer à la suite : [Configuration de Debian 13](../conf-deb-13)
{{< /callout >}}

## Prérequis

- Un __Serveur DHCP__ (si vous ne souhaitez pas utiliser celui de FOG, voir tuto [ISC-DHCP](../isc-dhcp)) 

## Installation de FOG

### Téléchargement/décompression du package

Naviguez dans l'emplacement de votre choix, par exemple le répertoire `home` :

```
cd /home
```

Téléchargement du package :

```
wget https://github.com/FOGProject/fogproject/archive/stable.tar.gz
```

Décompréssion du package :

```
tar -xzvf stable.tar.gz
```

### Installation de FOG

Lancement du script d'installation :

```
cd fogproject-stable/bin
```
```
./installfog.sh
```

Sélectionner votre distribution Linux :

![](/images/debian/fog/FOG-1.png)

Sélectionner `N` pour une installation normale de FOG :

![](/images/debian/fog/FOG-2.png)

Sélectionner `N` si vous ne souhaitais pas configurer votre carte réseau :

![](/images/debian/fog/FOG-3.png)

Configuration du serveur DHCP de FOG :

> [!NOTE]
> Si vous ne souhaitez pas utiliser le server DHCP de FOG, sélectionner `N` pour les 3 questions suivante.

![](/images/debian/fog/FOG-4.png)

Sélectionner `Y` afin de pouvoir mettre en francais l'interface web :

![](/images/debian/fog/FOG-5.png)

Sélectionner `N` si vous ne souhaitais pas avtiver le protocle HTTPS pour l'interface web :

![](/images/debian/fog/FOG-5-2.png)

Sommaire de la configuration éfectué précedement :

![](/images/debian/fog/FOG-6.png)

Pendant l'installation, il faut se connecter à l'interface web de fog :

![](/images/debian/fog/FOG-DB1.png)

puis, il faut sélectionner `Install/Update Now` afin de finaliser l'installation de la base de donnée.

![](/images/debian/fog/FOG-DB_2.png)

Une fois redirigé sur la page de conexion, il faut revenir dans votre terminal et faire la touche `Entrée`.

![](/images/debian/fog/FOG-LOG.png)

Une fois l'installation terminée, il reste plus qu'à se connecter avec les identifiants par défauts :

![](/images/debian/fog/FOG-7.png)

## Configuration de FOG

### Création d'un utilisateur
Pour créer un nouvelle utilisateur, il faut se diriger dans : `User > Create New User`.

![](/images/debian/fog/FOG-USER1.png)

### Enregistrement d'une machine
Pour enregistrer une nouvelle machine, il vous sufit de démarer sur le réseau (Généralement `F12`) et de sélectionner `Quick registration and inventory`.  

![](/images/debian/fog/FOG-REG2.png)

Une fois que la machine à redémarer vous pouvez l'éteindre.  

Pour enregistrer l'image, il vous sufit d'aller dans : `Image Management -> Create New Image`. Puis modifier les valeurs selon le système d'exploitation.

![](/images/debian/fog/FOG-IMG.png)

Ensuite, il faut associer l'image créer à la machine :

![](/images/debian/fog/FOG-IMG2.png)
![](/images/debian/fog/FOG-IMG3.png)

## 4 Sources

- <a href="https://docs.fogproject.org/en/latest/" target="_blank" rel="noopener noreferrer">docs.fogproject.org</a>
- <a href="https://docs.fogproject.org/en/1.5.9/" target="_blank" rel="noopener noreferrer">docs.fogproject.org (old)</a>
---