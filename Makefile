BUILDER_IMAGE=colemickens-blog-builder

all:

update-themes:
	echo "NO, you made local changes"
	exit -1
	#rm -rf themes/cocoa
	#git clone https://github.com/nishanths/cocoa-hugo-theme.git themes/cocoa
	#rm -rf themes/cocoa/.git

devenv:
	docker run -it $(BUILDER_NAME) \
		--volume $(pwd):/opt/blog \
		--volume $(realpath ../colemickens.github.io):/opt/colemickens.github.io \

_build-builder:
	docker build -t $(BUILDER_IMAGE) .

build-blog: _build-builder
	docker run -it \
		--env=DUID=`id -u` \
		--env=DGID=`id -g` \
		--volume=`pwd`:/opt/blog \
		--volume=$(abspath ../colemickens.github.io):/opt/colemickens.github.io \
		$(BUILDER_IMAGE) \
		hugo; \
		chown -R $(DUID):$(DGID) ../colemickens.github.io

publish-blog: build-blog
	./publish.sh

test-blog:
	hugo server --bind 0.0.0.0 --port 9080 -b azdev.mickens.io
