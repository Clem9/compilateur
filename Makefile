BUILDDIR = build
SOURCEDIR = src
TESTDIR = tests
LEX_SOURCE = al.lex
LEX_YACC_SOURCE = as.y
LEX_OUTPUT = yy.lex.c
LEX_EXECUTABLE = compile
YACC_OUTPUT = as.y.tab.c
TEST_FILE = test3.c
SOURCES = tableInstructions.c src/tableSymboles.c
all:
	mkdir -p $(BUILDDIR)
	yacc -b $(BUILDDIR)/$(LEX_YACC_SOURCE) -d $(SOURCEDIR)/$(LEX_YACC_SOURCE)
	lex -o $(BUILDDIR)/$(LEX_OUTPUT) $(SOURCEDIR)/$(LEX_SOURCE) 
	gcc $(BUILDDIR)/$(LEX_OUTPUT) $(SOURCEDIR)/$(SOURCES) $(BUILDDIR)/$(YACC_OUTPUT) -o $(BUILDDIR)/$(LEX_EXECUTABLE) -Ibuild -Isrc
test:
	$(BUILDDIR)/$(LEX_EXECUTABLE) < $(TESTDIR)/$(TEST_FILE)
clean:
	rm -rf $(BUILDDIR)