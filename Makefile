network:
	@docker network create traefik-net || true

# Local
local:
	@docker compose -f docker-compose.yaml -f docker-compose.local.yaml up -d

# Production
prod:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d

down:
	@docker compose down

stop:
	@docker compose stop

start:
	@docker compose start