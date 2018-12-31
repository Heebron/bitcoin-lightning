FROM ubuntu:latest

# Build C-Lightning

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    	    autoconf \
    	    automake \
	    build-essential \
	    git \
	    libtool \
      	    libgmp-dev \
	    libsodium-dev \
	    libsqlite3-dev \
	    python \
	    python3 \
	    unzip \
      	    net-tools \
	    zlib1g-dev && \
	    rm -rf /var/lib/apt/lists/*

# cache busting - build only if head ref changed
ADD https://api.github.com/repos/ElementsProject/lightning/git/refs/heads/master version.json

RUN git clone -v https://github.com/ElementsProject/lightning.git && \
    cd lightning && ./configure && make

FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:bitcoin/bitcoin && \
    apt-get update && apt-get install -y bitcoind net-tools jq netcat && \
    rm -rf /var/lib/apt/lists/*

COPY --from=0 /lightning /lightning/

RUN chown -R bitcoin. /lightning && usermod -d /data bitcoin

VOLUME /data

WORKDIR /data

EXPOSE 8332 8333 9735

USER bitcoin:bitcoin

COPY entrypoint.sh /lightning

CMD [ "/lightning/entrypoint.sh" ]
