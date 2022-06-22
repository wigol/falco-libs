#
# OpenSSL
#
option(USE_BUNDLED_OPENSSL "Enable building of the bundled OpenSSL" ${USE_BUNDLED_DEPS})

if(OPENSSL_INCLUDE_DIR)
	# we already have openssl
elseif(NOT USE_BUNDLED_OPENSSL)
	find_package(OpenSSL REQUIRED)
	message(STATUS "Found OpenSSL: include: ${OPENSSL_INCLUDE_DIR}, lib: ${OPENSSL_LIBRARIES}")
else()
	set(OPENSSL_BUNDLE_DIR "${PROJECT_BINARY_DIR}/openssl-prefix/src/openssl")
	set(OPENSSL_INSTALL_DIR "${OPENSSL_BUNDLE_DIR}/target")
	set(OPENSSL_INCLUDE_DIR "${PROJECT_BINARY_DIR}/openssl-prefix/src/openssl/include/")
	set(OPENSSL_LIBRARY_SSL "${OPENSSL_INSTALL_DIR}/lib/libssl.a")
	set(OPENSSL_LIBRARY_CRYPTO "${OPENSSL_INSTALL_DIR}/lib/libcrypto.a")
 	set(OPENSSL_LIBRARIES ${OPENSSL_LIBRARY_SSL} ${OPENSSL_LIBRARY_CRYPTO})

	if(NOT TARGET openssl)
		message(STATUS "Using bundled openssl in '${OPENSSL_BUNDLE_DIR}'")

		ExternalProject_Add(openssl
			PREFIX "${PROJECT_BINARY_DIR}/openssl-prefix"
			URL "https://github.com/openssl/openssl/archive/OpenSSL_1_1_1p.tar.gz"
			URL_HASH "SHA256=cd0cce1de6c9a6da8f83ba7ae210a3662eab21c4df7aff30149597797b2ceac9"
			CONFIGURE_COMMAND ./config no-shared --prefix=${OPENSSL_INSTALL_DIR}
			BUILD_COMMAND ${CMD_MAKE}
			BUILD_IN_SOURCE 1
			BUILD_BYPRODUCTS ${OPENSSL_LIBRARY_SSL} ${OPENSSL_LIBRARY_CRYPTO}
			INSTALL_COMMAND ${CMD_MAKE} install_sw)
		install(FILES "${OPENSSL_LIBRARY_SSL}" DESTINATION "${CMAKE_INSTALL_LIBDIR}/${LIBS_PACKAGE_NAME}"
				COMPONENT "libs-deps")
		install(FILES "${OPENSSL_LIBRARY_CRYPTO}" DESTINATION "${CMAKE_INSTALL_LIBDIR}/${LIBS_PACKAGE_NAME}"
				COMPONENT "libs-deps")
		install(DIRECTORY "${OPENSSL_INCLUDE_DIR}" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${LIBS_PACKAGE_NAME}"
				COMPONENT "libs-deps")
	endif()
endif()

include_directories("${OPENSSL_INCLUDE_DIR}")
