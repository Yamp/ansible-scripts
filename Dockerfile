FROM ubuntu:19.10

ENV DEBIAN_FRONTEND noninteractive
ENV CFLAGS '-O3'
ENV CXXFLAGS '-O3'

# разные всякие apt-пакеты
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install apt-utils sudo

# TODO: добавить в zshrc pyenv

# poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Всякая ansible магия
ADD ./ansible_scripts /ansible_scripts
WORKDIR /ansible_scripts
RUN ansible-galaxy install -r requirements.yml
RUN ansible-playbook setup-playbook.yml

RUN cargo install exa ripgrep fd-find topgrade
