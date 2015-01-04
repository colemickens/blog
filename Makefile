all: build

build:
	hugo

update:
	# delete hugo themes directory
	# re-download hugoThemes

prepare: build
	git add -A .    ; \
	git commit -m "publish latest blog source material" ; \
	cd public       ; \
	git add -A .    ; \
	git commit -m "publish latest hugo output" ; \
	cd ..

push: prepare
	git push ; cd public ; git push