
JFLAGS = -g
JAVAC  = javac
JAVA   = java

JAVAS   = $(shell find ./ -type f -name '*.java')
CLASSES = $(patsubst %.java,%.class,$(JAVAS))
DIAGRAM_SCRIPTS  = $(shell find ./individual/ -type f -name 'generate_diagram_*.sh')
DIAGRAM_DOTS = $(shell find ./individual -type f -name '*.dot')

all: 	$(CLASSES)


%.class: %.java
	$(JAVAC) $(FLAGS) $<

TESTS_JAVAS   = $(shell find ./tests/ -type f -name 'Test_*.java')
TESTS_CLASSES = $(patsubst %.java,%.class,$(TESTS_JAVAS))

test:	$(CLASSES)
	@for test in $(TESTS_CLASSES) ; do \
	  echo "##### running test: $$test" ;\
          dir=`dirname $$test` ;\
	  base=`basename $$test` ;\
	  file=`echo $${base%.*}` ;\
	  $(JAVA) -classpath ./:$$dir $$file ;\
	done

doc:
	mkdir -p doc
	javadoc -d doc $(JAVAS)

doc_clean:
	rm -rf doc

diagram_dot:
	@for diagram in $(DIAGRAMS_SCRIPTS) ; do \
	  echo "##### making dot: $$diagram" ;\
      dir=`dirname $$individual` ;\
	  base=`basename $$diagram` ;\
	  file=`echo $${base%.*}` ;\
  	  `./:$$dir $$file` ;\
	done

diagrams:
	@for diagram in $(DIAGRAM_DOTS) ; do\
	  echo "##### making dot: $$diagram" ;\
	  dir=`dirname $$individual` ;\
	  base=`basename $$diagram` ;\
	  file=`echo $${base%.*}` ;\
	  `./:$$dir $$file` ;\
	  `dot -Tpdf :$$dir $$file > :$$dir $$file .pdf`;\

clean:  doc_clean
	$(RM) $(CLASSES) $(DIAGRAM_DOTS)
