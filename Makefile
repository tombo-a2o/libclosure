BUILD ?= build/debug
LIB = $(BUILD)/libBlocksRuntime.a
OBJS = $(addprefix $(BUILD)/, runtime.o data.o)

HEADERS = Block.h Block_private.h

CC = emcc
CXX = em++
LINK = emar
CFLAGS = -I. $(OPT_CFLAGS)

.SUFFIXES: .c .o

all: $(LIB)

$(LIB): $(HEADERS) $(OBJS)
	rm -f $@
	$(LINK) rcs $@ $(OBJS)

clean:
	rm -f $(LIB) $(OBJS)

$(BUILD)/%.o: %.c $(HEADERS)
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $<

install: $(LIB)
	cp $(LIB) $(EMSCRIPTEN)/system/local/lib/
	cp $(HEADERS) $(EMSCRIPTEN)/system/local/include/

.PHONY: all clean install
