dnl aclocal.m4 generated automatically by aclocal 1.4

dnl Copyright (C) 1994, 1995-8, 1999 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
dnl PARTICULAR PURPOSE.

# Do all the work for Automake.  This macro actually does too much --
# some checks are only needed if your package does certain things.
# But this isn't really a big deal.

# serial 1

dnl Usage:
dnl AM_INIT_AUTOMAKE(package,version, [no-define])

AC_DEFUN(AM_INIT_AUTOMAKE,
[AC_REQUIRE([AC_PROG_INSTALL])
PACKAGE=[$1]
AC_SUBST(PACKAGE)
VERSION=[$2]
AC_SUBST(VERSION)
dnl test to see if srcdir already configured
if test "`cd $srcdir && pwd`" != "`pwd`" && test -f $srcdir/config.status; then
  AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
fi
ifelse([$3],,
AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package]))
AC_REQUIRE([AM_SANITY_CHECK])
AC_REQUIRE([AC_ARG_PROGRAM])
dnl FIXME This is truly gross.
missing_dir=`cd $ac_aux_dir && pwd`
AM_MISSING_PROG(ACLOCAL, aclocal, $missing_dir)
AM_MISSING_PROG(AUTOCONF, autoconf, $missing_dir)
AM_MISSING_PROG(AUTOMAKE, automake, $missing_dir)
AM_MISSING_PROG(AUTOHEADER, autoheader, $missing_dir)
AM_MISSING_PROG(MAKEINFO, makeinfo, $missing_dir)
AC_REQUIRE([AC_PROG_MAKE_SET])])

#
# Check to make sure that the build environment is sane.
#

AC_DEFUN(AM_SANITY_CHECK,
[AC_MSG_CHECKING([whether build environment is sane])
# Just in case
sleep 1
echo timestamp > conftestfile
# Do `set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   set X `ls -Lt $srcdir/configure conftestfile 2> /dev/null`
   if test "[$]*" = "X"; then
      # -L didn't work.
      set X `ls -t $srcdir/configure conftestfile`
   fi
   if test "[$]*" != "X $srcdir/configure conftestfile" \
      && test "[$]*" != "X conftestfile $srcdir/configure"; then

      # If neither matched, then we have a broken ls.  This can happen
      # if, for instance, CONFIG_SHELL is bash and it inherits a
      # broken ls alias from the environment.  This has actually
      # happened.  Such a system could not be considered "sane".
      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
alias in your environment])
   fi

   test "[$]2" = conftestfile
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
rm -f conftest*
AC_MSG_RESULT(yes)])

dnl AM_MISSING_PROG(NAME, PROGRAM, DIRECTORY)
dnl The program must properly implement --version.
AC_DEFUN(AM_MISSING_PROG,
[AC_MSG_CHECKING(for working $2)
# Run test in a subshell; some versions of sh will print an error if
# an executable is not found, even if stderr is redirected.
# Redirect stdin to placate older versions of autoconf.  Sigh.
if ($2 --version) < /dev/null > /dev/null 2>&1; then
   $1=$2
   AC_MSG_RESULT(found)
else
   $1="$3/missing $2"
   AC_MSG_RESULT(missing)
fi
AC_SUBST($1)])


# serial 1

AC_DEFUN(AM_PATH_PYTHON,
  [AC_CHECK_PROGS(PYTHON, python python1.5 python1.4 python1.3,no)
  if test "$PYTHON" != no; then
    AC_MSG_CHECKING([where .py files should go])
changequote(, )dnl
    pythondir=`$PYTHON -c '
import sys
if sys.version[0] > "1" or sys.version[2] > "4":
  print "%s/lib/python%s/site-packages" % (sys.prefix, sys.version[:3])
else:
  print "%s/lib/python%s" % (sys.prefix, sys.version[:3])'`
changequote([, ])dnl
    AC_MSG_RESULT($pythondir)
    AC_MSG_CHECKING([where python extensions should go])
changequote(, )dnl
    pyexecdir=`$PYTHON -c '
import sys
if sys.version[0] > "1" or sys.version[2] > "4":
  print "%s/lib/python%s/site-packages" % (sys.exec_prefix, sys.version[:3])
else:
  print "%s/lib/python%s/sharedmodules" % (sys.exec_prefix, sys.version[:3])'`
changequote([, ])dnl
    AC_MSG_RESULT($pyexecdir)
  else
    # these defaults are version independent ...
    AC_MSG_CHECKING([where .py files should go])
    pythondir='$(prefix)/lib/site-python'
    AC_MSG_RESULT($pythondir)
    AC_MSG_CHECKING([where python extensions should go])
    pyexecdir='$(exec_prefix)/lib/site-python'
    AC_MSG_RESULT($pyexecdir)
  fi
  AC_SUBST(pythondir)
  AC_SUBST(pyexecdir)])


dnl AM_CHECK_PYMOD(MODNAME [,SYMBOL [,ACTION-IF-FOUND [,ACTION-IF-NOT-FOUND]]])
dnl Check if a module containing a given symbol is visible to python.
AC_DEFUN(AM_CHECK_PYMOD,
[AC_REQUIRE([AM_PATH_PYTHON])
py_mod_var=`echo $1['_']$2 | sed 'y%./+-%__p_%'`
AC_MSG_CHECKING(for ifelse([$2],[],,[$2 in ])python module $1)
AC_CACHE_VAL(py_cv_mod_$py_mod_var, [
if $PYTHON -c 'import $1 ifelse([$2],[],,[; $1.$2])' 1>&AC_FD_CC 2>&AC_FD_CC
  then
    eval "py_cv_mod_$py_mod_var=yes"
  else
    eval "py_cv_mod_$py_mod_var=no"
  fi
])
py_val=`eval "echo \`echo '$py_cv_mod_'$py_mod_var\`"`
if test "x$py_val" != xno; then
  AC_MSG_RESULT(yes)
  ifelse([$3], [],, [$3
])dnl
else
  AC_MSG_RESULT(no)
  ifelse([$4], [],, [$4
])dnl
fi
])




# serial 1

dnl finds information needed for compilation of shared library style python
dnl extensions.  AM_PATH_PYTHON should be called before hand.
AC_DEFUN(AM_INIT_PYEXEC_MOD,
  [AC_REQUIRE([AM_PATH_PYTHON])
  AC_MSG_CHECKING([for python headers])
  AC_CACHE_VAL(am_cv_python_includes,
    [changequote(,)dnl
    am_cv_python_includes="`$PYTHON -c '
import sys
includepy = \"%s/include/python%s\" % (sys.prefix, sys.version[:3])
libpl = \"%s/lib/python%s/config\" % (sys.exec_prefix, sys.version[:3])
print \"-I%s -I%s\" % (includepy, libpl)'`"
    changequote([, ])])
  PYTHON_INCLUDES="$am_cv_python_includes"
  AC_MSG_RESULT(found)
  AC_SUBST(PYTHON_INCLUDES)

  AC_MSG_CHECKING([definitions from Python makefile])
  AC_CACHE_VAL(am_cv_python_makefile,
    [changequote(,)dnl
    py_makefile="`$PYTHON -c '
import sys
print \"%s/lib/python%s/config/Makefile\"%(sys.exec_prefix, sys.version[:3])'`"
    if test ! -f "$py_makefile"; then
      AC_MSG_ERROR([Couldn't find the python config makefile.  Maybe you are
missing the development portion of the python installation])
    fi
    eval `sed -n \
-e "s/^CC=[ 	]*\(.*\)/am_cv_python_CC='\1'/p" \
-e "s/^OPT=[ 	]*\(.*\)/am_cv_python_OPT='\1'/p" \
-e "s/^CCSHARED=[ 	]*\(.*\)/am_cv_python_CCSHARED='\1'/p" \
-e "s/^LDSHARED=[ 	]*\(.*\)/am_cv_python_LDSHARED='\1'/p" \
-e "s/^SO=[ 	]*\(.*\)/am_cv_python_SO='\1'/p" \
    $py_makefile`
    am_cv_python_makefile=found
    changequote([, ])])
  AC_MSG_RESULT(done)
  CC="$am_cv_python_CC"
  OPT="$am_cv_python_OPT"
  SO="$am_cv_python_SO"
  PYTHON_CFLAGS="$am_cv_python_CCSHARED \$(OPT)"
  PYTHON_LINK="$am_cv_python_LDSHARED -o \[$]@"

  AC_SUBST(CC)dnl
  AC_SUBST(OPT)dnl
  AC_SUBST(SO)dnl
  AC_SUBST(PYTHON_CFLAGS)dnl
  AC_SUBST(PYTHON_LINK)])


