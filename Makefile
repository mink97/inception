all:
	mkdir -p /home/mingkang/data/mariadb
	mkdir -p /home/mingkang/data/wordpress
	@docker compose -f ./srcs/docker-compose.yaml up --build -d

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean:
	@docker stop `docker ps -qa`; \
	docker rm -f `docker ps -qa`; \
	docker rmi -f `docker images -qa`; \
	docker volume rm -f `docker volume ls -q`; \
	docker network prune -f;

fclean:
	make clean
	sudo rm -rf /home/mingkang/data

re:
	make fclean
	make all

.PHONY: all re down clean fclean
