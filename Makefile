# Makefile for CV
#
# Copyright (C) David Thomas, 2016.
#

NAME=CV

CONVERTER=pandoc

OPTIONS=--standalone \
	--from markdown_mmd

HTMLOPTIONS=--css=$(NAME).css

PDFOPTIONS=--latex-engine=xelatex \
	--variable geometry="a4paper" \
	--variable fontsize=12pt \
	--variable geometry:hmargin=18mm \
	--variable geometry:vmargin=26mm \
	--variable mainfont="ITC Novarese Std" \
	--variable sansfont="Helvetica" \
	--variable monofont="Consolas"

DOCOPTIONS=

.SUFFIXES:	# Delete the default suffixes
.SUFFIXES: .docx .html .md .pdf

.PHONY:	all
all:	pdf html doc

SOURCES	= $(shell find . -type f -name '*.md')
PDF     = $(SOURCES:.md=.pdf)
HTML    = $(SOURCES:.md=.html)
DOC     = $(SOURCES:.md=.docx)
OBJECTS = $(PDF) $(HTML) $(DOC)

%.html : %.md %.css
	$(CONVERTER) $(OPTIONS) $(HTMLOPTIONS) -o $@ $<

%.pdf : %.md
	$(CONVERTER) $(OPTIONS) $(PDFOPTIONS) -o $@ $<

%.docx : %.md
	$(CONVERTER) $(OPTIONS) $(DOCOPTIONS) -o $@ $<

.PHONY: html
html:	$(HTML)

.PHONY: pdf
pdf:	$(PDF)

.PHONY: doc
doc:	$(DOC)

.PHONY: clean
clean:;	-rm -f $(OBJECTS)

