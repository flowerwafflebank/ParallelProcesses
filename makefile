# User options

COMPILER = gnu
OPTIMIZE = yes
DEBUG    = no

# Program and source code

PROGRAM = transport

HEADERS = \
header.h

SOURCE = \
main.c\
initialize.c \
prng.c \
io.c \
transport.c \
tally.c \
eigenvalue.c \
disperse.c

OBJECTS = $(SOURCE:.c=.o)

# Set flags

CFLAGS = -Wall
LDFLAGS = -lm

ifeq ($(DEBUG),yes)
  CFLAGS += -g
  LDFLAGS  += -g
endif

ifeq ($(OPTIMIZE),yes)
  CFLAGS += -O3
endif

ifeq ($(COMPILER),gnu)
  CC = mpicc
#now compiles with mpicc so compiler understands MPI
endif

# Targets to build

$(PROGRAM): $(OBJECTS) $(HEADERS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(PROGRAM)
