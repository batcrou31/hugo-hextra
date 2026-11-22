---
title: "Installation d'une machine virtuelle"
sidebar:
  hide: true
---

![](/images/virtualisation/cover-hyperv-install-vm.png)

## Création de la VM

Après avoir lancer le **Gestionnaire Hyper-V**, dans le panneau latéral situé à droite dans l'onglet **Actions**, sélectionner `Nouveau > Ordinateur virtuel` :

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

Pour le disque dur virtuel, sélectionner **Attacher un disque dur virtuel ultérieurement** car par défaut Hyper-V ne créer pas de disque dur dynamique.

![](/images/virtualisation/hyperv/INSTALL-06.png)

Maintenant, sélectionnez **Suivant** pour passer en revue la configuration effectuer jusqu'a présent afin de s'assurer qu'il n'y est pas de faute ou d'erreur. Puis pour finir, sélectionnez **Terminer**.

![](/images/virtualisation/hyperv/INSTALL-07.png)