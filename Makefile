.PHONY: help install typst-version pdf watch clean docker-check toss-env toss-config toss-up toss-down toss-logs toss-health

TOSS_DIR := tools/TOSS
TOSS_URL := http://127.0.0.1:8080

help:
	@printf '%s\n' \
		'Targets:' \
		'  make install        Install the pixi environment' \
		'  make pdf            Compile report/main.typ to report/main.pdf' \
		'  make watch          Watch and recompile report/main.typ' \
		'  make clean          Remove generated PDF' \
		'  make toss-env       Create tools/TOSS/.env from .env.example' \
		'  make toss-config    Validate the TOSS docker-compose config' \
		'  make toss-up        Start local TOSS at http://127.0.0.1:8080' \
		'  make toss-down      Stop local TOSS' \
		'  make toss-logs      Follow TOSS logs' \
		'  make toss-health    Check TOSS health endpoint'

install:
	pixi install

typst-version:
	pixi run typst-version

pdf:
	pixi run pdf

watch:
	pixi run watch

clean:
	pixi run clean

docker-check:
	@docker info >/dev/null 2>&1 || (printf '%s\n' 'Docker daemon is not running. Start Docker Desktop or the Docker service, then retry.' && exit 1)

toss-env:
	test -f "$(TOSS_DIR)/.env" || cp "$(TOSS_DIR)/.env.example" "$(TOSS_DIR)/.env"

toss-config: toss-env
	cd "$(TOSS_DIR)" && docker compose config >/dev/null

toss-up: docker-check toss-env
	cd "$(TOSS_DIR)" && docker compose up --build -d
	@printf 'TOSS: %s\n' "$(TOSS_URL)"

toss-down: docker-check
	cd "$(TOSS_DIR)" && docker compose down

toss-logs: docker-check
	cd "$(TOSS_DIR)" && docker compose logs -f core-api

toss-health:
	curl -fsS "$(TOSS_URL)/health"
