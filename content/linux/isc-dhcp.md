---
title: ISC-DHCP
cascade:
  type: docs
---

[ISC-DHCP](https://www.isc.org/dhcp/) est un serveur DHCP (Dynamic Host Configuration Protocol) permettant l'attribution des adresses IP ainsi que des paramètres de configuration aux équipements d'un réseau.

## 1 - Installation du service

```
apt update && apt install isc-dhcp-server -y
```

## 2 - Configuration
### Modification de l'interface réseau

Modification de l'interface réseau :

```
nano /etc/default/isc-dhcp-server
```
Modifiez la valeur `eth0` selon le nom votre carte réseau :
```
INTERFACESv4="eth0"
```  

{{< details title="Afficher la configuration de la carte réseau" closed="true" >}}

```
cat /etc/network/interfaces
```

{{< /details >}}

### Configuration du serveur DHCP
```
nano /etc/dhcp/dhcpd.conf
```
Exemple de configuration de base :

``` Bash {filename="/etc/dhcp/dhcpd.conf"}
# Paramètres globaux
default-lease-time 86400;       # 24h
max-lease-time 172800;          # 48h
ddns-update-style standard;
authoritative;

# Déclaration du sous-réseau
subnet 192.168.1.0 netmask 255.255.255.0 {            # Adresse du réseau/masque  
  range 192.168.1.101 192.168.1.199;                  # Adresse de début/fin
  option routers 192.168.1.254;                       # Adresse du routeur
  option domain-name-servers 192.168.1.254, 8.8.8.8;  # Adresse du/des Serveurs de noms
  option domain-name "home";
}
```

Exemple de configuration pour [FOG](https://fogproject.org/) (UEFI + BIOS):

``` Bash {filename="/etc/dhcp/dhcpd.conf"}
# Paramètres globaux
default-lease-time 86400;       # 24h
max-lease-time 172800;          # 48h
ddns-update-style standard;
next-server 192.168.1.20;       # Adresse de votre serveur TFTP
authoritative;

# Déclaration du sous-réseau
subnet 192.168.1.0 netmask 255.255.255.0 {            # Adresse du réseau/masque  
  range 192.168.1.101 192.168.1.199;                  # Adresse de début/fin
  option routers 192.168.1.254;                       # Adresse du routeur
  option domain-name-servers 192.168.1.254, 8.8.8.8;  # Adresse du/des serveurs de noms
  option domain-name "home";

  class "UEFI-32-1" {
  match if substring(option vendor-class-identifier, 0, 20) = "PXEClient:Arch:00006";
  filename "i386-efi/ipxe.efi";
  }

  class "UEFI-32-2" {
  match if substring(option vendor-class-identifier, 0, 20) = "PXEClient:Arch:00002";
   filename "i386-efi/ipxe.efi";
  }

  class "UEFI-64-1" {
  match if substring(option vendor-class-identifier, 0, 20) = "PXEClient:Arch:00007";
   filename "ipxe.efi";
  }

  class "UEFI-64-2" {
  match if substring(option vendor-class-identifier, 0, 20) = "PXEClient:Arch:00008";
  filename "ipxe.efi";
  }

  class "UEFI-64-3" {
  match if substring(option vendor-class-identifier, 0, 20) = "PXEClient:Arch:00009";
   filename "ipxe.efi";
  }

  class "Legacy" {
  match if substring(option vendor-class-identifier, 0, 20) = "PXEClient:Arch:00000";
  filename "undionly.kkpxe";
  }

}
```

### Modification du service ISC-DHCP

Ajout du redémarage automatique du service :
```
systemctl enable isc-dhcp-server
systemctl stop isc-dhcp-server
systemctl edit --full isc-dhcp-server
```

Ajouter la valeur suivante haut dessus de la partie `[Unit]`:

``` bash
[Install]
WantedBy=multi-user.target
```

Ensuite, remplacer la valeur `Restart=no` par :

- `Restart=always` ou `Restart=on-failure`

Exemple :
``` bash
[Service]
Type=forking
Restart=on-failure
RestartSec=60s
TimeoutSec=5min
IgnoreSIGPIPE=no
KillMode=process
GuessMainPID=no
RemainAfterExit=yes
SuccessExitStatus=5 6
ExecStart=/etc/init.d/isc-dhcp-server start
```

Rédémarage et activation du service :

``` bash
systemctl daemon-reload
systemctl enable isc-dhcp-server
systemctl start isc-dhcp-server
```
!!! note "Information importante"
    Commande pour vérifier l'état du service :
    ```
    systemctl is-enabled isc-dhcp-server
    systemctl status isc-dhcp-server
    ```

## 3 - Commandes utiles
```
systemctl start isc-dhcp-server
systemctl stop isc-dhcp-server
systemctl restart isc-dhcp-server
systemctl status isc-dhcp-server
```

---
