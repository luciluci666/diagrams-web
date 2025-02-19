FROM alpine:3.14

RUN apk update && apk add --no-cache \
  gcc libc-dev g++ graphviz python3 py-pip python3-dev ttf-opensans curl fontconfig npm xdg-utils

COPY web /app
WORKDIR /app

RUN pip3 install -r requirements.txt

# add fonts to support CJK languages
RUN curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
&& mkdir -p /usr/share/fonts/NotoSansCJKjp \
&& unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
&& rm NotoSansCJKjp-hinted.zip \
&& fc-cache -fv

# generate help menu template
RUN python3 helpers.py

# install editor library
RUN npm install --prefix ./static/js ace-builds@1.11.2
