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

# CMake build rules for JeVois Base library and executables

# You may provide the installed JeVois config root as:
#   cmake -DJEVOIS_CONFIG=/jevois/config ..

cmake_minimum_required(VERSION 3.1)

# Set vendor names, our modules will be placed in a directory by that name under /jevois/modules:
set(JEVOIS_VENDOR "SampleVendor")
set(JEVOIS_CONFIG "/jevois/config" CACHE STRING "Path to JeVois config to use")

# Include helper functions, config, etc from the JeVois install:
set(CMAKE_MODULE_PATH ${JEVOIS_CONFIG})
include(jevois_config)
include(JeVois)

# Set project name, detects compiler (which has been set by our helper module). Then set some complation flags:
project(samplemodule)
jevois_project_set_flags()
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Setup our modules that are in src/Modules. First arg: source directory for modules; 2nd arg: target dependencies,
# usually empty for a single module. See the CMakeLists.txt in jevoisbase for an example where we first build a shared
# library for all shared components, and then each module gets this library as a target dependency:
jevois_setup_modules(src/Modules "")

# Add any link libraries for each module:
target_link_libraries(SampleModule ${JEVOIS_OPENCV_LIBS} opencv_imgproc opencv_core)

# Wrapping up:
jevois_project_finalize()  # call this last in your CMakeLists.txt, will un-mount the live microSD if applicable
