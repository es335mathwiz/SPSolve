
JC = javac
JI = java
OPTS =  -classpath ./  -source 1.2 -target 1.2 -d ./ 

ALLCLASS = SPSolve.class doCopy.class



SPSolve.jar:	$(ALLCLASS)
	jar cvf /tmp/SPSolve.jar SPSolveUtils
	mkdir -p ../lib
	mv /tmp/SPSolve.jar ../lib



all: 
	$(JC) $(OPTS) *.java
# $@ = The file name of the target of the rule.
# $< = The name of the first prerequisite.

.SUFFIXES:  .java .class .jj

.java.class:
	mkdir -p SPSolveUtils
	$(JC) $(OPTS) $<



clean:
	rm -rf ../lib ../SPSolveUtils

