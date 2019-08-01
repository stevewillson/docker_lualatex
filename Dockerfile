FROM ubuntu
#FROM debian:testing

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

RUN adduser \
  --home "$USER_HOME" \
  --uid $USER_ID \
  --gecos "$USER_GECOS" \
  --disabled-password \
  "$USER_NAME"

#RUN sed -i "s/main/main contrib/g" /etc/apt/sources.list

ARG GIT=git

RUN apt-get update && apt-get install -y \
  texlive-latex-base \
  texlive-luatex \
  fontconfig \
  ttf-mscorefonts-installer \
  # some auxiliary tools
  "$GIT" && \
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

RUN fc-cache
RUN fc-match Arial
