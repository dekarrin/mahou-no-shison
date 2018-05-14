FEYC = fairyc
LEXFLAGS = --pretty
ASTFLAGS = --pretty
DOCXFLAGS =
RPYFLAGS =
ANALYZEFLAGS =

CH01_FILES = start.fey common-routes.fey home-path.fey library-path.fey shrine-path.fey
CH01_ASTS = $(patsubst %.fey,chapter01/%.ast,$(CH01_FILES))

.PHONY: clean all

all: chapter01.docx chapter01.rpy chapter01.ana

clean:
	rm -rf *.docx
	rm -rf *.rpy
	rm -rf *.ana
	rm -rf chapter01/*.ast
	rm -rf chapter01/*.lex

chapter01.docx: $(CH01_ASTS)
	$(FEYC) docx $(DOCXFLAGS) -f ast $(CH01_ASTS) -o $@

chapter01.rpy: $(CH01_ASTS)
	$(FEYC) renpy $(RPYFLAGS) -f ast $(CH01_ASTS) -o $@

chapter01.ana: $(CH01_ASTS)
	$(FEYC) analyze $(ANALYZEFLAGS) -f ast $(CH01_ASTS) -o $@

%.ast: %.fey
	$(FEYC) ast $(ASTFLAGS) $< -o $@

%.lex: %.fey
	$(FEYC) lex $(LEXFLAGS) $< -o $@
