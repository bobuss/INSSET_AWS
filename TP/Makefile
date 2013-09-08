FILENAME=01_aws_correction

HTML_FILES=\
	templates/header.html\
	templates/$(FILENAME).html\
	templates/footer.html

all: ./node_modules/.bin/marked
	./node_modules/.bin/marked $(FILENAME).md -o templates/$(FILENAME).html
	cat $(HTML_FILES) > $(FILENAME).html

deps:
	npm install marked
