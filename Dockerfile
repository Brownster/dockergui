# dockergui
FROM phusion/baseimage:0.9.22
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" TERM="xterm"
# Set environment variables

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="TinyMediaManager"

# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list

# Install packages needed for app

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
COPY ./files/ /tmp/

#########################################
##         INSTALL LIBMEDIAINFO        ##
#########################################
RUN apt-get update
RUN apt-get install -y libmediainfo0

#########################################
## INSTALL DIRECTLY FROM RELEASE PAGE  ##
#########################################
RUN mkdir /tinyMediaManager
RUN wget https://github.com/tinyMediaManager/tinyMediaManager/archive/tinyMediaManager-2.9.6.tar.gz -O /tmp/tinyMediaManager.tar.gz
RUN tar -zxvf /tmp/tinyMediaManager.tar.gz -C /tinyMediaManager

RUN chmod +x /tmp/install/tmm_install.sh && /tmp/install/tmm_install.sh && rm -r /tmp/install

# Copy X app start script to right location
#COPY startapp.sh /startapp.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whater volumes and ports you want exposed here:
EXPORT /tinymediamanager
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
