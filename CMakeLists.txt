######################################################################################################################
#
# JeVois Smart Embedded Machine Vision Toolkit - Copyright (C) 2016 by Laurent Itti, the University of Southern
# California (USC), and iLab at USC. See http://iLab.usc.edu and http://jevois.org for information about this project.
#
# This file is part of the JeVois Smart Embedded Machine Vision Toolkit.  This program is free software; you can
# redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2.  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.  You should have received a copy of the GNU General Public License along with this program;
# if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# Contact information: Laurent Itti - 3641 Watt Way, HNB-07A - Los Angeles, BA 90089-2520 - USA.
# Tel: +1 213 740 3527 - itti@pollux.usc.edu - http://iLab.usc.edu - http://jevois.org
######################################################################################################################

## CMake build rules for JeVois Base library and executables

## You may provide the installed JeVois config root as:
#   cmake -DJEVOIS_CONFIG=/jevois/config ..

cmake_minimum_required(VERSION 3.1)

## Set vendor names, our modules will be placed in a directory by that name under /jevois/modules:
set(JEVOIS_VENDOR "SampleVendor")
if (JEVOIS_HARDWARE STREQUAL "PRO")
  set(JEVOIS_CONFIG "/jevoispro/config" CACHE STRING "Path to JeVois config to use")
else()
  set(JEVOIS_CONFIG "/jevois/config" CACHE STRING "Path to JeVois config to use")
endif()

## Set a version for your module, used to create the .deb package for platform:
set(MOD_VERSION_MAJOR 1)
set(MOD_VERSION_MINOR 0)
set(MOD_VERSION_PATCH 0)

## Include helper functions, config, etc from the JeVois install:
set(CMAKE_MODULE_PATH ${JEVOIS_CONFIG})
include(jevois_config)
include(JeVois)

## Set project name, detects compiler (which has been set by our helper module). Then set some complation flags:
project(samplemodule)
jevois_project_set_flags()
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

## If your module will use components provided by jevoisbase, uncomment the lines below:
#if (JEVOIS_PLATFORM)
#  link_directories("/var/lib/${JEVOIS}-microsd/lib/JeVois") # find libjevoisbase.so for platform
#endif (JEVOIS_PLATFORM)
#include_directories("/var/lib/${JEVOIS}-build/usr/include") # find jevoisbase includes

## If you also want to use some of the jevoisbase contribs, just add the appropriate include paths here.  You will also
## need to set JEVOIS_SRC_ROOT environment variable in your shell to the parent of the jevoisbase directory, e.g., type:
#   export JEVOIS_SRC_ROOT=/home/myname
## in your shell.
#include_directories("$ENV{JEVOIS_SRC_ROOT}/jevoisbase/Contrib/darknet-nnpack/include")
#include_directories("$ENV{JEVOIS_SRC_ROOT}/jevoisbase/Contrib/NNPACK/include")
#include_directories("$ENV{JEVOIS_SRC_ROOT}/jevoisbase/Contrib/pthreadpool/include")

## Setup our modules that are in src/Modules. First arg: source directory for modules; 2nd arg: target build
## dependencies (i.e., cmake targets which must be built here before we build the modules), usually empty for a single
## module. See the CMakeLists.txt in jevoisbase for an example where we first build a shared library for all shared
## components, and then each module gets this library as a target dependency:
jevois_setup_modules(src/Modules "")

## Add any link libraries for each module. Add '${JEVOIS}base' here if you want to link against it:
target_link_libraries(SampleModule ${JEVOIS_OPENCV_LIBS} opencv_imgproc opencv_core)

## Install any shared resources (cascade classifiers, neural network weights, etc) in the share/ sub-directory:
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/share-${JEVOIS}/"
  DESTINATION "${JEVOIS_MODULES_ROOT}/share" COMPONENT bin)

########################################################################################################################
# Debian packaging:

# To list the files created in a package, run: dpkg -c <package.deb>
set(CPACK_PACKAGE_DESCRIPTION "JeVois SampleModule")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "JeVois SampleModule")
set(CPACK_PACKAGE_CONTACT "Laurent Itti <jevois.org@gmail.com>")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER ${CPACK_PACKAGE_CONTACT})
set(CPACK_DEBIAN_PACKAGE_SECTION "universe")
set(CPACK_PACKAGE_VENDOR "SampleVendor")
set(CPACK_PACKAGE_VERSION_MAJOR "${MOD_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${MOD_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${MOD_VERSION_PATCH}")
set(JEVOIS_PACKAGE_RELEASE "1") # packager revision number

if (JEVOIS_PLATFORM)
  set(JEVOIS_DEPEND "${JEVOIS}-platform (>=${JEVOIS_VERSION_MAJOR}.${JEVOIS_VERSION_MINOR}.${JEVOIS_VERSION_PATCH})")
else (JEVOIS_PLATFORM)
  set(JEVOIS_DEPEND "${JEVOIS}-host (>=${JEVOIS_VERSION_MAJOR}.${JEVOIS_VERSION_MINOR}.${JEVOIS_VERSION_PATCH})")
endif (JEVOIS_PLATFORM)

# Add any other dependencies here for the package, separated by commas:
set(CPACK_DEBIAN_PACKAGE_DEPENDS "${JEVOIS_DEPEND}")

# Use helper from JeVois.cmake for all other settings:
jevois_setup_cpack(samplemodule)

## Wrapping up:
jevois_project_finalize()  # call this last in your CMakeLists.txt, will un-mount the live microSD if applicable
