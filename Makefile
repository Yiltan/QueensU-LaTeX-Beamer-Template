PDF_READER='open'
SPELL_LANG='en_GB'

OUT_DIR=out
FILE=main
PDF=$(OUT_DIR)/$(shell ls out/ | grep pdf)

make : $(FILE).tex
	latexmk -pdf -outdir=$(OUT_DIR) $(FILE).tex
	rm -f missfont.log

clean :
	rm -f $(OUT_DIR)/*
	find . -name "*.swp" -exec rm {} \;
	find . -name "*.bak" -exec rm {} \;

open : make $(PDF)
	nohup $(PDF_READER) $(PDF) > /dev/null &

spell :
	find . -name "*.tex" -exec aspell -d $(SPELL_LANG) --mode=tex -c {} \;

present: make $(PDF)
	nohup zathura $(PDF) > /dev/null &
