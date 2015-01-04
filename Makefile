all: build

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