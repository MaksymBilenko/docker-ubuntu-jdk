FROM     ubuntu:latest

MAINTAINER Maksym Bilenko "sath891@gmail.com"

# Set JDK Version
ENV JAVA_VERSION 7

# Set correct environment variables.
ENV	HOME /root
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8
ENV	DEBIAN_FRONTEND	noninteractive

# set sane locale
RUN	locale-gen en_US.UTF-8

RUN apt-get -y update \
	&& apt-get -y install software-properties-common python-software-properties \
    && add-apt-repository ppa:webupd8team/java -y \
	&& apt-get -y update

RUN echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java${JAVA_VERSION}-installer
RUN update-alternatives --display java 
ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-oracle

# Clean up APT when done.
RUN	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*