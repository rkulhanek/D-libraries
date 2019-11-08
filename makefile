MODULES=$(shell ls *.d)

COMPILER=$(shell which dmd || which ldc2)

librdk.a: $(MODULES)
	$(COMPILER) -lib -O $(MODULES) '-of$@'

