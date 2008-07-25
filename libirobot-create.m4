# This file is part of the libirobot-create.                     -*-Autoconf-*-
#
# libirobot-create is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Additional permission under section 7 of the GNU General Public
# License, version 3 ("GPLv3"):
#
# If you convey this file as part of a work that contains a
# configuration script generated by Autoconf, you may do so under
# terms of your choice.
#
# libirobot-create is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with libirobot-create.  If not, see <http://www.gnu.org/licenses/>.

# serial 1

# ------ #
# README #
# ------ #

# This m4 file can be used to check for the libirobot-create library.
# You can copy it into your software's aux dir and call the following
# macro to check for the library.
#
# LIBIROBOT_CREATE_LIB: check for the library
# LIBIROBOT_CREATE_LIB: check for the headers
# LIBIROBOTE_CREATE_LIB_ARG_WITH: add an optional dependency on the
# package using AC_ARG_WITH.
#
# You probably want to use the first two macros with AC_MSG_FAILURE
# to add a hard dependency on the library.

m4_pattern_forbid([^LIBIROBOT_CREATE_])

# LIBIROBOT_CREATE_LIB([action-if-found], [action-if-not-found])
# --------------------------------------------------------------
# Try to detect the library.
AC_DEFUN([LIBIROBOT_CREATE_LIB],
[AC_CHECK_LIB([irobot-create], [main], $1, $2)
]) # LIBIROBOT_CREATE_LIB

# LIBIROBOT_CREATE_HEADERS([action-if-found], [action-if-not-found])
# ------------------------------------------------------------------
# Try to detect the library headers.
AC_DEFUN([LIBIROBOT_CREATE_HEADERS],
[AC_CHECK_HEADERS([irobot-create.hh], $1, $2)
]) # LIBIROBOT_CREATE_HEADERS


# LIBIROBOTE_CREATE_LIB_ARG_WITH
# ------------------------------
# Add an optional dependency toward libirobot-create.
AC_DEFUN([LIBIROBOT_CREATE_ARG_WITH],
[
  AC_ARG_WITH([libirobot-create],
  [AS_HELP_STRING([--with-libirobot-create],
    [enable libirobot-create support])],
  [],
  [with_libirobot_create=check])

  AC_SUBST([DISTCHECK_CONFIGURE_FLAGS],
           ["$DISTCHECK_CONFIGURE_FLAGS \
	   '--with-libirobot-create=$with_libirobot_create'"])

  irobot_create_fail=no
  AS_IF([test "x$with_libirobot_create" != xno],
    [
      # Search for libirobot-create library.
      LIBIROBOT_CREATE_LIB([], [libirobot_create_fail=yes])

      # Search for libirobot-create headers.
      LIBIROBOT_CREATE_HEADERS([], [libirobot_create_fail=yes])

      # If both tests are OK, add the library and define the CPP symbol.
      AS_IF([test "x$libirobot_create_faild" = xno],
	[AC_SUBST([LIBIROBOT_CREATE], ["-lirobot-create"])
	 AC_DEFINE([HAVE_LIBIROBOT_CREATE], [1],
                   [Define if you have libirobot-create])])

      # If the support was explicitly required, but detection has failed,
      # this is a fatal error.
      AS_IF([test "x$with_libirobot_create" = xyes && \
             test "x$libirobot_create_fail" = xyes],
        [AC_MSG_FAILURE(
        [libirobot-create test failed (--without-libirobot-create to disable)])
        ])
    ])

  # Define a boolean indicating whether or not the package has been found.
  AM_CONDITIONAL([LIBIROBOT_CREATE],
                 [test "x$with_libirobot_create" != xno && \
		  test "x$libirobot_create_fail" != xyes])
]) # LIBIROBOT_CREATE_ARG_WITH
