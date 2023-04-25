SOURCE_DOCS := $(wildcard src/*.md)
EXPORTED_DOCS = $(patsubst src/%.md, %.html, $(SOURCE_DOCS))

PANDOC=/usr/local/bin/pandoc

PANDOC_OPTIONS=--standalone
PANDOC_HTML_OPTIONS=-c css/github.css -f markdown -t html5

.PHONY: all clean publish

all : $(EXPORTED_DOCS)

clean:
	- rm $(EXPORTED_DOCS)

publish:
	rsync --delete -dav --exclude ".git"  --exclude "src" --exclude ".gitignore" --exclude "README.md". bobuss@tornil.net:~/www/INSSET_AWS/

# Files generation

%.html : src/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

