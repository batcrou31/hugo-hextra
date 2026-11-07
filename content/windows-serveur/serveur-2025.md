---
title: "Serveur 2025"
---

## Divers

### Création d'une carte réseau virtuelle pour Hyper-V  

{{< callout type="info" >}}
  Il faut d'abord créer un commutateur virtuel **LAN HYPER-V** dans **Gestionnaire de serveur > Serveur local > Association de cartes réseau**.
{{< /callout >}}

Schéma explicatif :  

![serveur](SRV22_CR.png)

``` PowerShell
New-VMSwitch -Name "Externe" -NetAdapterName "LAN HYPER-V" -AllowNetlbfoTeams $true -AllowManagement $true
```