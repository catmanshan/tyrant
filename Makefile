CC := gcc
CFLAGS = $(WFLAGS) $(OPTIM)

WFLAGS := -Wall -Wextra -Wpedantic --std=c99

.PHONY: all
all: release

.PHONY: debug
debug: DEBUG = -fsanitize=address,undefined
debug: OPTIM := -g
debug: dirs lib/libtyrant.a

.PHONY: release
release: OPTIM := -O3
release: dirs lib/libtyrant.a

# tyrant

LIB_HEADERS = src/tyrant.h
LIB_OBJS = obj/tyrant.o

lib/libtyrant.a: $(LIB_OBJS) Makefile
	ar crs $@ $(LIB_OBJS)

obj/tyrant.o: src/tyrant.c $(LIB_HEADERS)
	$(CC) -c -o $@ $< $(CFLAGS) $(DEBUG) $(DEFINES)

# dirs

.PHONY: dirs
dirs: obj lib

obj:
	mkdir -p $@

lib:
	mkdir -p $@

# clean

.PHONY: clean
clean:
	rm -rf obj/* lib/*
