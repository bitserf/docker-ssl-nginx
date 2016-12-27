all: ssl-nginx
ssl-nginx:
	docker build -t ssl-nginx .
