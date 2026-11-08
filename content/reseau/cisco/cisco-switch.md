---
title: Configuration de base sur un commutateur Cisco
sidebar:
  hide: true
---

## Accès à l’interface de configuration
- Brancher le port console sur le port série de votre appareil CISCO,  

- Sur votre ordinateur lancer/installer <a href="https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html" target="_blank" rel="noopener noreferrer">Putty</a> avec la configuration suivante :

Diriger la connexion vers le port COM choisi en 1,

- Choisir un débit de **9600 bit/s**
- **8 bits** de données
- **Pas de parité**
- **1 bit** de stop

## Configuration du Switch

**Passage en mode privilégié :**

```
Enable
```

> [!NOTE]
> pour entrer dans le mode privilégié. La validation de cette commande entraîne souvent la demande d’un mot de passe.

## Visualisation des informations de configuration
### Commandes courantes  

Lister **la configuration en cours d’utilisation** du switch :

```
show running-config
```  

Lister **la configuration au démarrage** du switch :  

```
show startup-config
```  

**Visualiser les VLANs présents sur le switch** ainsi que les ports membres de chaque VLAN :  

```
show vlan
```  

Lister **toutes les options possibles de la commande show** :  

```
sh ?
```

## Sauvegarde et restauration des fichiers de configuration  

On peut utiliser la commande `copy` pour **copier une configuration en mémoire** ou **récupérer une configuration à partir de la mémoire ou d’ailleurs**.

Copie de **la configuration en train de fonctionner** vers **la mémoire de démarage** :  

```
Copy running-config startup-config
```  

Copie de **la mémoire de démarage** vers **la configuration en train de fonctionner** :  

```
Copy startup-config running-config
```  


**Copie d'un fichier à partir d'un serveur tftp vers la mémoire de démarage** :  

```
Copy tftp startup-config
```  

**Sauvegarder la configuration présente dans la mémoire vers un serveur tftp** :  

```
Copy startup-config tftp
```  

## Modification de la configuration
Pour modifier la configuration, taper la commande :  

```
config terminal
```
À ce niveau on peut taper des commandes valables pour l’ensemble du switch par exemple :  

```
hostname nom_du_switch
```

> [!NOTE]
> Cette commande permet de donner un nom au switch. *Exemple :* `hostname router1`

## Adressage IP  

Chaque VLAN sur le switch est considéré comme une `interface` du switch que l’on pourra configurer au niveau IP.
**Par défaut le switch est constitué d’un seul VLAN.**  

Rentrer dans le **mode de configuration de l’interface vlan1** :
```
Interface vlan1
```
> [!TIP]+ Aide
> Lorsque l’on a configuré une interface et que l’on veut retourner au niveau de configuration supérieur
> (pour pouvoir accéder à la configuration d’une autre interface par exemple) il suffit de taper la
> commande `exit`.  

Les commandes les plus utilisées dans la configuration des interfaces sont les suivantes :

```
Ip address adresse_ip_de_l’interface masque_de_sous_réseau
```
> [!NOTE]
> *Exemple :* `ip address 172.168.16.1 255.255.240.0`

Indiquer également que cette interface ne doit pas être inactive :  

```
No shutdown
```  

## Les VLANs

Rentrer dans le menu de configuration :  

```
Configure terminal
```  

Créer le VLAN :
```
Vlan X
```
> [!NOTE]
> *X étant le N° du VLAN à créer ou à configurer.* Un VLAN par défaut existe, il s’agit du **N°1**.  

Nommer ce VLAN :
```
Name Nom_du_vlan
```
> [!NOTE]
> *Exemple :* `Name Vlan10`  

Ensuite il faut affecter les ports aux vlans.

### Aplication des VLANs sur un port en mode `TRUNK`
**Le mode trunk permet de transmetre des données provenant de plusieurs VLAN.**  

Exemple avec le port **N°1** :

```
interface fa0/1
switchport mode trunk 
no shutdown
exit
```
> [!NOTE]
> Il est également possible de spécifier les VLANs car par défaut **toutes les VLANs peuvent passer sur un port trunk**.
>
> *Exemple :* Les VLANs 20, 30 et 99 font partie du trunk sur le port N°1
>
> ```
> interface fa0/1
> switchport mode trunk 
> switchport trunk allowed vlan 20,30,99
> no shutdown
> exit
> ```  

### Aplication des VLAN sur un port en mode `ACCES`
**Le mode acces permet de transmetre des données au sein d'un même VLAN.**  

Exemple avec le port **N°2** et le **VLAN 10** :

``` 
interface fa0/2
switchport access vlan 10 
no shutdown
exit
``` 

## Configuration du SSH
- `hostname sw1` : Nom d'hôte
- `ip domain-name baptiste` : Nom de domaine
- `crypto key generate rsa` : Générer un certificat pour la connexion SSH (2048 bits)  

``` 
ip ssh version 2
line vty 0 4
transport input ssh
login local
``` 
- `username baptiste password 123456` :  

> [!WARNING]+ Attention
> Ne pas oublier d'enregistrer la conf sur le switch. commande pour écrire la configuration sur le switch :
>
> ```
> wr
> ```

Commande pour **se connecter en ssh depuis Windows sur un équipement cisco** :
```
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedAlgorithms=+ssh-rsa -oCiphers=+3des-cbc -oMACs=+hmac-sha1 nom_d_utilisateur@adresse_ip
```

> [!WARNING]+ Attention
> Penser à changer `nom_d_utilisateur@adresse_ip` créé à l'étape précedente.

## Remise à plat du switch
Commande de **mise en configuration d’usine du switch** :  

```
write erase
delete flash:vlan.dat
reload
copy run start
``` 
