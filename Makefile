all: build

install-hugo:
	go get -u -v github.com/spf13/hugo

update-hugo-themes:
	rm -rf themes
	git clone --recursive https://github.com/spf13/hugoThemes.git themes
	rm -rf themes/.git
	rm -rf themes/.gitmodules

build:
	hugo

