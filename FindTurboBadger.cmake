# .rst:
# FindTurboBadger
# --------
#
# Try to find TurboBadger gui library
#
# Once done this defines
#
# ::
#
#   TurboBadger_FOUND - System has TurboBadger
#   TurboBadger_INCLUDE_DIRS - TurboBadger include directory
#   TurboBadger_LIBRARIES - Libraries needed for usage
#=============================================================================
# Copyright 2016 Cookiemon <mood@keksdie.be>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file LICENSE in the root folder for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================

find_path(TurboBadger_INCLUDE_DIR tb/tb_config.h)
find_library(TurboBadger_LIBRARY NAMES TurboBadgerLib)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TurboBadger REQUIRED_VARS TurboBadger_INCLUDE_DIR TurboBadger_LIBRARY)

mark_as_advanced(TurboBadger_INCLUDE_DIR TurboBadger_LIBRARY)

set(TurboBadger_INCLUDE_DIRS "${TurboBadger_INCLUDE_DIR}")
set(TurboBadger_LIBRARIES "${TurboBadger_LIBRARY}")

