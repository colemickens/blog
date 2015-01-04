all: build

build:
	hugo

prepare:
	(git add -A .; git commit -m "publish latest blog source material")
	(cd public; git add -A .; git commit -m "publish latest hugo output")

push:
	git push
	(cd public; git push)