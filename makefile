MODULES=$(shell ls *.d)

librdk.a: $(MODULES)
	dmd -lib -O $(MODULES) '-of$@'

