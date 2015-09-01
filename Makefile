OUTSDIR := outputs
FIGSDIR := figures
CHAPDIR := chapter
MAINOUT := thesis
MAINCMP := $(MAINOUT)-compressed.pdf
FIGURES := $(patsubst %.tex, %.eps, $(wildcard $(FIGSDIR)/figures-*.tex))
CHAPTER := $(patsubst %.tex, %.aux, $(patsubst $(CHAPDIR)/%, $(OUTSDIR)/%, $(wildcard $(CHAPDIR)/chapter-*.tex)))
ARCHIVE := hkustthesis.cls $(MAINOUT).tex $(MAINOUT).bib $(MAINCMP) $(wildcard $(FIGSDIR)/figures-*.eps) $(wildcard $(CHAPDIR)/chapter-*.tex)

all: $(MAINOUT).pdf

$(MAINOUT).pdf: $(FIGURES) $(CHAPTER) $(MAINOUT).tex
	rubber --into $(OUTSDIR) -m xelatex --shell-escape -q $(MAINOUT).tex
	cp $(OUTSDIR)/$(MAINOUT).pdf .

$(OUTSDIR)/%.aux: $(OUTSDIR) $(CHAPDIR)/%.tex
	touch $@

$(FIGSDIR)/%.eps: $(FIGSDIR)/%.tex
	rubber --into $(OUTSDIR) -m xelatex --shell-escape -q $<
	pdftops -eps $(OUTSDIR)/$*.pdf $@

$(MAINCMP): $(MAINOUT).pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(MAINCMP) $(MAINOUT).pdf

$(OUTSDIR):
	mkdir -p $(OUTSDIR)

zip: $(MAINCMP)
	7za a -l -tzip $(MAINOUT).zip $(ARCHIVE)

clean:
	rm -f $(OUTSDIR)/*

.PHONY: clean zip
