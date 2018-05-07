SCPC = scpcompile
DOCXFLAGS =
RPYFLAGS =

CH01_FILES = start.scp common-routes.scp home-path.scp library-path.scp shrine-path.scp
CH01_ASTS = $(patsubst %.scp,chapter01/%.ast,$(CH01_FILES))

.PHONY: clean all

all: chapter01.docx chapter01.rpy

clean:
	rm -rf *.docx
	rm -rf *.rpy
	rm -rf chapter01/*.ast

chapter01.docx: $(CH01_ASTS)
	$(SCPC) --word $(DOCXFLAGS) -f ast $(patsubst %,-i %,$(CH01_ASTS)) -o $@

chapter01.rpy: $(CH01_ASTS)
	$(SCPC) --word $(RPYFLAGS) -f ast $(patsubst %,-i %,$(CH01_ASTS)) -o $@

%.ast: %.scp
	$(SCPC) --ast -i $< -o $@
