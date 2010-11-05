PROJECT(helloworld C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
SET(PRODUCT_VERSION_MAJOR 1)
SET(PRODUCT_VERSION_MINOR 2)
SET(PRODUCT_VERSION_PATCH 3)

# product options
OPTION(BUILD_WITH_COVERAGE "Build with coverage analysis support" OFF)

ADD_SUBDIRECTORY(hellolib)

INCLUDE_DIRECTORIES(hellolib)

SET(helloworld_SRCS main.c)

ADD_EXECUTABLE(helloworld ${helloworld_SRCS})
TARGET_LINK_LIBRARIES(helloworld hellolib)

# INSTALL Target
INSTALL(TARGETS helloworld
        # .exe, .dll
        RUNTIME DESTINATION bin COMPONENT Runtime
        # .so, .sl, ...
        LIBRARY DESTINATION lib COMPONENT Runtime
        # .a, .lib
        ARCHIVE DESTINATION lib COMPONENT Develop
)

# Generate Doxygen API Docu
FIND_PACKAGE(Doxygen)
IF(DOXYGEN_FOUND)
  ADD_CUSTOM_TARGET(doxygen ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/../doc/Doxyfile 
      COMMENT "Generating Doxygen API Documentation")
  INSTALL(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html
      DESTINATION doc COMPONENT Documentation
  )
  ADD_DEPENDENCIES(helloworld doxygen)
ENDIF(DOXYGEN_FOUND)
	
# Packaging
IF(WIN32)
  SET(CPACK_GENERATOR "NSIS")
ENDIF(WIN32)
IF(UNIX)
  SET(CPACK_GENERATOR "STGZ;TGZ;DEB;RPM")
ENDIF(UNIX)
SET(CPACK_PACKAGE_NAME                  "HelloWorld")
SET(CPACK_PACKAGE_ICON                  "${CMAKE_CURRENT_SOURCE_DIR}/../setup/hello.ico")
SET(CPACK_PACKAGE_VENDOR                "ACME Inc.")
SET(CPACK_PACKAGE_DESCRIPTION_FILE      "${CMAKE_CURRENT_SOURCE_DIR}/../setup/README.TXT")
SET(CPACK_RESOURCE_FILE_LICENSE         "${CMAKE_CURRENT_SOURCE_DIR}/../setup/COPYRIGHT.TXT")
SET(CPACK_PACKAGE_VERSION_MAJOR         "${PRODUCT_VERSION_MAJOR}")
SET(CPACK_PACKAGE_VERSION_MINOR         "${PRODUCT_VERSION_MINOR}")
SET(CPACK_PACKAGE_VERSION_PATCH         "${PRODUCT_VERSION_PATCH}")
SET(CPACK_PACKAGE_INSTALL_DIRECTORY     "ACME\\\\HelloWorld-${PRODUCT_VERSION_MAJOR}.${PRODUCT_VERSION_MINOR}.${PRODUCT_VERSION_PATCH}")
SET(CPACK_SOURCE_PACKAGE_FILE_NAME "helloworld-${PRODUCT_VERSION_MAJOR}.${PRODUCT_VERSION_MINOR}.${PRODUCT_VERSION_PATCH}")
IF(WIN32)
  # There is a bug in NSIS that does not handle full
  # unix paths properly. Make sure there is at least
  # one set of four (4) backslashes.
  SET(CPACK_PACKAGE_ICON                "${CMAKE_CURRENT_SOURCE_DIR}\\\\..\\\\setup\\\\hello.ico")
  SET(CPACK_NSIS_INSTALLED_ICON_NAME    "bin\\\\helloworld.exe")
  # displayname is used for the installer and as start menu folder.
  # how can we change the start menu to ACME\HelloWorld???
  SET(CPACK_NSIS_DISPLAY_NAME           "Hello World")
  SET(CPACK_NSIS_HELP_LINK              "http://doc.acme.com")
  SET(CPACK_NSIS_URL_INFO_ABOUT         "http://www.acme.com")
  SET(CPACK_NSIS_CONTACT                "support@acme.com")
ELSE(WIN32)
  SET(CPACK_STRIP_FILES                 "bin/helloworld")
  SET(CPACK_SOURCE_STRIP_FILES          "")
  # avoid warning about invalid escape sequence with default value "ACME\HelloWorld" when generating on linux
  SET(CPACK_NSIS_DISPLAY_NAME           "")
  # set info for debian packages
  SET(CPACK_PACKAGE_CONTACT             "support@acme.com")
  SET(CPACK_DEBIAN_PACKAGE_MAINTAINER   "ACME Inc.")
ENDIF(WIN32)
# create start menu entries for executables
SET(CPACK_PACKAGE_EXECUTABLES           "helloworld" "Hello World App")
INCLUDE(CPack)

# Configure Tools
IF(WIN32)
  # TODO: git does not work if it cannot find it's HOME variable and the SSH public key
  SET(GITCOMMAND "$ENV{PROGRAMFILES}\\Git\\bin\\git.exe")
ENDIF(WIN32)

IF(UNIX)
  SET(MEMORYCHECK_COMMAND "/usr/bin/valgrind")
  SET(COVERAGE_COMMAND "/usr/bin/gcov")
ENDIF()

# Unit Test
INCLUDE(CTest)
IF(BUILD_TESTING)

IF(BUILD_WITH_COVERAGE)
    # enable coverage analysis using GCC and GCOV
    IF (CMAKE_COMPILER_IS_GNUCC)
        SET(CMAKE_C_FLAGS "-g -O0 -Wall -fprofile-arcs -ftest-coverage")
        SET(CMAKE_CXX_FLAGS "-g -O0 -Wall -fprofile-arcs -ftest-coverage")
        SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-arcs -ftest-coverage -lgcov")
    ENDIF()
ENDIF(BUILD_WITH_COVERAGE)

# ADD_TEST(<TestName> <Executable> [<Arguments...>]
ADD_TEST(SimpleTest ${EXECUTABLE_OUTPUT_PATH}/helloworld 5 3)
SET_TESTS_PROPERTIES(SimpleTest PROPERTIES PASS_REGULAR_EXPRESSION "= 15")

ADD_TEST(NegativeTest ${EXECUTABLE_OUTPUT_PATH}/helloworld -5 3)
SET_TESTS_PROPERTIES(NegativeTest PROPERTIES PASS_REGULAR_EXPRESSION "= -15")

ADD_TEST(DoubleNegativeTest ${EXECUTABLE_OUTPUT_PATH}/helloworld -5 -3)
SET_TESTS_PROPERTIES(DoubleNegativeTest PROPERTIES PASS_REGULAR_EXPRESSION "= 15")   

ENDIF(BUILD_TESTING)
