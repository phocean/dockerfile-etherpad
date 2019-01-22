FROM ubuntu:bionic

MAINTAINER Phocean <jc@phocean.net>

# install dir
WORKDIR /opt

# base
RUN apt-get update &&\
	apt-get -y install curl gnupg2 &&\
	curl -sL https://deb.nodesource.com/setup_11.x | bash - &&\
	apt-get update &&\
	apt-get -y install gzip git-core python pkg-config build-essential libssl-dev python3-pip nodejs &&\
	pip3 install dumb-init &&\
	npm install sqlite3 ep_headings ep_monospace_default ep_print &&\
	rm -rf /var/lib/apt/lists/* &&\
	git clone git://github.com/ether/etherpad-lite.git &&\
  sed '/installDeps.sh/d' etherpad-lite/bin/run.sh -i &&\
  useradd -c "Etherpad user" -d /dev/null -s /bin/false etherpad &&\
  chown -R etherpad:etherpad . &&\
  /opt/etherpad-lite/bin/installDeps.sh

# push our config file (simple sqlite config)
ADD config/ /opt/etherpad-lite/

# data volume for persistency of pads
VOLUME /opt/etherpad-lite/var

WORKDIR /opt/etherpad-lite/bin

# startup script
ADD run-docker.sh /opt/etherpad-lite/bin/
CMD ["/opt/etherpad-lite/bin/run-docker.sh"]
