FROM debian:testing

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

sed -i "s#deb http://http.us.debian.org/debian testing main#deb http://http.us.debian.org/debian jessie main contrib non-free#g" /etc/apt/sources.list


ARG WGET=wget
ARG GIT=git
ARG MAKE=make
ARG PANDOC=pandoc
ARG PCITEPROC=pandoc-citeproc
ARG PYGMENTS=python3-pygments
ARG FIG2DEV=fig2dev

RUN apt-get update && apt-get install -y \
  texlive-luatex \
  ttf-mscorefonts-installer && \
  # some auxiliary tools
  #"$WGET" \
  #"$GIT" \
  #"$MAKE" \
  # markup format conversion tool
  #"$PANDOC" \
  #"$PCITEPROC" \
  # XFig utilities
  #"$FIG2DEV" \
  # syntax highlighting package
  #"$PYGMENTS" && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

RUN fc-cache
RUN fc-match Arial
