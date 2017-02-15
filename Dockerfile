FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get -y install --no-install-recommends \
        python3-pip git python3-setuptools python3-levenshtein &&\
    apt-get remove --purge -y git &&\
    apt-get autoremove -y &&\
    rm -rf /var/lib/apt/lists /tmp/*

RUN pip3 install flask chatterbot

RUN clone https://github.com/pedosb/flask-chatterbot &&\

WORKDIR /flask-chatterbot

RUN mkdir -p /bootstrap && \
    mv /flask-chatterbot /bootstrap/ChatterBot

WORKDIR /

ENTRYPOINT \
    if [ ! -d /data/ChatterBot ]; \
    then \
        mkdir -p /data &&\
        cp -a /bootstrap/ChatterBot /data/ChatterBot; \
    fi; \
    cd /data/ChatterBot &&\
    python3 app.py
