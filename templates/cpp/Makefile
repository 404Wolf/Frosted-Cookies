CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -pedantic -std=c99
TARGET = hello
BINDIR = bin

all: $(BINDIR) $(BINDIR)/$(TARGET)

$(BINDIR):
	mkdir -p $(BINDIR)

$(BINDIR)/$(TARGET): src/hello.c++
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -rf $(BINDIR)

.PHONY: all clean

