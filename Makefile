all: build

install-hugo: FORCE
	go get -u -v github.com/spf13/hugo

update-hugo-themes: FORCE
	rm -rf themes
	git clone --recursive https://github.com/spf13/hugoThemes.git themes
	rm -rf themes/.git
	rm -rf themes/.gitmodules

build: FORCE
	hugo

save-blog: FORCE
	git add -A . ; \
	git commit -m "publish" ; \
	git push origin master ; \

publish-blog: build save-blog
	( cd ../colemickens.github.io ; \
		git add -A . ; \
		git commit -m "publish" ; \
		git push origin master )

FORCE:
