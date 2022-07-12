CC := gcc
CFLAGS = $(WFLAGS) $(OPTIM)

WFLAGS := -Wall -Wextra -Wpedantic --std=c99

OUT_DIR := .
OBJ_DIR = $(OUT_DIR)/obj
LIB_DIR = $(OUT_DIR)/lib

.PHONY: all
all: release

.PHONY: debug
debug: DEBUG = -fsanitize=address,undefined
debug: OPTIM := -g
debug: dirs $(LIB_DIR)/libtyrant.a

.PHONY: release
release: OPTIM := -O3
release: dirs $(LIB_DIR)/libtyrant.a

# tyrant

LIB_HEADERS = src/tyrant.h
LIB_OBJS = $(OBJ_DIR)/tyrant.o

$(LIB_DIR)/libtyrant.a: $(LIB_OBJS) Makefile
	ar crs $@ $(LIB_OBJS)

$(OBJ_DIR)/tyrant.o: src/tyrant.c $(LIB_HEADERS)
	$(CC) -c -o $@ $< $(CFLAGS) $(DEBUG) $(DEFINES)

# dirs

.PHONY: dirs
dirs: $(OBJ_DIR) $(LIB_DIR)

$(OBJ_DIR):
	mkdir -p $@

$(LIB_DIR):
	mkdir -p $@

# clean

.PHONY: clean
clean:
	rm -rf obj/* lib/*
