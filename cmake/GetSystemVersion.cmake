set(SUBSYSTEM_NAME "" CACHE STRING "Subsystem name")
if(MSVC)
	set(SYSTEM_NAME "Win")
	if(NOT SUBSYSTEM_NAME)
		if(CMAKE_SIZEOF_VOID_P MATCHES 8)
			set(SUBSYSTEM_NAME "x64")
		else()
			set(SUBSYSTEM_NAME "x86")
		endif()
	endif()
	set(SYSTEM_DL_EXTENSION ".dll")
elseif(APPLE)
	set(SYSTEM_NAME "Mac")
	if(NOT SUBSYSTEM_NAME)
		exec_program(uname ARGS -v  OUTPUT_VARIABLE DARWIN_VERSION)
		string(REGEX MATCH "[0-9]+" DARWIN_VERSION ${DARWIN_VERSION})
		if(DARWIN_VERSION MATCHES 8)
			set(SUBSYSTEM_NAME "10.4")
		elseif(DARWIN_VERSION MATCHES 9)
			set(SUBSYSTEM_NAME "10.5")
		elseif(DARWIN_VERSION MATCHES 10)
			set(SUBSYSTEM_NAME "10.6")
		elseif(DARWIN_VERSION MATCHES 11)
			set(SUBSYSTEM_NAME "10.6")
		elseif(DARWIN_VERSION MATCHES 12)
			set(SUBSYSTEM_NAME "10.6")
		elseif()
			message(FATAL_ERROR "Unsupported DARWIN_VERSION: ${DARWIN_VERSION}")
		endif()
	endif()	
	set(SYSTEM_DL_EXTENSION ".dylib")
elseif(UNIX)
	set(SYSTEM_NAME "Linux")
	if(NOT SUBSYSTEM_NAME)
		if(CMAKE_SIZEOF_VOID_P MATCHES 8)
			set(SUBSYSTEM_NAME "x64")
		else()
			set(SUBSYSTEM_NAME "x86")
		endif()
	endif()
	set(SYSTEM_DL_EXTENSION ".so")
else()
   message(FATAL_ERROR "Unsupported system")
endif()

IF (SYSTEM_NAME MATCHES "Mac")
	SET(PACKAGE_SUFFIX "mac${SUBSYSTEM_NAME}")
ELSE()
	IF (SYSTEM_NAME MATCHES "Win")
		SET(PACKAGE_SUFFIX_PREFIX "win")
	ELSEIF (SYSTEM_NAME MATCHES "Linux")
		SET(PACKAGE_SUFFIX_PREFIX "linux")
	ELSE()
		MESSAGE(FATAL_ERROR "Unsupported system")
	ENDIF()
	IF (SUBSYSTEM_NAME MATCHES "x86")
		SET(PACKAGE_SUFFIX_SUFFIX "32")
	ELSEIF (SUBSYSTEM_NAME MATCHES "x64")
		SET(PACKAGE_SUFFIX_SUFFIX "64")
	ELSE()
		MESSAGE(FATAL_ERROR "Unsupported system")
	ENDIF()
	SET(PACKAGE_SUFFIX "${PACKAGE_SUFFIX_PREFIX}${PACKAGE_SUFFIX_SUFFIX}")
ENDIF()

SET(SUBSYSTEM_PATH "${SYSTEM_NAME}/${SUBSYSTEM_NAME}")
