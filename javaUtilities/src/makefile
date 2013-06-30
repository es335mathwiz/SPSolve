
JC = javac
JI = java
OPTS = -target 1.1 -source 1.2 -classpath ../SPUtils -d ../SPUtils 

ALLCLASS = SPSolve.class doCopy.class



all: 
	$(JC) $(OPTS) *.java
# $@ = The file name of the target of the rule.
# $< = The name of the first prerequisite.

.SUFFIXES:  .java .class .jj

.java.class:
	$(JC) $(OPTS) $<

.jj.java:
	$(JCCC) $<


clean:
	rm -rf ../lib ../SPUtils

SPSolve.jar:	$(ALLCLASS)
	(cd ../SPUtils; jar cvf /tmp/SPSolve.jar SPSolveUtils)
	mv /tmp/SPSolve.jar ../lib


