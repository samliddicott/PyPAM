SHELL = /bin/bash

EXTRA_DIST = PyPAM.spec

INCLUDES = $(PYTHON_INCLUDES) $(PYTHON_CFLAGS)

pyexec_PROGRAMS = PAMmodule$(SO)
PAMmodule__SO__SOURCES = PAMmodule.c
PAMmodule__SO__LDADD = -lpam -lpam_misc
PAMmodule__SO__LINK = $(PYTHON_LINK)

