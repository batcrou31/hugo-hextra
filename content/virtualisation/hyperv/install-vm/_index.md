---
title: "Installation d'une machine virtuelle"
sidebar:
  hide: true
---

![](/images/virtualisation/cover-hyperv-install-vm.png)

## Création de la VM

Après avoir lancer le **Gestionnaire Hyper-V**, dans le panneau latéral situé à droite dans l'onglet **Actions**, sélectionnez `Nouveau > Ordinateur virtuel` :

![](/images/virtualisation/hyperv/INSTALL-00.png)

Sélectionnez **Suivant** :

![](/images/virtualisation/hyperv/INSTALL-01.png)

Donnez un nom à la machinne virtuelle, dans cette exemple *FEDORA-CIEL*  

Cochez **Stocker l'ordinateur virtuel à un autre emplacement** puis entrez le nom du répertoire sur lequel vous souhaitez stocker votre VM, dans cette exemple *D:\HYPER-V* : 

![](/images/virtualisation/hyperv/INSTALL-02.png)

> [!NOTE]
> Il est possible dans Hyper-V de definir un emplacement par défaut pour les machines virtuelles, dans l'onglet **Actions**, sélectionner Paramètres **Hyper-V**, puis selectionner l'emplacement de votre choix dans la catégorie **Disque durs virtuels** et **Ordinateurs virtuels**.
> ![](/images/virtualisation/hyperv/CONFIG-VM-DISK.png)

Sélectionnez la **Géneration 2** pour la machine virtuelle :

![](/images/virtualisation/hyperv/INSTALL-03.png)

Sélectionnez la quantité de mémoire à allouer pour la machine virtuelle et cochez **Utiliser la mémoire dynamique pour cet ordinateur virtuel** :

![](/images/virtualisation/hyperv/INSTALL-04.png)

Sélectionnez la carte réseau pour votre machine virtuelle, dans cette exemple *Externe* : 

![](/images/virtualisation/hyperv/INSTALL-05.png)

Pour le disque dur virtuel, sélectionnez **Attacher un disque dur virtuel ultérieurement** car par défaut Hyper-V ne créer pas de disque dur dynamique.

![](/images/virtualisation/hyperv/INSTALL-06.png)

Maintenant, sélectionnez **Suivant** pour passer en revue la configuration effectuer jusqu'a présent afin de s'assurer qu'il n'y est pas de faute ou d'erreur.

![](/images/virtualisation/hyperv/INSTALL-07.png)

Puis pour finir, sélectionnez **Terminer**.

## Configuration de la VM

Sélectionnez la machine virtuelle créer précedement, puis dans le panneau latéral situé à droite dans l'onglet **Actions**, sous le nom de la VM, sélectionnez **Paramètres** :

![](/images/virtualisation/hyperv/CONFIG-VM-01.png)

Pour l'action d'arrêt automatique, sélectionnez **Arrêter le système d'exploitation invité** :

![](/images/virtualisation/hyperv/CONFIG-VM-02.png)

Pour l'action de démarrage automatique, sélectionnez le mode qui corespond à votre besoin :

- Rien *(il ne passe rien ;-;)*
- Démarer automatiquemenet s'il était en cours d'éxecution... *(si il était allumer, il s'allume sinon il ne s'allume pas)*
- Toujours démarrer cet ordinateur virtuel automatiquement *(démarre la VM automatiquement au démarage de l'hôte hyper-v)*

dans cette exemple, *Rien* car c'est une VM de test qui est allumer occasionnellement : 

![](/images/virtualisation/hyperv/CONFIG-VM-03.png)

Dans l'onglet points de contrôle, Décochez l'option **Utiliser des points de contrôle automatiques** :

![](/images/virtualisation/hyperv/CONFIG-VM-04.png)

Dans Services d'integrations, Décochez l'option **Synchronisation date/heure** :

![](/images/virtualisation/hyperv/CONFIG-VM-05.png)

### Ajout d'un disque dur virtuel

Sélectionner **Disque dur** puis **Ajouter** :

![](/images/virtualisation/hyperv/CONFIG-VM-06.png)

Cochez **Disque dur virtuel** puis **Nouveau** :

![](/images/virtualisation/hyperv/CONFIG-VM-07.png)

Pour le type de disque, sélectionnez **Taille dynamique** :

![](/images/virtualisation/hyperv/CONFIG-VM-08.png)

Ensuite, donnez un nom et sélectionner l'emplacement de votre dossier ou se trouve votre VM : 

![](/images/virtualisation/hyperv/CONFIG-VM-09.png)

Sélectionner ensuite la taille voulue, puis faire **Terminer** :

![](/images/virtualisation/hyperv/CONFIG-VM-10.png)

### Ajout d'une image ISO

Sélectionner **Lecteur de DVD** puis **Ajouter** :

![](/images/virtualisation/hyperv/CONFIG-VM-11.png)

Sélectionner **Fichier image** puis **Parcourir** :

![](/images/virtualisation/hyperv/CONFIG-VM-12.png)

Ensuite, sélectionner le modèle pour l'UEFI selon le système d'exploitation de l'invité. dans cette exemple, *Autorité de certification UEFI Microsoft* car l'invité est Fedora.

![](/images/virtualisation/hyperv/CONFIG-VM-13.png)

> [!NOTE]
> Si votre machine virtuelle est une architecture de type Windows, laisser le modèle par défaut **Microsoft Windows**
> Si votre machine virtuelle est une architecture de type Linux *(Debian, Fedora etc...)*, basculer le modèle vers **Autorité de certification UEFI Microsoft**
> Si votre machine virtuelle est une architecture de type FreeBSD, Linux plus encien ou si l'option précédente ne fonctionne pas, sélectionnez **Machine virtuelle dotée d'une protection maximale Open Source**

Pour le Microprogramme :

- Monter le **disque dur en première position**
- Descendre le **lecteur DVD en seconde position**
- laisser la **carte réseau en dernière position**

![](/images/virtualisation/hyperv/CONFIG-VM-14.png)