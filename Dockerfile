FROM ubuntu
#FROM debian:testing

ARG DEBIAN_FRONTEND=noninteractive

ARG USER_NAME=jenkins
ARG USER_HOME=/home/jenkins
ARG USER_ID=1004
ARG USER_GECOS=jenkins

RUN addgroup \
  --gid 1005 \
  "$USER_NAME"

RUN adduser \
  --home "$USER_HOME" \
  --uid $USER_ID \
  --gecos "$USER_GECOS" \
  --gid 1005 \
  --disabled-password \
  "$USER_NAME"

RUN ln -fs /usr/share/zoneinfo/US/Eastern /etc/localtime
#RUN dpkg-reconfigure -f noninteractive tzdata

ARG GIT=git

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN apt-get update && apt-get install -y \
  texlive-latex-base \
  texlive-latex-recommended \
  texlive-full \
  texlive-luatex

RUN apt-get install -y \ 
  fontconfig \
  ttf-mscorefonts-installer

RUN apt-get install -y \
  # some auxiliary tools
  "$GIT"

RUN apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

RUN fc-cache
RUN fc-match Arial
