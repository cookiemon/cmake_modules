# .rst:
# FindGLM
# --------
#
# Try to find GLM math library
#
# Once done this defines
#
# ::
#
#   GLM_FOUND - System has GLM
#   GLM_INCLUDE_DIRS - GLM include directory
#   GLM_LIBRARIES - Libraries needed for usage
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

find_path(GLM_INCLUDE_DIR glm/glm.hpp)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLM REQUIRED_VARS GLM_INCLUDE_DIR)

mark_as_advanced(GLM_INCLUDE_DIR)

set(GLM_INCLUDE_DIRS "${GLM_INCLUDE_DIR}")

