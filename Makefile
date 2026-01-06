network:
	@docker network create traefik-net

up:
	@docker compose up -d

down:
	@docker compose down

start:
	@docker compose start

stop:
	@docker compose stop