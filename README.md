Thesis template for HKUST, licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

**Directory Structure**

 - **hkustthesis.cls**: Styles
 - **thesis.tex**: Main latex source
 - **thesis.bib**: Bibtex source
 - **chapter**: Directory to contain all chapters
 - **figures**: Directory to contain all figures
 - **Makefile**: Compile (via rubber), compress and archive

**Compiling via Makefile**

Compile the sources via rubber (https://launchpad.net/rubber):

```
make
```

Compress the generated PDF:

```
make thesis-compressed.pdf
```

Generate the compressed PDF and make zip archive:

```
make zip
```

Clean the working directory:

```
make clean
```
