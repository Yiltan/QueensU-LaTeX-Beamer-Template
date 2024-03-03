# run it like this: $ LATEX=<your latex command> make
# for example: $ LATEX='xelatex --output-directory=out' make

LATEX ?= 'latexmk -pdf -outdir=${OUT_DIR}'

PDF_READER='open'
SPELL_LANG='en_GB'

OUT_DIR=out
FILE=main
PDF=$(OUT_DIR)/$(shell ls out/ | grep pdf)


.PHONY: all default clean open shell present

all: default

$(OUT_DIR):
	mkdir -p "${OUT_DIR}"

default: $(OUT_DIR) $(FILE).tex
	$(LATEX) $(FILE).tex

open: default
	nohup $(PDF_READER) $(PDF) > /dev/null &

spell: # TODO: use hunspell
	find . -name "*.tex" -exec aspell -d $(SPELL_LANG) --mode=tex -c {} \;

present: default
	nohup zathura $(PDF) > /dev/null &
	
clean:
	$(RM) $(OUT_DIR)/*
