---
title: "Apache Guacamole avec base de donnée MySQL"
sidebar:
  hide: true
---

![](/images/compose/cover-guacamole.png)

[Apache Guacamole](https://guacamole.apache.org/) est une passerelle de bureau à distance sans client. Elle prend en charge les protocoles standards tels que VNC, RDP et SSH.

## Prérequis

- **Docker** avec le plugin **compose**
- Une **connexion SSH**

## Fichier docker compose

> [!NOTE]
> Pour ce service, il est nécessaire de créer en amont un réseau docker :
> ``` bash
> docker network create guacamole
> ```

Fichier docker compose :  

- Exemple de paramètre facultatif dans la section ``environment`` de ``guacamole`` : https://guacamole.apache.org/doc/gug/guacamole-docker.html

``` yaml {filename="guacamole-compose.yaml"}
services:
    guacamole_db:
        image: mysql
        container_name: guacamole_db
        hostname: guacamole_db
        environment:
            - MYSQL_ROOT_PASSWORD=${mysql_root_password_654321}
            - MYSQL_DATABASE=guacamole_db
            - MYSQL_USER=admin
            - MYSQL_PASSWORD=${mysql_password_123456}
        volumes:
            - /home/docker/appdata/guacamole/guacamole_db:/var/lib/mysql
        restart: unless-stopped
        expose:
            - 3306
            
    guacd:
        container_name: guacd
        hostname: guacd
        image: guacamole/guacd:latest
        restart: always
        volumes:
            - /home/docker/appdata/guacamole/guacd/guacd_drive:/drive:rw
            - /home/docker/appdata/guacamole/guacd/guacd_record:/record:rw
        expose:
            - 4822

    guacamole:
        container_name: guacamole
        hostname: guacamole
        restart: always
        image: guacamole/guacamole:latest
        depends_on:
            - guacamole_db
            - guacd
        ports:
            - 8081:8080 # défaut 8080:8080
        links:
            - guacd
        environment:
            - GUACD_HOSTNAME=guacd
            - MYSQL_HOSTNAME=guacamole_db
            - MYSQL_DATABASE=guacamole_db
            - MYSQL_USER=admin
            - MYSQL_PASSWORD=${mysql_password_123456}
            - TOTP_ENABLED=false
            - BAN_ENABLED=true 
            - WEBAPP_CONTEXT=ROOT

networks:
  guacamole:
    external: true
```

{{< details title="Fichier compose configuré avec Traefik" closed="true" >}}

``` yaml {filename="guacamole-compose-traefik.yaml"}
services:
    guacamole_db:
        image: mysql
        container_name: guacamole_db
        hostname: guacamole_db
        environment:
            - MYSQL_ROOT_PASSWORD=${mysql_root_password_654321}
            - MYSQL_DATABASE=guacamole_db
            - MYSQL_USER=admin
            - MYSQL_PASSWORD=${mysql_password_123456}
        networks:
            - guacamole
        volumes:
            - /home/docker/appdata/guacamole/guacamole_db:/var/lib/mysql
        restart: unless-stopped
        expose:
            - 3306
            
    guacd:
        container_name: guacd
        hostname: guacd
        image: guacamole/guacd:latest
        restart: always
        networks:
            - guacamole
        volumes:
            - /home/docker/appdata/guacamole/guacd/guacd_drive:/drive:rw
            - /home/docker/appdata/guacamole/guacd/guacd_record:/record:rw
        expose:
            - 4822

    guacamole:
        container_name: guacamole
        hostname: guacamole
        restart: always
        image: guacamole/guacamole:latest
        depends_on:
            - guacamole_db
            - guacd
        ports:
            - 8081:8080 # défaut 8080:8080
        links:
            - guacd
        environment:
            - GUACD_HOSTNAME=guacd
            - MYSQL_HOSTNAME=guacamole_db
            - MYSQL_DATABASE=guacamole_db
            - MYSQL_USER=admin
            - MYSQL_PASSWORD=${mysql_password_123456}
            - REMOTE_IP_VALVE_ENABLED=true
            - TOTP_ENABLED=false
            - BAN_ENABLED=true
            - WEBAPP_CONTEXT=ROOT
        labels:
            - traefik.enable=true
            - traefik.docker.network=traefik
            - traefik.http.services.guacamole.loadbalancer.server.port=8080
            - traefik.http.routers.guacamole-https.rule=Host(`guacamole.exemple.fr`)
            - traefik.http.routers.guacamole-https.entrypoints=websecure
            - traefik.http.routers.guacamole-https.tls=true
            - traefik.http.routers.guacamole-https.tls.certresolver=ovhcloud
        networks:
            - traefik
            - guacamole
        
networks:
  guacamole:
    external: true
  traefik:
    external: true
```

{{< /details >}}

Démarez une première fois votre stack, puis l'éteindre juste après ``(UP/DOWN)``.  

## Installation

### Initialisation de la base de donnée

Dans un terminal SSH, naviguez dans le répertoire commun des conteneurs docker ``(/home/docker/appdata)``.  

Entrez la commande suivante afin de genérer le script de configuration de la base de donnée : 

``` bash
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql
```

puis cette commande pour l'integrer dans le conteneur docker mysql : 

``` bash
docker exec -i guacamole_db mysql --user admin --password=${mysql_password_123456} guacamole_db < initdb.sql
```

Ensuite rendez vous sur l'interface web d'Apache Guacamole, et saisissez les identifiants par défaut : 

- Identifiant : **guacadmin**
- Mot de passe : **guacadmin**

### Création d'un utilisateur

Dans le coin superieur droit, sélctionner **Paramètres** :

![](/images/compose/guacamole/APG-01.png)

Sous l'onglet **Utilisateurs**, sélectionner **Nouvel Utilisateur** :

![](/images/compose/guacamole/APG-02.png)

Ensuite, il faut entrer un **identifiant** et son **mot de passe** puis **cochez toutes les permisions** :

![](/images/compose/guacamole/APG-03.png)

Pour finir, il faut se déconnecter de l'utilisateur **guacadmin** et se reconnecter avec l'utilisateur créé précédemment, puis retourner dans l'onglet **Utilisateurs** et sélectionner l'utilisateur **guacadmin** :

![](/images/compose/guacamole/APG-04.png)

Puis sélectionner **Supprimer**.

## Conexion d'un hôte RDP

Dans le coin superieur droit, sélctionner **Paramètres** :

![](/images/compose/guacamole/APG-01.png)

Sous l'onglet **Connexions**, sélectionner **Nouvelle Connexions** :

![](/images/compose/guacamole/APG-06.png)

Renseignez les infomrations suivantes : *(à adapter selon votre configuration)* 

![](/images/compose/guacamole/APG-08.png)  
![](/images/compose/guacamole/APG-09.png)

## Conexion d'un hôte VNC

{{< details title="Manipulation pour RealVNC Server" closed="true" >}}

Sur votre poste client RealVNC Server, assurez vous d'avoir :

- **ProtocolVersion** en **3.8**

![](/images/compose/guacamole/APG-VNC-02.png)

- Chiffrement : **De préferance inactif**
- Authentification : **Mot de passe VNC**
- Cochez : **Autorise la connexion d'utilisateur VNC Viewer herités**

![](/images/compose/guacamole/APG-VNC-01.png)
{{< /details >}}

Dans le coin superieur droit, sélctionner **Paramètres** :

![](/images/compose/guacamole/APG-01.png)

Sous l'onglet **Connexions**, sélectionner **Nouvelle Connexions** :

![](/images/compose/guacamole/APG-06.png)

Renseignez les infomrations suivantes : *(à adapter selon votre configuration)* 

![](/images/compose/guacamole/APG-07.png)

---

## Configuration du Wake-on-LAN

Par défaut, il n'est pas possible qu'un conteneur docker puisse diffuser les packets WOL en broadcast car le réseau bridge docker est isolé. Il faut donc **modifier directement la configuration de l'interface bridge guacamole**.  

Sur votre terminal SSH, listeé les réseaux docker avec la commande suivante :

``` bash
docker network list
```
Il faut maintenant copier l'ID du réseau **guacamole** : 

![](/images/compose/guacamole/APG-SSH-01.png)

Pour finir, entrez les commandes suivante :

``` bash
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=0
sysctl -w net.ipv4.conf.all.bc_forwarding=1
sysctl -w net.ipv4.conf.br-${ID_Reseau_guacamole}.bc_forwarding=1
```

> [!NOTE]
> dans cette exemple, ``${ID_Reseau_guacamole}`` est à remplacer par : ``df352d45cbd3`` ce qui donne :
> ``` bash
> sysctl -w net.ipv4.conf.br-df352d45cbd3.bc_forwarding=1
> ```

puis pour rendre cette configuration opérationelle pour les prochains redémarage : 

``` bash

echo 'net.ipv4.icmp_echo_ignore_broadcasts=0' | tee /etc/sysctl.d/97-docker-broadcast.conf
echo 'net.ipv4.conf.all.bc_forwarding=1' | tee -a /etc/sysctl.d/97-docker-broadcast.conf
echo 'net.ipv4.conf.br-${ID_Reseau_guacamole}.bc_forwarding=1' | tee /etc/sysctl.d/99-docker-bridge-guacamole.conf
```

Enfin, dans Apache Guacamole ``(Paramètres > Connexions)``, sélectionner l'hôte que vous souhaitez démarrer par WOL et effectuer la configuration suivante :

![](/images/compose/guacamole/APG-SSH-02.png)