FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

RUN \
  apt-get update --yes && \
  apt-get install --no-install-recommends --yes \
    build-essential \
    tzdata \
    cmake \
	git \
	ca-certificates \
    libgtk2.0-dev \
    wget \
    gosu \
  && \
  gosu nobody true \
  apt-get clean --yes	
  
COPY \
  install-cavass.sh \
  /install/
  
RUN \
  cd /install && \
  /install/install-cavass.sh && \
  rm -rf /install

COPY entrypoint.sh /

WORKDIR /work

ENTRYPOINT ["/entrypoint.sh"]

