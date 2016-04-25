# .rst:
# FindGLFW
# --------
#
# Try to find GLFW windowing library
#
# Once done this defines
#
# ::
#
#   GLFW_FOUND - System has GLFW
#   GLFW_INCLUDE_DIRS - GLFW include directory
#   GLFW_LIBRARIES - Libraries needed for usage
#=============================================================================
# Copyright 2016 Cookiemon <rhannek@gmx.de>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file LICENSE in the root folder for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================

find_path(GLFW_INCLUDE_DIR GLFW/glfw3.h)
find_library(GLFW_LIBRARY NAMES glfw glfw3)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLFW REQUIRED_VARS GLFW_INCLUDE_DIR GLFW_LIBRARY)

mark_as_advanced(GLFW_INCLUDE_DIR GLFW_LIBRARY)

# FreeBSD ships glfw as a static library, so dependencies must be linked
# TODO: Make it less broken. (Forward find arguments, check errors)
get_filename_component(_ext "${GLFW_LIBRARY}" EXT )
if("${_ext}" STREQUAL .a)
	if(${GLFW_FIND_QUIETLY})
		set(_find_package_args QUIETLY)
	else()
		message(STATUS "GLFW built as static library, adding x11 dependencies")
	endif()
	if(GLFW_FIND_REQUIRED)
		list(APPEND _find_package_args REQUIRED)
	endif()
	find_package(X11 ${_find_package_args})
	# Shamelessly copied from CMakeLists.txt of GLFW

  # Set up library and include paths
  list(APPEND glfw_INCLUDE_DIRS "${X11_X11_INCLUDE_PATH}")
  list(APPEND glfw_LIBRARIES "${X11_X11_LIB}" "${CMAKE_THREAD_LIBS_INIT}")

  # Check for XRandR (modern resolution switching and gamma control)
  if (NOT X11_Xrandr_FOUND)
      message(FATAL_ERROR "The RandR library and headers were not found")
  endif()

  list(APPEND glfw_INCLUDE_DIRS "${X11_Xrandr_INCLUDE_PATH}")
  list(APPEND glfw_LIBRARIES "${X11_Xrandr_LIB}")
  list(APPEND glfw_PKG_DEPS "xrandr")

  # Check for Xinerama (legacy multi-monitor support)
  if (NOT X11_Xinerama_FOUND)
      message(FATAL_ERROR "The Xinerama library and headers were not found")
  endif()

  list(APPEND glfw_INCLUDE_DIRS "${X11_Xinerama_INCLUDE_PATH}")
  list(APPEND glfw_LIBRARIES "${X11_Xinerama_LIB}")
  list(APPEND glfw_PKG_DEPS "xinerama")

  # Check for XInput (high-resolution cursor motion)
  if (X11_Xinput_FOUND)
      list(APPEND glfw_INCLUDE_DIRS "${X11_Xinput_INCLUDE_PATH}")
      list(APPEND glfw_PKG_DEPS "xi")

      if (X11_Xinput_LIB)
          list(APPEND glfw_LIBRARIES "${X11_Xinput_LIB}")
      else()
          # Backwards compatibility (bug in CMake 2.8.7)
          list(APPEND glfw_LIBRARIES Xi)
      endif()

      set(_GLFW_HAS_XINPUT TRUE)
  endif()

  # Check for Xf86VidMode (fallback gamma control)
  if (X11_xf86vmode_FOUND)
      list(APPEND glfw_INCLUDE_DIRS "${X11_xf86vmode_INCLUDE_PATH}")
      list(APPEND glfw_PKG_DEPS "xxf86vm")

      if (X11_Xxf86vm_LIB)
          list(APPEND glfw_LIBRARIES "${X11_Xxf86vm_LIB}")
      else()
          # Backwards compatibility (see CMake bug 0006976)
          list(APPEND glfw_LIBRARIES Xxf86vm)
      endif()

      set(_GLFW_HAS_XF86VM TRUE)
  endif()

  # Check for Xkb (X keyboard extension)
  if (NOT X11_Xkb_FOUND)
      message(FATAL_ERROR "The X keyboard extension headers were not found")
  endif()

  list(APPEND glfw_INCLUDE_DIR "${X11_Xkb_INCLUDE_PATH}")

  # Check for Xcursor
  if (NOT X11_Xcursor_FOUND)
      message(FATAL_ERROR "The Xcursor libraries and headers were not found")
  endif()

  list(APPEND glfw_LIBRARIES "${X11_Xcursor_LIB}")

	# End of copy

	find_package(Threads ${_find_package_args})

	set(_additional_libs ${CMAKE_THREAD_LIBS_INIT} ${glfw_LIBRARIES})

	find_package(OpenGL ${_find_package_args})
	if(OPENGL_FOUND)
		list(APPEND _additional_libs ${OPENGL_gl_LIBRARY})
	endif()

	#ASSERT: LIB_M and LIB_RT are accessible and found
	find_library(LIB_M m)
	find_library(LIB_RT rt)
	list(APPEND _additional_libs ${LIB_M} ${LIB_RT})
endif()

set(GLFW_INCLUDE_DIRS "${GLFW_INCLUDE_DIR}")
set(GLFW_LIBRARIES "${GLFW_LIBRARY}" ${_additional_libs})

