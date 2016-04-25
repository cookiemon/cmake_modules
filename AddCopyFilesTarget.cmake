# .rst:
# FindGLFW
# --------
#
# ::
#
#  add_copy_files(target [file1 [file2 [...] ] ])
#
# Adds a target that copies the list of files to the output directory if they
# do not exist or have been modified.
#
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

include(CMakeParseArguments)

function(add_copy_files target)
	cmake_parse_arguments(add_copy_files "" "DESTINATION" "FILES" ${ARGN})
	set(destdir "${CMAKE_BINARY_DIR}/${add_copy_files_DESTINATION}")

	foreach(i ${add_copy_files_FILES})
		get_filename_component(fname "${i}" NAME)
		string(REPLACE " " "_" copytarget "${fname}_copy")
		set(target_path "${destdir}/${fname}")
		set(source_path "${CMAKE_CURRENT_SOURCE_DIR}/${i}")
		add_custom_command(OUTPUT "${target_path}"
			COMMAND cp "${CMAKE_CURRENT_SOURCE_DIR}/${i}" "${target_path}"
			MAIN_DEPENDENCY "${source_path}"
		)
		add_custom_target("${copytarget}" DEPENDS "${target_path}")
		add_dependencies(${target} "${copytarget}")
	endforeach()
endfunction()

