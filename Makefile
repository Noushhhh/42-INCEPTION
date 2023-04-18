DOCKER-COMPOSE = docker-compose -f srcs/docker-compose.yml

MARIADB_VOLUME = /home/ana/data/mariadb
WORDPRESS_VOLUME = /home/ana/data/wordpress

all: up

$(MARIADB_VOLUME):
	mkdir -p $(MARIADB_VOLUME)

$(WORDPRESS_VOLUME):
	mkdir -p $(WORDPRESS_VOLUME)

up:
		@printf "Build, recreate, start containers\n"
		$(DOCKER-COMPOSE) up -d --build

build:
			@printf "Build images from dockerfiles\n"
			$(DOCKER-COMPOSE) build

start:
			@printf "Start built containers\n"
			$(DOCKER-COMPOSE) start

restart:
			@printf "Restart built containers\n"
			$(DOCKER-COMPOSE) restart

stop:
			@printf "Stop containers (main process receive SIGTERM)\n"
			$(DOCKER-COMPOSE) stop

down:
			@printf "Stop and remove containers, networks\n"
			sudo $(DOCKER-COMPOSE) down --rmi all --volumes --remove-orphans

ps:
			@printf "List containers\n"
			$(DOCKER-COMPOSE) ps

images:
			@printf "List images\n"
			docker images

volumes:
			@printf "List volumes\n"
			docker volume ls

clean: 
		$(DOCKER-COMPOSE) down --rmi all --volumes --remove-orphans

fclean: clean
		@printf "Remove images, containers and volumes.\n"
		sudo rm -rf /home/ana/data/*

prune: fclean
		@printf "Remove all unused containers, images and volumes\n"
		sudo docker system prune -f -a

re: fclean all

.PHONY: all up build start restart stop down ps images volume clean fclean prune re.phony