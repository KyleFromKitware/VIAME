message("Running fletch install")

include( ${VIAME_CMAKE_DIR}/common_macros.cmake )

if( VIAME_ENABLE_PYTHON AND EXISTS ${VIAME_BUILD_PREFIX}/src/fletch-build/build/src/Boost/boost/python/raw_function.hpp )

  file( COPY ${VIAME_BUILD_PREFIX}/src/fletch-build/build/src/Boost/boost/python/raw_function.hpp
        DESTINATION ${VIAME_BUILD_INSTALL_PREFIX}/include/boost/python/ )

endif()

if( WIN32 )

  if( MSVC AND MSVC_VERSION EQUAL 1900 )
    RenameSubstr( ${VIAME_BUILD_INSTALL_PREFIX}/lib/libboost* vc120 vc140 )
  endif()

  if( VIAME_ENABLE_OPENCV )
    CopyFiles( ${VIAME_BUILD_INSTALL_PREFIX}/x64/*/bin/*.dll ${VIAME_BUILD_INSTALL_PREFIX}/bin )
  endif()

endif()

message("Done")
