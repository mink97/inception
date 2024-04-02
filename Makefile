all:
	mkdir -p ./srcs/data/mariadb 
	mkdir -p ./srcs/data/wordpress
	@docker compose -f ./srcs/docker-compose.yaml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yaml down

clean:
	@docker stop `docker ps -qa`; \
	docker rm -f `docker ps -qa`; \
	docker rmi -f `docker images -qa`; \
	docker volume rm `docker volume ls -q`; \
	docker network prune -f;

fclean:
	make clean
	rm -rf ./srcs/data

re:
	make fclean
	make all

.PHONY: all re down clean fclean