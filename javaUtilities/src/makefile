
JC = javac
JI = java
OPTS =  -classpath ./ -d ./SPSolveUtils 

ALLCLASS = SPSolve.class doCopy.class



SPSolve.jar:	$(ALLCLASS)
	(jar cvf /tmp/SPSolve.jar SPSolveUtils)
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

