# LaTeX Makefile
FILE=project
all: $(FILE).pdf
.PHONY: clean
clean:
	\rm *.aux *.blg *.out *.bbl *.log
$(FILE).pdf: $(FILE).tex
	latex $(FILE)
	bibtex $(FILE)
	latex $(FILE)
	latex $(FILE)
	dvipdf *.dvi
