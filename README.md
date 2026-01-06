# Traefik Docker Proxy

Setup Traefik ultra-pro pour gérer tes containers en local et en production avec du HTTPS automatique.

## 🚀 Installation Rapide

1. **Préparer le réseau Docker**
   ```bash
   make network
   ```

2. **Configurer l'email (pour Let's Encrypt en prod)**
   ```bash
   echo "EMAIL=votre-email@exemple.com" > .env
   ```

## 🛠️ Utilisation

### Mode Local (Développement)
Lance Traefik sans SSL, avec le dashboard accessible sur le port 8080.
```bash
make local
```
- **Dashboard** : [http://localhost:8080](http://localhost:8080)
- **Points d'entrée** : Port 80 (HTTP)

### Mode Production
Lance Traefik avec gestion automatique des certificats SSL (Let's Encrypt) et redirection HTTP -> HTTPS.
```bash
make prod
```
- **Points d'entrée** : Port 80 (Redir) & Port 443 (HTTPS)
- **Dashboard** : Accessible sur le port 8080 (Pensez à votre Firewall !)

### Arrêter les services
```bash
make down
```

## 📁 Structure du Projet

- `docker-compose.yaml` : La base commune (Image, Docker Socket, Réseaux).
- `docker-compose.local.yaml` : Override pour le dev (Dashboard insecure, HTTP).
- `docker-compose.prod.yaml` : Override pour la prod (SSL Let's Encrypt, Redirection HTTPS).
- `makefile` : Tes raccourcis pour ne pas taper de commandes à rallonge.

## 📦 Ajouter un projet (Exemple)

Pour exposer un nouveau container via Traefik, utilise ces labels dans ton `docker-compose.yaml` :

```yaml
services:
  mon-app:
    image: nginx:alpine
    labels:
      - "traefik.enable=true"
      # Route HTTP
      - "traefik.http.routers.mon-app.rule=Host(`mon-app.localhost`)"
      - "traefik.http.routers.mon-app.entrypoints=web"
      # Pour la PROD (SSL)
      - "traefik.http.routers.mon-app-secure.rule=Host(`mon-app.fr`)"
      - "traefik.http.routers.mon-app-secure.entrypoints=websecure"
      - "traefik.http.routers.mon-app-secure.tls=true"
      - "traefik.http.routers.mon-app-secure.tls.certresolver=myresolver"
    networks:
      - traefik-net

networks:
  traefik-net:
    external: true
```
