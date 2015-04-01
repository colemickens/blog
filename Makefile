all: build

install-hugo:
	go get -u -v github.com/spf13/hugo

update-hugo-themes:
	rm -rf themes
	git clone --recursive https://github.com/spf13/hugoThemes.git themes
	rm -rf themes/.git

build:
	hugo

prepare: build
	git add -A .    ; \
	git commit -m "publish latest blog source material" ; \
	cd public       ; \
	git add -A .    ; \
	git commit -m "publish latest hugo output" ; \
	cd ..

push: prepare
	git push ; cd public ; git push
