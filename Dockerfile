FROM ubuntu:18.04

LABEL maintainer="richard@maasoft.com"

RUN apt-get update && apt-get install -y \
    motion \
    ffmpeg \
    v4l-utils \
    python-pip \ 
    python-dev \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install motioneye
 
RUN mkdir -p /etc/motioneye \
    && cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf \
    && mkdir -p /var/lib/motioneye \
    && cp /usr/local/share/motioneye/extra/motioneye.init-debian /etc/init.d/motioneye \
    && chmod +x /etc/init.d/motioneye && update-rc.d -f motioneye defaults
 
EXPOSE 8765
CMD /etc/init.d/motioneye start && tail -f /var/log/motioneye.log
