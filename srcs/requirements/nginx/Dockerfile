
FROM		debian:buster

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        nginx \
        vim \
        curl \
    && 

# RUN apt update && apt upgrade -y && apt install nginx -y vim -y curl -y
# RUN			apk update && apk upgrade && apk add	\
# 							openssl			\
# 							nginx			\
# 							curl			\
# 							vim				\
# RUN			rm -f /etc/nginx/nginx

# COPY		./config/nginx.conf /etc/nginx/nginx.conf

# COPY		scripts/setup_nginx.sh /setup_ngi

# RUN			chmod -R +x /setup_ngi

# EXPOSE

# ENTRYPOINT	["sh", "setup_nginx.sh"]