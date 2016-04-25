# .rst:
# FindRocket
# --------
#
# Try to find libRocket gui library
#
# Once done this defines
#
# ::
#
#   Rocket_FOUND - System has Rocket
#   Rocket_INCLUDE_DIRS - Rocket include directory
#   Rocket_LIBRARIES - Libraries needed for usage
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

#TODO: make modules seperately linkable?
find_path(Rocket_INCLUDE_DIR Rocket/Core.h)
find_library(Rocket_LIBRARY_CORE NAMES RocketCore)
find_library(Rocket_LIBRARY_CONTROLS NAMES RocketControls)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Rocket REQUIRED_VARS Rocket_INCLUDE_DIR Rocket_LIBRARY_CORE Rocket_LIBRARY_CONTROLS)

mark_as_advanced(Rocket_INCLUDE_DIR Rocket_LIBRARY)

set(Rocket_INCLUDE_DIRS ${Rocket_INCLUDE_DIR})
set(Rocket_LIBRARIES ${Rocket_LIBRARY_CORE} ${Rocket_LIBRARY_CONTROLS})

