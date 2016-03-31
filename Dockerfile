FROM debian:jessie-backports

RUN apt-get update \
	&& apt-get -y install zlib1g-dev gcc make git autoconf autogen automake pkg-config \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/firehol/netdata.git netdata.git --depth=1 \
	&& cd netdata.git && ./netdata-installer.sh && rm -rf /netdata.git

RUN ln -sf /dev/stdout /var/log/netdata/access.log \
	&& ln -sf /dev/stdout /var/log/netdata/debug.log \
	&& ln -sf /dev/stderr /var/log/netdata/error.log 

EXPOSE 19999

ENTRYPOINT ["/usr/sbin/netdata", "-nd"]
