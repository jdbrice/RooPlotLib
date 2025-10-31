# Sources: list explicitly (recommended) or use a glob if you prefer
file( GLOB XMLCONFIG_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
file( GLOB XMLCONFIG_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/*.h" )


# OBJECT library (used to compose the combined lib)
add_library(RooPlotLib_obj OBJECT ${XMLCONFIG_SOURCES} ${XMLCONFIG_HEADERS})
target_include_directories(RooPlotLib_obj PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/ ${CMAKE_SOURCE_DIR}/ )
target_link_libraries(RooPlotLib_obj PUBLIC XmlConfig)

# Actual library for this component
if(BUILD_SHARED_LIBS)
  add_library(RooPlotLib SHARED $<TARGET_OBJECTS:RooPlotLib_obj>)
else()
  add_library(RooPlotLib STATIC $<TARGET_OBJECTS:RooPlotLib_obj>)
endif()
target_include_directories(RooPlotLib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/ ${CMAKE_SOURCE_DIR}/)
target_link_libraries(RooPlotLib PUBLIC XmlConfig)

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


