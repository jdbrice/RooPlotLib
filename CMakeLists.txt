cmake_minimum_required(VERSION 3.10)
project(RooPlotLib)

add_library(RooPlotLib SHARED RooPlotLib.cpp)

# Run root-config to get flags
execute_process(
  COMMAND root-config --cflags
  OUTPUT_VARIABLE ROOT_CFLAGS
  OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
  COMMAND root-config --libs
  OUTPUT_VARIABLE ROOT_LIBS
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

separate_arguments(ROOT_CFLAGS)
separate_arguments(ROOT_LIBS)

target_compile_options(RooPlotLib PRIVATE ${ROOT_CFLAGS})
target_link_libraries(RooPlotLib PRIVATE ${ROOT_LIBS})

set_target_properties(RooPlotLib PROPERTIES LINK_FLAGS "-m32")



# find_library(XMLCONFIG_LIB
#     NAMES XMLConfig
#     HINTS ${CMAKE_SOURCE_DIR}/../XmlConfig/build ${CMAKE_SOURCE_DIR}/XmlConfig/build
#     NO_DEFAULT_PATH
# )
# message(STATUS "Found XmlConfig: ${XMLCONFIG_LIB}")
# target_link_libraries(RooPlotLib PRIVATE ${XMLCONFIG_LIB})

add_compile_options("-m32")

target_include_directories(RooPlotLib PRIVATE
  ${CMAKE_SOURCE_DIR}/XmlConfig
  ${CMAKE_SOURCE_DIR}/
)
set_property(TARGET RooPlotLib PROPERTY CXX_STANDARD 11)