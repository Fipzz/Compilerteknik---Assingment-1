ANTLRJAR = /usr/local/lib/antlr-4.7.2-complete.jar

export CLASSPATH := .:$(ANTLRJAR):${CLASSPATH}
antlr4 = java -jar $(ANTLRJAR)
grun   = java org.antlr.v4.gui.TestRig

SRCFILES = main.java
GENERATED = simpleCalcListener.java simpleCalcBaseListener.java simpleCalcParser.java simpleCalcBaseVisitor.java simpleCalcVisitor.java simpleCalcLexer.java

all:
	make main.class

main.class:	$(SRCFILES) $(GENERATED) simpleCalc.g4
	javac  $(SRCFILES) $(GENERATED)

simpleCalcListener.java:	simpleCalc.g4
	$(antlr4) -visitor simpleCalc.g4

test1:	main.class
	java main simpleCalc_input.txt

test2:	main.class
	java main CompilerTeknikTest1.txt

test3:	main.class
	java main CompilerTeknikTest2.txt

testif:	main.class
	java main IfTest.txt

testelif:	main.class
	java main ElseIfTest.txt

testel:	main.class
	java main ElseTest.txt

testwhile:	main.class
	java main WhileTest.txt

tree:	$(GENERATED) simpleCalc.g4
	javac $(GENERATED)
	$(grun) simpleCalc start -tree -gui < simpleCalc_input.txt
