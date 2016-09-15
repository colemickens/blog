FROM docker.io/library/alpine:3.4
ENV HUGO_VERSION 0.16

RUN apk add --update --no-cache make wget ca-certificates
RUN mkdir /tmp/hugo; (\
		cd /tmp/hugo; \
		wget "https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-64bit.tgz"; \
		tar xzf hugo_${HUGO_VERSION}_linux-64bit.tgz; \
		cp hugo /usr/bin/hugo; \
	); rm -rf /tmp/hugo

ADD . /opt/blog

WORKDIR /opt/blog
