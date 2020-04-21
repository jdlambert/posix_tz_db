CC=gcc
CFLAGS=-I.
DEPS = zones.h
TAG=posix-tz-db

.PHONY: all clean example docker

all: zones.o zones.h zones.json zones.csv

# `zones.o` intentionally does not depend on making `zones.c`, since `zones.c` requires the 
# consistent build environment provided by Docker or the latest Arch Linux, and would only 
# actually need an update a few times a year or so. `zones.c` is checked in to source
# control though, so build it when it gets updated, commit it, and you're good.
zones.o: zones.h
	$(CC) -c -o zones.o $(CFLAGS) zones.c

zones.c: docker
	docker run -i $(TAG) ./gen-tz.py -e > $@

zones.json: docker
	docker run -i $(TAG) ./gen-tz.py -j > $@

zones.csv: docker
	docker run -i $(TAG) ./gen-tz.py -c > $@

docker: Dockerfile scripts
	docker build . -t $(TAG)

run-example: example/example
	example/example

example: example/example

example/example: zones.o example/example.c
	gcc -o example/example zones.o $(CFLAGS) example/example.c 

clean:
	rm -f zones.o example/example
