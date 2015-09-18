# - Try to find librdkafka include dirs and libraries
#
# Usage of this module as follows:
#
#     find_package(RdKafka)
#
# Variables used by this module, they can change the default behaviour and need
# to be set before calling find_package:
#
#  RdKafka_ROOT_DIR             Set this variable to the root installation of
#                            librdkafka if the module has problems finding the
#                            proper installation path.
#
# Variables defined by this module:
#
#  RdKafka_FOUND                System has librdkafka, include and library dirs found
#  RdKafka_INCLUDE_DIR          The librdkafka include directories.
#  RdKafka_LIBRARY              The librdkafka library (possibly includes a thread
#                            library e.g. required by pf_ring's librdkafka)
#  HAVE_PF_RING              If a found version of librdkafka supports PF_RING

find_path(RdKafka_ROOT_DIR
    NAMES include/librdkafka/rdkafkacpp.h
)

find_path(RdKafka_INCLUDE_DIR
    NAMES librdkafka/rdkafkacpp.h
    HINTS ${RdKafka_ROOT_DIR}/include
)

find_library(RdKafka_LIBRARY
    NAMES rdkafka++
    HINTS ${RdKafka_ROOT_DIR}/lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(RdKafka DEFAULT_MSG
    RdKafka_LIBRARY
    RdKafka_INCLUDE_DIR
)

include(CheckCSourceCompiles)
set(CMAKE_REQUIRED_LIBRARIES ${RdKafka_LIBRARY})
check_c_source_compiles("int main() { return 0; }" RdKafka_LINKS_SOLO)
set(CMAKE_REQUIRED_LIBRARIES)

# check if linking against librdkafka also needs to link against a thread library
if (NOT RdKafka_LINKS_SOLO)
    find_package(Threads)
    if (THREADS_FOUND)
        set(CMAKE_REQUIRED_LIBRARIES ${RdKafka_LIBRARY} ${CMAKE_THREAD_LIBS_INIT})
        check_c_source_compiles("int main() { return 0; }" RdKafka_NEEDS_THREADS)
        set(CMAKE_REQUIRED_LIBRARIES)
    endif ()
    if (THREADS_FOUND AND RdKafka_NEEDS_THREADS)
        set(_tmp ${RdKafka_LIBRARY} ${CMAKE_THREAD_LIBS_INIT})
        list(REMOVE_DUPLICATES _tmp)
        set(RdKafka_LIBRARY ${_tmp}
            CACHE STRING "Libraries needed to link against librdkafka" FORCE)
    else ()
        message(FATAL_ERROR "Couldn't determine how to link against librdkafka")
    endif ()
endif ()

include(CheckFunctionExists)
set(CMAKE_REQUIRED_LIBRARIES ${RdKafka_LIBRARY})
#check_function_exists(rdkafka_get_pfring_id HAVE_PF_RING)
set(CMAKE_REQUIRED_LIBRARIES)

mark_as_advanced(
    RdKafka_ROOT_DIR
    RdKafka_INCLUDE_DIR
    RdKafka_LIBRARY
)
