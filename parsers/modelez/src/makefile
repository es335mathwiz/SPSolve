
JC = javac
JI = java
JCCC = /arc/home3/m1rab01/javacc/javacc2.1/bin/javacc
JCCC = javacc
OPTS = -target 1.1 -source 1.2 -classpath ../modelezAim -d ../modelezAim 

ALLCLASS = AimConstants.class Model.class  Node.class Equation.class \
	PowerNode.class \
	Aim.class CoefficientNode.class ConstantNode.class \
	ProductNode.class SumNode.class Variable.class \
	VariableNode.class 



all: 
	$(JC) $(OPTS) *.java
# $@ = The file name of the target of the rule.
# $< = The name of the first prerequisite.

.SUFFIXES:  .java .class .jj

.java.class:
	$(JC) $(OPTS) $<

.jj.java:
	$(JCCC) $<

Aim.java: Aim.jj
	$(JCCC) Aim.jj

Aim.class: Aim.java 
	$(JC) $(OPTS) Aim.java


clean:
	rm *.class Aim.java 
	rm -rf ../lib 
	rm -rf ../modelezAim
cleanObsolete:
	rm TokenMgrError.java Token.java ParseException.java SimpleCharStream.java
modelezAim.jar:	Aim.class
	(cd ../modelezAim; jar cvf /tmp/modelezAim.jar modelezAim)
	mv /tmp/modelezAim.jar ../lib


