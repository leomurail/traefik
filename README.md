# Traefik Docker Project

This project sets up Traefik as a reverse proxy using Docker Compose.

## Prerequisites

- Docker
- Docker Compose

## Getting Started

1. **Create the network**
```bash
make network
```

1. **Start the services:**
```bash
make up
```

2. **Access the Traefik Dashboard:**
Open [http://localhost:8080](http://localhost:8080) in your browser.



## Configuration

The configuration is defined in `compose.yaml`.

- **Traefik**: Listens on port 80 (web) and 8080 (dashboard).
- **Docker Provider**: Automatically discovers containers with `traefik.enable=true` labels.

## Stopping

To stop the services and remove the containers:

```bash
make down
```

## Adding a New Project

To add a new project (e.g., a web app) and expose it via Traefik:

1.  **Network**: Ensure your project's service is connected to the `traefik-net` network.
2.  **Labels**: Add the necessary Traefik labels to your service.

Example `compose.yaml` for a new project:

```yaml
services:
  my-app:
    image: nginx:alpine
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.my-app.rule=Host(`myapp.localhost`)"
      - "traefik.http.routers.my-app.entrypoints=web"
    networks:
      - traefik-net

networks:
  traefik-net:
    external: true
```

See `demo-app/compose.yaml` for a working example.
"

This tells the container that `api.keep-up.local` resolves to the host machine's IP, allowing the request to hit Traefik on port 80.

