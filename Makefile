#------------------------------------------------------------------------------#
#								   GENERAL									   #
#------------------------------------------------------------------------------#

RM = sudo rm -rf
DC = sudo docker compose

# Définir une variable pour les images
IMAGE_MARIADB = $(shell docker images -q srcs-mariadb)
IMAGE_WORDPRESS = $(shell docker images -q srcs-wordpress)
IMAGE_NGINX = $(shell docker images -q srcs-nginx)

# Définir si IMAGES va être une string vide ou non
IMAGES = 
ifneq ($(IMAGE_MARIADB),)
    IMAGES += $(IMAGE_MARIADB)
endif
ifneq ($(IMAGE_WORDPRESS),)
    IMAGES += $(IMAGE_WORDPRESS)
endif
ifneq ($(IMAGE_NGINX),)
    IMAGES += $(IMAGE_NGINX)
endif

# Définir une variable pour les conteneurs
CONTAINER_MARIADB = $(shell docker ps -aq --filter "name=mariadb")
CONTAINER_WORDPRESS = $(shell docker ps -aq --filter "name=wordpress")
CONTAINER_NGINX = $(shell docker ps -aq --filter "name=nginx")
CONTAINERS = $(CONTAINER_MARIADB) $(CONTAINER_WORDPRESS) $(CONTAINER_NGINX)

# Définir une variable pour les volumes
VOLUME_MARIADB = $(shell docker volume ls --quiet --filter "name=srcs_mariadb")
VOLUME_WORDPRESS = $(shell docker volume ls --quiet --filter "name=srcs_wordpress")

# Définir si IMAGES va être une string vide ou non
VOLUMES = 
ifneq ($(VOLUME_MARIADB),)
    VOLUMES += $(VOLUME_MARIADB)
endif
ifneq ($(IMAGE_WORDPRESS),)
    VOLUMES += $(VOLUME_WORDPRESS)
endif

NETWORK = inception

RM_IMAGES = docker image rm $(IMAGES)
# RM_CONT = docker rm -f $(CONTAINERS)
RM_VOL = docker volume rm -f $(VOLUMES)
# RM_NET = docker network rm $(NETWORK)

#-------------------------------------------------------------------------------#
#								   NEEDED										#
#-------------------------------------------------------------------------------#

# D_MDB = /home/mbertin/data/mariadb
D_MDB = /Users/mbertin/data/mariadb
# D_WP = /home/mbertin/data/wordpress
D_WP = /Users/mbertin/data/wordpress

#------------------------------------------------------------------------------#
#									SOURCES									   #
#------------------------------------------------------------------------------#

SRCS =	srcs/docker-compose.yml

#------------------------------------------------------------------------------#
#									 RULES									   #
#------------------------------------------------------------------------------#

all:	docker

docker:	$(SRCS)
	@sudo mkdir -p $(D_MDB)
	@sudo mkdir -p $(D_WP)
	@echo "$(LGREEN)Directories Creation Completed.$(NC)"
	@$(call creating, $(DC) -f $(SRCS) up --build --remove-orphans -d)

clean:
	@$(call cleaning, $(DC) -f $(SRCS) stop)
	@echo "$(LGREEN)Docker Containers Stopped.$(NC)"

fclean:	clean
	@$(RM) $(D_MDB)
	@$(RM) $(D_WP)
	@echo "$(LGREEN)Directories Removal Completed.$(NC)"
	@$(call fcleaning, $(DC) -f $(SRCS) down)
	@echo "$(LGREEN)Docker Containers and Network Removed.$(NC)"
	@if [ -n "$(IMAGES)" ]; then $(RM_IMAGES); echo "$(LGREEN)Docker Images Removed.$(NC)"; fi
	@if [ -n "$(VOLUMES)" ]; then $(RM_VOL); echo "$(LGREEN)Docker Volumes Removed.$(NC)"; fi

re:	fclean all

.PHONY: all clean fclean re  

#------------------------------------------------------------------------------#
#								  MAKEUP RULES								   #
#------------------------------------------------------------------------------#

#----------------------------------- COLORS -----------------------------------#
LRED = \033[91m
RED = \033[91m
LGREEN = \033[92m
LYELLOW = \033[93m
LMAGENTA = \033[95m
LCYAN = \033[96m
NC = \033[0;39m

#----------------------------------- TEXTES -----------------------------------#
CLEAN_STRING = "Cleaning"
CREAT_STRING = "Creating"

# #----------------------------------- DEFINE -----------------------------------#

define cleaning
printf "%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) STOPPING containers$(NC)\r"; \
$(1) 2> $@.log; \
RESULT=$$?; \
	if [ $$RESULT -ne 0 ]; then \
		printf "%-60b%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) STOPPING containers" "💥$(NC)\n"; \
	elif [ -s $@.log ]; then \
		printf "%-60b%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) STOPPING containers" "⚠️$(NC)\n"; \
	else \
		printf "%-60b%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) STOPPING containers" "✅$(NC)\n"; \
	fi; \
	cat $@.log; \
	rm -f $@.log; \
	exit $$RESULT
endef

define fcleaning
printf "%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) REMOVING containers, volumes, images and network$(NC)\r"; \
$(1) 2> $@.log; \
RESULT=$$?; \
	if [ $$RESULT -ne 0 ]; then \
		printf "%-60b%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) REMOVING containers, volumes, images and Network" "💥$(NC)\n"; \
	elif [ -s $@.log ]; then \
		printf "%-60b%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) REMOVING containers, volumes, images and Network" "⚠️$(NC)\n"; \
	else \
		printf "%-60b%b" "$(LCYAN)$(CLEAN_STRING)$(LMAGENTA) REMOVING containers, volumes, images and Network" "✅$(NC)\n"; \
	fi; \
	cat $@.log; \
	rm -f $@.log; \
	exit $$RESULT
endef

define creating
printf "%b" "$(LCYAN)$(CREAT_STRING)$(LMAGENTA) $(@F)$(NC)\r"; \
$(1) 2> $@.log; \
RESULT=$$?; \
	if [ $$RESULT -ne 0 ]; then \
		printf "%-60b%b" "$(LCYAN)$(CREAT_STRING)$(LMAGENTA) $(@F)" "💥$(NC)\n"; \
	elif [ -s $@.log ]; then \
		printf "%-60b%b" "$(LCYAN)$(CREAT_STRING)$(LMAGENTA) $(@F)" "⚠️$(NC)\n"; \
	else \
		printf "%-60b%b" "$(LCYAN)$(CREAT_STRING)$(LMAGENTA) $(@F)" "✅$(NC)\n"; \
	fi; \
	cat $@.log; \
	rm -f $@.log; \
	exit $$RESULT
endef