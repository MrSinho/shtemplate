cmake_minimum_required(VERSION 3.0)
add_definitions(-DCMAKE_EXPORT_COMPILE_COMMANDS=ON)



#|||
#|||DOCS GENERATION
#|||
find_package(Doxygen)
if (DOXYGEN_FOUND)

    set(SH_DOXYFILE_SRC ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in)
    set(SH_DOXYFILE_DST ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile)

    configure_file(
        ${SH_DOXYFILE_SRC} 
        ${SH_DOXYFILE_DST} 
        @ONLY
    )

    add_custom_target(docs-shtemplate
        COMMAND ${DOXYGEN_EXECUTABLE} ${SH_DOXYFILE_DST}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating HTML documentation"
        VERBATIM
    )

endif(DOXYGEN_FOUND)



#||||         ||||
#||||EXTERNALS||||
#||||         ||||



#||||       ||||
#||||PROJECT||||
#||||       ||||
project(shtemplate C)



#||||       ||||
#||||LIBRARY||||
#||||       ||||
function(build_shtemplate)
add_library(shtemplate shtemplate/src/shtemplate.c)
target_include_directories(shtemplate PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/shtemplate/include
)
set_target_properties(shtemplate PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
)
endfunction()



#||||       ||||
#||||SAMPLES||||
#||||       ||||
function(build_shtemplate_sample)
add_executable(shtemplate-sample sample/src/shtemplate-sample.c)
target_link_libraries(shtemplate-sample PUBLIC shtemplate)
set_target_properties(shtemplate-sample PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
    VS_DEBUGGER_WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
)
endfunction()



#||||           ||||
#||||OS SPECIFIC||||
#||||           ||||
if (WIN32)
else()
endif(WIN32)
if(UNIX)
else()
endif(UNIX)



#||||                 ||||
#||||COMPILER SPECIFIC||||
#||||                 ||||
if(MSVC)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()



#||||     ||||
#||||FLAGS||||
#||||     ||||
option(SH_TEMPLATE_BUILD_SAMPLE CACHE OFF)



#||||    ||||
#||||MAIN||||
#||||    ||||
function(main)
build_shtemplate()
if (SH_TEMPLATE_BUILD_SAMPLE)
    build_shtemplate_sample()
endif(SH_TEMPLATE_BUILD_SAMPLE)
endfunction()



#||||          ||||
#||||CMAKE MAIN||||
#||||          ||||
main()
