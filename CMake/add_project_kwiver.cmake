# kwiver External Project
#
# Required symbols are:
#   VIAME_BUILD_PREFIX - where packages are built
#   VIAME_BUILD_INSTALL_PREFIX - directory install target
#   VIAME_PACKAGES_DIR - location of git submodule packages
#   VIAME_ARGS_COMMON -
##

set( VIAME_PROJECT_LIST ${VIAME_PROJECT_LIST} kwiver )

FormatPassdowns( "MATLAB" VIAME_MATLAB_FLAGS )

ExternalProject_Add(kwiver
  DEPENDS fletch
  PREFIX ${VIAME_BUILD_PREFIX}
  SOURCE_DIR ${VIAME_PACKAGES_DIR}/kwiver
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS
    ${VIAME_ARGS_COMMON}
    ${VIAME_ARGS_fletch}
    ${VIAME_MATLAB_FLAGS}

    # Required
    -DKWIVER_ENABLE_ARROWS:BOOL=ON
    -DKWIVER_ENABLE_TOOLS:BOOL=ON
    -DKWIVER_ENABLE_SPROKIT:BOOL=ON
    -DKWIVER_ENABLE_PROCESSES:BOOL=ON

    # Optional
    -DKWIVER_ENABLE_OPENCV:BOOL=${VIAME_ENABLE_OPENCV}
    -DKWIVER_ENABLE_VXL:BOOL=${VIAME_ENABLE_VXL}
    -DKWIVER_ENABLE_MATLAB:BOOL=${VIAME_ENABLE_MATLAB}
    -DKWIVER_ENABLE_C_BINDINGS:BOOL=${VIAME_ENABLE_PYTHON}
    -DKWIVER_ENABLE_PYTHON:BOOL=${VIAME_ENABLE_PYTHON}
    -DKWIVER_ENABLE_DOCS:BOOL=${VIAME_ENABLE_DOCS}
    -DKWIVER_INSTALL_DOCS:BOOL=${VIAME_ENABLE_DOCS}

  INSTALL_DIR ${VIAME_BUILD_INSTALL_PREFIX}
  )

ExternalProject_Add_Step(kwiver forcebuild
  COMMAND ${CMAKE_COMMAND}
    -E remove ${VIAME_BUILD_PREFIX}/src/kwiver-stamp/kwiver-build
  COMMENT "Removing build stamp file for build update (forcebuild)."
  DEPENDEES configure
  DEPENDERS build
  ALWAYS 1
  )

set(VIAME_ARGS_kwiver
  -Dkwiver_DIR:PATH=${VIAME_BUILD_PREFIX}/src/kwiver-build
  )
