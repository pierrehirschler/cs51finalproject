# This program

PROG = cows

# Setup

LIBS = \
	graphics.cma

CAMLC = ocamlc str.cma Helpers.ml Main.ml
CAMLDOC = ocamldoc
CAMLFLAGS = -g

%.cmo: %.ml
	$(CAMLC) $(CAMLFLAGS) -c $<

# Source and Object files
SOURCES = \
	Direction.ml Draw.ml Helpers.ml \
	Event.ml \
	WorldObjectI.ml World.ml WorldObject.ml \
	Alive.ml \
	UI.ml Main.ml \

OBJECTS = $(SOURCES:.ml=.cmo)

# Final Program

$(PROG):$(OBJECTS)
	$(CAMLC) $(CAMLFLAGS) $(LIBS) $(OBJECTS) -o $(PROG)

# DocGen

doc: $(OBJECTS)
	$(CAMLDOC) -html $(SOURCES)

# Other

all: $(PROG)

clean:
	rm -rf *.cmo *.cmi *.html *.css $(PROG)

.DEFAULT_GOAL := $(PROG)
.PHONY: doc build run clean
